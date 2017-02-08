
var express = require('express');
var router = express.Router();
var formidable = require('formidable');
var AWS = require('aws-sdk');
var fs = require('fs');

function getFilename() {
  var ts = new Date().getTime();
  // TO-DO: Limit timestamp to a day or so.
  return "aboutmybike-" + ts;
}

/* GET bike listing. */
router.get('/', function(req, res, next) {
  res.render('add', {
      app_name: res.locals.app.name,
      page_title: 'Add Your Bike'
    });
});

/* Create bike record */
router.post('/', function(req, res, next) {
  var bucketName = 'amb-storage';

  // TO-DO: add user id to file name so that the amount of photo uploads are controlled 
  // (the last uploaded be the user is overwritten)

  // Create an S3 client
  var s3 = new AWS.S3();
  var form = new formidable.IncomingForm();

  form.parse(req, function(err, fields, files) {

    var photoPath = files.bike_photo.path;
    var isSupportedImage = (files.bike_photo.type === 'image/jpeg') || (files.bike_photo.type === 'image/png');
    var extension = files.bike_photo.type.split('/')[1];
    if (extension === 'jpeg') extension = 'jpg'; 
    var filename = getFilename() + '.' + extension;
    if(photoPath && isSupportedImage) {

      // I'm not sure if this readFile is necessary or if formidable will stream the data.
      fs.readFile(photoPath, (err, data) => {
        if (err) throw err;
        console.log('gonna do it');
        var params = {Bucket: bucketName, Key: filename, Body: data};
        s3.putObject(params, function(err, data) {
          if (err)
            console.log(err)
          else
            console.log("Successfully uploaded " + filename + ".jpg");
        });
      });

    } else {
      throw err;
    }

  });

});

module.exports = router;
