const im = require('imagemagick');
const AWS = require('aws-sdk');
const fs = require('fs');
const s3 = new AWS.S3();
const bucketName = 'amb-storage';
const monthString = getTwoDigitMonth();

let rootFolder = '/dev';
if (process.env.RDS_HOSTNAME !== undefined) {
  rootFolder = '/photos';
}
let destinationFolder = `${rootFolder}/2017-${monthString}`;

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

/* EXPOSED FUNCTIONS */

// bike_id is required to generate filename
let storeOriginal = function(bike_id, photo) {

  var filename = `${getFilename(bike_id, 'o')}.${getExtension()}`;

  fs.readFile(photo, (err, fileData) => {

    if (err) throw err;

    let params = { Bucket: bucketName + destinationFolder, Key: filename, Body: fileData };
    s3.putObject(params, function (err, fileData) {
      if (err) {
        if (err) throw err;
      }
    });

  });

}

// bike_id is required to generate filename
let optimizeAndStoreMedium = function(bike_id, photo) {
  var tmpDirectory = photo.substr(0, photo.lastIndexOf('/')+1);
  var tmpFilename = tmpDirectory + bike_id + '-' + (new Date()).getTime();
  var tmpPath = `${tmpFilename}-tmp.jpg`;
  var dstPath = `${tmpFilename}.jpg`;

  var filename = `${getFilename(bike_id, 'o')}.${getExtension()}`;

  fs.readFile(photo, (err, fileData) => {

    if (err) throw err;

    let params = { Bucket: bucketName + destinationFolder, Key: filename, Body: fileData };
    s3.putObject(params, function (err, fileData) {
      if (err) {
        if (err) throw err;
      }
    });

  });
}

let optimizeAndStoreBig = function(bike_id, photo, callback) {
  var tmpDirectory = photo.substr(0, photo.lastIndexOf('/')+1);
  var tmpFilename = tmpDirectory + bike_id + '-' + (new Date()).getTime();
  var tmpPath = `${tmpFilename}-tmp.jpg`;
  var dstPath = `${tmpFilename}.jpg`;

  im.identify(photo, function(err, img){
    if (err) throw err;
    var height = img.height;
    var width = img.width;

    // default 4:3 ratio
    // all this will do is change the quality.
    var options = {
      srcPath: photo,
      dstPath: tmpPath,
      width: width,
      format: 'jpg',
      height: height
    };

    if (height/width > 0.75) {
      options.width = width;
      options.height = Math.floor(width*0.75);
    } else {
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

      var newWidth = (width < 1024) ? width : 1024;

      var resizeOptions = {
        srcPath: tmpPath,
        dstPath: dstPath,
        quality: quality,
        progressive: true,
        width: newWidth,
        strip: true,
        //filter: 'Lagrange',
        sharpening: 0.2
      }

      // cropped. now:
      // 1) reduce pixel width if nec.
      // 2) reduce quality
      // 3) make progressive

      im.resize(resizeOptions, function(err, stdout, stderr){
        if (err) throw err;

        fs.readFile(dstPath, (err, data) => {
          // now store that new image:
          var filename = `${getFilename(bike_id, 'b')}.${getExtension()}`;
          let params = { Bucket: bucketName + destinationFolder, Key: filename, Body: data };
          console.log('storing optimized: ' + filename);

          if (err) throw err;

          s3.putObject(params, function (err) {
            if (err) {
              console.log(`Error uploading ${filename}: ${err}`);
            } else {
              // this should next create photo
              console.log(`this should next create photo: ${destinationFolder}/${filename}`);
              callback(`${destinationFolder}/${filename}`);
            }
          });

        });

      });
    });
  });


};

module.exports = {
  storeOriginal,
  optimizeAndStoreBig,
}

