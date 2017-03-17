const im = require('imagemagick');
const AWS = require('aws-sdk');
const fs = require('fs');
const s3 = new AWS.S3();
const MM = getTwoDigitMonth();
let config = require('../config').appConfig;

let rootFolder = '/dev';
if (process.env.RDS_HOSTNAME !== undefined) {
  rootFolder = '/photos';
}

const DESTINATION_FOLDER = `${rootFolder}/2017-${MM}`;

/* PRIVATE FUNCTIONS */
function getFilename(bike_id, size) {
  let version = size || 'o';
  // limits main photo by bike id by day. We'll retain new photos if they are not added too often.
  let impreciseTs = ((new Date()).setHours(0, 0, 0, 0)/10000);
  return `${bike_id}-${impreciseTs}_${version}`;
}

function getTwoDigitMonth() {
  var paddedMonth = (new Date().getMonth() + 1)+"";
  if(paddedMonth.length === 1) {
    paddedMonth = "0" + paddedMonth;
  }
  return paddedMonth;
}

function getExtension(photo) {
  // let extension = photo.type.split('/')[1];
  // if (extension.toLowerCase() === 'jpeg') {
  //   extension = 'jpg';
  // }
  //return extension;
  return 'jpg';
}

//function replacePathWildcard(path, size_key) {
function replacePathWildcard(path) {
  return path.replace('{*}', 'b');
}

/* EXPOSED FUNCTIONS */

// bike_id is required to generate filename
let storeOriginal = function(fields, photo) {

  if(!fields.bike_id) {
    throw new Error('bike_id not set');
  }

  var filename = `${getFilename(fields.bike_id, 'o')}.${getExtension()}`;

  fs.readFile(photo, (err, fileData) => {

    if (err) throw err;

    let params = { Bucket: config.s3Bucket + DESTINATION_FOLDER, Key: filename, Body: fileData };
    s3.putObject(params, function (err, fileData) {
      if (err) {
        if (err) throw err;
      }
    });

  });

}

let hasCompleteCropObject = function(fields) {
  if (fields) {
    if (fields.cropWidth !== '' && fields.cropHeight !== '' && fields.xValue !== '' && fields.yValue !== '') {
      return true;
    }
  }
  return false;
}

let optimizeAndStoreCopies = function(fields, photo, callback) {
  if(!fields.bike_id) {
    throw new Error('bike_id not set');
  }
  var tmpDirectory = photo.substr(0, photo.lastIndexOf('/')+1);
  var tmpFilename = tmpDirectory + fields.bike_id + '-' + (new Date()).getTime();
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

    // here we automatically normalize to 4:3 if necesssary. modal select area cropping is doen before this step
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

      im.resize(resizeOptions, function(err, stdout, stderr){
        if (err) throw err;

        var filename = `${getFilename(fields.bike_id, 'b')}.${getExtension()}`;
        let s3Params = { Bucket: config.s3Bucket + DESTINATION_FOLDER, Key: filename };

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
        callback(`${DESTINATION_FOLDER}/${params.Key}`);
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
}

