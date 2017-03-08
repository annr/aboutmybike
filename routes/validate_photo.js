let express = require('express');
let router = express.Router();
let formidable = require('formidable');
let AWS = require('aws-sdk');
AWS.config.region = 'us-west-2'; // Region
let fs = require('fs');
var rekognition = new AWS.Rekognition();

/* Create bike record */
router.post('/', function (req, res, next) {
  
  let config = req.app.locals;
  let bucketName = 'amb-processing';
  let filename = 'test-image.jpg';

  // TO-DO: add user id to file name so that the amount of photo uploads are controlled
  // (the last uploaded be the user is overwritten)
  // Create an S3 client
  let s3 = new AWS.S3();
  let form = new formidable.IncomingForm();

  form.parse(req, function (err, fields, files) {
    let photo = files.bike_photo;
    let localPath = photo.path;

    // poor express error handling. the response is an error, but is not properly returned as a readable one.
    // Error: /Users/arobson/Sites/aboutmybike/views/error.hbs: Can't set headers after they are sent.
    // at tleast it will bail out without uploading.
    // Fix this!!!!
    if (photo.size > config.maxPhotoSize) {
      res.status(500).json({ error: 'Photo too large.' });
      res.end();
    }

    if (photo.size < config.minPhotoSize) {
      res.status(500).json({ error: 'Photo too small.' });
      res.end();
    }

    if (config.acceptedFileTypes.indexOf(photo.type) === -1) {
      res.status(500).json({ error: 'Wrong file type.' });
      res.end();
    }

    let extension = photo.type.split('/')[1];
    if (extension === 'jpeg') extension = 'jpg';

    if (localPath) {
      //

      // I'm not sure if this readFile is necessary or if formidable will stream the data.
      fs.readFile(localPath, (err, data) => {
        // upload file to amb-processing and use rekognition to determine if it is most likely a bike
        let fileData = data;

        // we have to create the records before we upload the photo because the file name will include the bike_id
        // we do this so that we can overwrite the bike photo on the server for a single bike.

        if (err) throw err;

        // 1) Create records if necessary.
        // if there is no bike id, we must create the bike record.

        let params = { Bucket: bucketName, Key: filename, Body: fileData };
        s3.putObject(params, function (err, fileData) {
          if (err) {
            console.log(`Error uploading image to ${bucketName} to validate bike photo: ${err}`);
          } else {
           var params = {
            Image: {
             S3Object: {
              Bucket: bucketName, 
              Name: filename
             }
            }, 
            MaxLabels: 123, 
            MinConfidence: 70
           };
           rekognition.detectLabels(params, function(err, data) {
             if (err) {
               console.log(err, err.stack); // an error occurred
               next(err);
             } else {

               var bikeLabel = data.Labels.find(function(label) {
                 return (label.Name.toLowerCase() === 'bicycle' || label.Name.toLowerCase() === 'bike' )
               });
               if (bikeLabel && bikeLabel.Confidence > 80) {
                 res.status(200).json({ message: 'bicycle', confidence: bikeLabel.Confidence });
               } else {
                 res.status(200).json({ message: 'no_bicycle' });
               }
             }
           });


          }
        });
      });
    } else {
      throw err;
    }
  });
});

module.exports = router;
