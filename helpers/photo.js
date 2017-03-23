const im = require('imagemagick');
const AWS = require('aws-sdk');
const fs = require('fs');
const s3 = new AWS.S3();
let config = require('../config').appConfig;
let util = require('util');

let rootFolder = '/dev';
if (process.env.ENVIRONMENT !== undefined) {
  rootFolder = '/' + process.env.ENVIRONMENT;
}

const MM = getTwoDigitDate(new Date().getMonth() + 1);
const DD = getTwoDigitDate(new Date().getDate());
const YYYY = new Date().getFullYear();
const DESTINATION_FOLDER = `${rootFolder}/${YYYY}-${MM}-${DD}`;

/* PRIVATE FUNCTIONS */
function getTemplateFilename(bike_id) {
  let extension = '.jpg';
  // limits main photo by bike id by day. We'll retain new photos if they are not added too often.
  let impreciseTs = ((new Date()).setHours(0, 0, 0, 0)/10000);
  return '' + bike_id + '-' + impreciseTs + '_{*}' + extension;
}

function getTwoDigitDate(toPad) {
  var padded = toPad +"";
  if(padded.length === 1) {
    padded = "0" + padded;
  }
  return padded;
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

let storeOriginal = function(localPath, userId, originalFilename, callback) {
  let filePath = DESTINATION_FOLDER + '/originals/' + userId;
  let s3Params = { Bucket: config.s3Bucket + filePath, Key: originalFilename};
  // in this case don't unlink uploaded file -- it's not a copy.
  readAndStoreFile(localPath, s3Params, function(err) {
    if (err) {
      console.log(`Error uploading to ${filePath}/${original_filename}: ${err}`);
    }
    callback(err);
  });
};

let optimizeAndStoreCopies = function(localPath, storedPath, callback) {
  config.mainImageSizes.forEach(function(copy) {
    optimizeAndStoreCopy(localPath, storedPath, copy.size_key, copy.width, copy.height);
  });
  // will this work? -- the function that is called in the loop is asncy.
  callback();
};

let optimizeAndStoreCopy = function(localPath, storedPath, sizeKey, width, height) {
  // prepped (/aboutmybike/helpers/prep_photo.js). now:
  // 1) reduce pixel width if nec.
  // 2) reduce quality
  // 3) make progressive
  let dstPath = localPath + '-' + sizeKey;

  // we need to set width and height

  var resizeOptions = {
    srcPath: localPath,
    dstPath: dstPath,
    progressive: true,
    quality: 0.85, // 0.8 is a little too grungy.
    width: width,
    height: height,
    strip: true, // strip metadata hopefully.
  }

  if(width && height) { // if these aren't set, just upload loca file.
    im.resize(resizeOptions, function(err, stdout, stderr){
      if (err) throw err;
      let s3Params = { Bucket: config.s3Bucket + DESTINATION_FOLDER, Key: replacePathWildcard(storedPath, sizeKey) };
      readAndStoreFile(dstPath, s3Params, function() {
        fs.unlinkSync(dstPath);
      });
    });
  } else {
    let s3Params = { Bucket: config.s3Bucket + DESTINATION_FOLDER, Key: replacePathWildcard(storedPath, sizeKey) };
    // in this case don't unlink uploaded file -- it's not a copy.
    readAndStoreFile(localPath, s3Params, function() {});
  }

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
      callback(err);
    });
  });
}

module.exports = {
  optimizeAndStoreCopies,
  replacePathWildcard,
  readAndStoreFile,
  getStoredPath,
  getFullStoredPath,
  getPhotoProperties,
  storeOriginal,
}

