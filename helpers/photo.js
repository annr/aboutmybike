const im = require('imagemagick');
const AWS = require('aws-sdk');
const fs = require('fs');
const s3 = new AWS.S3();
const MM = getTwoDigitMonth();
let config = require('../config').appConfig;
let util = require('util');

let rootFolder = '/dev';
if (process.env.RDS_HOSTNAME !== undefined) {
  rootFolder = '/photos';
}

const DESTINATION_FOLDER = `${rootFolder}/2017-${MM}`;

/* PRIVATE FUNCTIONS */
function getTemplateFilename(bike_id) {
  let extension = '.jpg';
  // limits main photo by bike id by day. We'll retain new photos if they are not added too often.
  let impreciseTs = ((new Date()).setHours(0, 0, 0, 0)/10000);
  return '' + bike_id + '-' + impreciseTs + '_{*}' + extension;
}

function getTwoDigitMonth() {
  var paddedMonth = (new Date().getMonth() + 1)+"";
  if(paddedMonth.length === 1) {
    paddedMonth = "0" + paddedMonth;
  }
  return paddedMonth;
}

//function replacePathWildcard(path, size_key) {
function replacePathWildcard(path, size) {
  let version = size || 'b';
  return path.replace('{*}', version);
}

let hasCompleteCropObject = function(fields) {
  if (fields) {
    if (fields.cropWidth !== '' && fields.cropHeight !== '' && fields.xValue !== '' && fields.yValue !== '') {
      return true;
    }
  }
  return false;
}

let extractDirectoryOfPath = function(str) {
  if(!str) {
    throw new Error(`file path not passed`);
  }
  return str.substr(0, str.lastIndexOf('/')+1);;
}
// not currently used.
let getPhotoProperties = function(photo, callback) {
  im.identify(photo, function(err, img) {
    if (err) throw err;
    callback(img);
  });
};

let convertToJpeg = function(srcPath, tmpPath, callback) {
  im.convert([srcPath, tmpPath], function(err) {
    if (err) throw err;
    callback();
  });
};

let getStoredPath = function(bike_id) {
  return getTemplateFilename(bike_id);
};

let getFullStoredPath = function(bike_id) {
  return DESTINATION_FOLDER + '/' + getStoredPath(bike_id);
};

let optimizeAndStoreCopies = function(bike_id, localPath, storedPath, callback) {
  // prepped (/aboutmybike/helpers/prep_photo.js). now:
  // 1) reduce pixel width if nec.
  // 2) reduce quality
  // 3) make progressive

  if(!bike_id) {
    throw new Error('bike_id not set');
  }

  // only create one version for now.
  let size_key = 'b';
  let dstPath = localPath + '-' + size_key;
  let newWidth = 1024;

  var resizeOptions = {
    srcPath: localPath,
    dstPath: dstPath,
    //quality: quality, // will default to 0.8
    progressive: true,
    width: newWidth,
    //strip: true,
    //sharpening: 0.2
  }

  // prepped (/aboutmybike/helpers/prep_photo.js). now:
  // 1) reduce pixel width if nec.
  // 2) reduce quality
  // 3) make progressive

  im.resize(resizeOptions, function(err, stdout, stderr){
    if (err) throw err;
    let s3Params = { Bucket: config.s3Bucket + DESTINATION_FOLDER, Key: replacePathWildcard(storedPath, 'b') };
    readAndStoreFile(dstPath, s3Params, function() {
      fs.unlink(dstPath);
      callback();
    });
  });

};

// always passes file path to callback.
function readAndStoreFile(pathToFile, s3Params, callback) {
  let params = s3Params;
  fs.readFile(pathToFile, (err, data) => {
    if (err) throw err;
    // s3Params are complete with the exception of `Body`, the readFile data.
    params.Body = data;
    s3.putObject(params, function (err) {
      if (err) {
        console.log(`Error uploading ${pathToFile}: ${err}`);
      }
      callback();
    });
  });
}

module.exports = {
  optimizeAndStoreCopies,
  replacePathWildcard,
  readAndStoreFile,
  getStoredPath,
  getFullStoredPath
}

