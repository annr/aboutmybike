let fs = require('fs');
let config = require('../config').appConfig;
let AWS = require('aws-sdk');
AWS.config.region = config.rekognitionRegion; // Region
var rekognition = new AWS.Rekognition();
let s3 = new AWS.S3();
//let util = require('util');

/* 
 * validate photo
 *
 * takes a local path to a file to validate
*/

let run = function(localPath, callback) {
  fs.readFile(localPath, (err, data) => {
    // upload file to amb-processing and use rekognition to determine if it is most likely a bike
    // (new Date()).getTime();
    // use localPath name as upload name -- it should be unique.
    let filename = localPath.substr(localPath.lastIndexOf('/')+1);
    // fo some reason I wasn't able to add a folder to the path:
    //  InvalidS3ObjectException: Unable to get image metadata from S3.  Check object key, region and/or access permissions.
    // OR ValidationException: 1 validation error detected: Value 'amb-processing/validations' at 
    //   'image.s3Object.bucket' failed to satisfy constraint: Member must satisfy regular expression pattern: [0-9A-Za-z\.\-_]*
    let validationsFolder = 'validations';
    let fileData = data;
    if (err) throw err;

    let params = { Bucket: config.rekognitionBucket, Key: filename, Body: fileData };

    s3.putObject(params, function (err, fileData) {
      if (err) {
        throw new Error(`Error uploading image to ${bucketName} to validate bike photo: ${err}`);
      } else {
       var params = {
        Image: {
         S3Object: {
          Bucket: config.rekognitionBucket, 
          Name: filename
         }
        }, 
        MaxLabels: 123, 
        MinConfidence: 70
       };
       rekognition.detectLabels(params, function(err, data) {
         if (err) {
           throw new Error(err)
         } else {
           //console.log(util.inspect(data.Labels));
           var bikeLabel = data.Labels.find(function(label) {
             return (label.Name.toLowerCase() === 'bicycle' || label.Name.toLowerCase() === 'bike' )
           });
           if (bikeLabel && bikeLabel.Confidence > 70) {
            callback({ 
              message: 'bicycle', 
              confidence: bikeLabel.Confidence 
            });
           } else {
            callback({
              message: 'not_bicycle'
            });
           }
         }
       });
      }
    });
  });
};

module.exports = {
  run,
}
