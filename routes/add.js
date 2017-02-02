
var express = require('express');
var router = express.Router();

var formidable = require('formidable');
var AWS = require('aws-sdk');
var fs = require('fs');

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
  var ts = new Date().getTime();
  // Create an S3 client
  var s3 = new AWS.S3();
  var form = new formidable.IncomingForm();

  form.parse(req, function(err, fields, files) {

    console.log(files.bike_photo.path);
    var photoPath = files.bike_photo.path;

    if(photoPath !== undefined) {
      fs.readFile(photoPath, (err, data) => {
        if (err) throw err;
        console.log('gonna do it');
        var params = {Bucket: bucketName, Key: ts + '.jpg', Body: data};
        s3.putObject(params, function(err, data) {
          if (err)
            console.log(err)
          else
            console.log("Successfully uploaded " + ts + ".jpg");
        });
      });

    } else {
      throw err;
    }

  });


  res.render('upload', {
    status: 'okay'
  });

});

module.exports = router;
