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
function getTemplateFilename(bike_id, format) {
  let extension = (format === 'PNG') ? '.png' : '.jpg';
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
function replacePathWildcard(path) {
  return path.replace('{*}', 'b');
}

/* EXPOSED FUNCTIONS */

// bike_id is required to generate filename
// we store the "original" but we use a different filename. 
// this requires us to know if it's a png or jpg
// I don't think the temporary filename includes the extension.

let storeOriginal = function(bike_id, photo, photoPath, callback) {
  if(!bike_id) {
    throw new Error('bike_id not set');
  }
  console.log('check photo path ' + replacePathWildcard(photoPath, 'o'));
  let s3Params = { Bucket: config.s3Bucket + DESTINATION_FOLDER, Key: replacePathWildcard(photoPath, 'o') };
  readAndStoreFile(photo, s3Params);
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

let getPhotoProperties = function(photo, callback) {
  im.identify(photo, function(err, img) {
    if (err) throw err;
    callback(img);
  });
};

let getPhotoPath = function(bike_id, localPath, callback) {
  getPhotoProperties(localPath, function(img) {
    callback(DESTINATION_FOLDER + '/' + getTemplateFilename(bike_id, img.format));  
  });
}; 

let optimizeAndStoreCopies = function(bike_id, photo, callback) {
  if(!bike_id) {
    throw new Error('bike_id not set');
  }
  var tmpDirectory = extractDirectoryOfPath(photo);
  var tmpFilename = tmpDirectory + bike_id + '-' + (new Date()).getTime();
  var tmpPath = `${tmpFilename}-tmp.jpg`;
  var dstPath = `${tmpFilename}.jpg`;

  im.identify(photo, function(err, img){
    if (err) throw err;
    let height = img.height;
    let width = img.width;
    let ratio = Math.round((height/width) * 100)/100;

    // default 4:3 ratio
    // all this will do is change the quality.
    var options = {
      srcPath: photo,
      dstPath: tmpPath,
      width: width,
      format: 'jpg',
      height: height,
    };

    // here we automatically normalize to 4:3 if necesssary. modal select area cropping is applied before this step
    // and so we can safely crop from the gravity "Center" (the default. vs NorthWest).
    if (ratio > 0.75) {
      options.width = width;
      options.height = Math.floor(width*0.75);
    } else if (ratio < 0.75) {
      options.width = Math.round(height*1.3333333333);
      options.height = height;
    }

    // crop and change graphics format if nec.
    im.crop(options, function(err, stdout, stderr){

      // default optimization:
      var quality = 0.7;

      // only reduce the quality if the file has not already been optimzed.
      if(img.quality && img.quality <= 0.8) {
        //unsetting the quality value:
        quality = 1;
      }

      // make a bunch of versions here, including tiny.
      var newWidth = (width < 1024) ? width : 1024;

      // m

      var resizeOptions = {
        srcPath: tmpPath,
        dstPath: dstPath,
        quality: quality,
        progressive: true,
        width: newWidth,
        strip: true,
        //sharpening: 0.2
      }

      // cropped. now:
      // 1) reduce pixel width if nec.
      // 2) reduce quality
      // 3) make progressive

      // Go through all sizes. Only in the case of the one size run callback. 
      //config.mainImageSizes.forEach();

      console.log('check photo path ' + replacePathWildcard(photoPath, 'b'));
      im.resize(resizeOptions, function(err, stdout, stderr){
        if (err) throw err;
        let s3Params = { Bucket: config.s3Bucket + DESTINATION_FOLDER, Key: replacePathWildcard(photoPath, 'b') };
        readAndStoreFile(dstPath, s3Params, callback);
      });

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
      } else {
        // this should next create photo
        if(callback) { // storing original doens't have callback
          callback(`${DESTINATION_FOLDER}/${params.Key}`);
        }
      }
    });
  });
}

module.exports = {
  storeOriginal,
  optimizeAndStoreCopies,
  hasCompleteCropObject,
  replacePathWildcard,
  readAndStoreFile,
  getPhotoPath
}

