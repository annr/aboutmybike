let fs = require('fs');
let config = require('../config').appConfig;
let AWS = require('aws-sdk');
AWS.config.region = config.rekognitionRegion; // Region
var rekognition = new AWS.Rekognition();
let s3 = new AWS.S3();

/* 
 * validate photo
 *
 * takes a local path to a file to validate
*/

let run = function(localPath, callback) {
  fs.readFile(localPath, (err, data) => {
    // upload file to amb-processing and use rekognition to determine if it is most likely a bike
    let fileData = data;
    let filename = 'test-image.jpg';
    if (err) throw err;

    let params = { Bucket: config.rekognitionBucket, Key: filename, Body: fileData };

    s3.putObject(params, function (err, fileData) {
      console.log('reguin: ' + AWS.config.region);
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
           var bikeLabel = data.Labels.find(function(label) {
             return (label.Name.toLowerCase() === 'bicycle' || label.Name.toLowerCase() === 'bike' )
           });
           if (bikeLabel && bikeLabel.Confidence > 80) {
            callback({ 
              message: 'bicycle', 
              confidence: bikeLabel.Confidence 
            });
           } else {
            callback({ 
              message: 'Bicycle not recognized or it is not the primary image in the photo. Please attach a clearer photo of your bike.'
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
