
var express = require('express');
var router = express.Router();
var formidable = require('formidable');
var AWS = require('aws-sdk');
var fs = require('fs');

let queries = require('../db/queries');

function getFilename() {
  var ts = new Date().getTime();
  // TO-DO: Limit timestamp to a day or so.
  return "aboutmybike-" + ts;
}

/* GET upload form. */
router.get('/', function(req, res, next) {
  res.render('add_some', {
      app_name: res.locals.app.name,
      page_title: 'Add Your Bike'
    });
});

/* Create bike record */
router.post('/', function(req, res, next) {
  var bucketName = 'amb-storage';

  var rootFolder = '/dev';
  if(process.env.RDS_HOSTNAME !== undefined) {
    rootFolder = '/photos';
  }
  var destinationFolder = rootFolder + '/2017-001';

  // TO-DO: add user id to file name so that the amount of photo uploads are controlled 
  // (the last uploaded be the user is overwritten)

  // Create an S3 client
  var s3 = new AWS.S3();
  var form = new formidable.IncomingForm();

  form.parse(req, function(err, fields, files) {

    var localPath = files.bike_photo.path;
    var isSupportedImage = (files.bike_photo.type === 'image/jpeg') || (files.bike_photo.type === 'image/png');
    var extension = files.bike_photo.type.split('/')[1];
    if (extension === 'jpeg') extension = 'jpg'; 
    var filename = getFilename() + '.' + extension;
    if(localPath && isSupportedImage) {

      // I'm not sure if this readFile is necessary or if formidable will stream the data.
      fs.readFile(localPath, (err, data) => {
        if (err) throw err;
        var params = {Bucket: bucketName + destinationFolder, Key: filename, Body: data};
        s3.putObject(params, function(err, data) {
          if (err)
            console.log(err)
          else
            console.log("Successfully uploaded " + filename);
            queries.createBike(fields, destinationFolder + '/' + filename, function(err, data) {
              if(err) {
                next(err);
              } else {
                // go to the addmore page with the bike object
                //res.redirect('addmore', data);
                res.redirect('/bike/'+data.id);
              }
            });
        });
      });

    } else {
      throw err;
    }

  });

});

module.exports = router;
