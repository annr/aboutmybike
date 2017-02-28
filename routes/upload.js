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

/* Create bike record */
router.post('/', function(req, res, next) {
  var config = req.app.locals;
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
    var photo = files.bike_photo;
    var localPath = photo.path;

    // poor express error handling. the response is. an error, but is not properly returned as a readable one.
    // Error: /Users/arobson/Sites/aboutmybike/views/error.hbs: Can't set headers after they are sent.
    // at tleast it will bail out without uploading.
    // Fix this!!!!
    if(photo.size > config.maxPhotoSize) {
      res.status(500).json({ error: 'Photo too large.' });
      res.end();
    }

    if(photo.size < config.minPhotoSize) {
      res.status(500).json({ error: 'Photo too small.' });
      res.end();
    }

    if(config.acceptedFileTypes.indexOf(photo.type) === -1) {
      res.status(500).json({ error: 'Wrong file type.' });
      res.end();
    }

    var extension = photo.type.split('/')[1];
    if (extension === 'jpeg') extension = 'jpg'; 
    var filename = getFilename() + '.' + extension;

    if(localPath) {

      // I'm not sure if this readFile is necessary or if formidable will stream the data.
      fs.readFile(localPath, (err, data) => {

        if (err) throw err;

        var params = {Bucket: bucketName + destinationFolder, Key: filename, Body: data};
        s3.putObject(params, function(err, data) {
          if (err) {
            console.log(err)
          }
          else {
            //if there is no bike id, we must create the bike record.
            if(!fields.bike_id) {
              queries.createBike(fields, destinationFolder + '/' + filename, function(err, data) {
                if(err) {
                  next(err);
                } else {
                  fields.bike_id = data.id;
                  queries.createBikePhoto(fields, destinationFolder + '/' + filename, function(err, data) {
                    if(err) {
                      next(err);
                    } else {
                      req.user.bike_id = fields.bike_id;
                      console.log('setting bike_id on user...' + fields.bike_id + ' :: ' + req.user);
                      res.json({success : "Created bike and added photo", status : 200, id: fields.bike_id, photo_id: data.id });
                    }
                  });
                }
              });
            } else {
              queries.createBikePhoto(fields, destinationFolder + '/' + filename, function(err, data) {
                if(err) {
                  next(err);
                } else {
                  console.log(fields, destinationFolder + '/' + filename);
                  queries.updateMainPhoto(fields, destinationFolder + '/' + filename, function(err, data) {
                    if(err) {
                      next(err);
                    } else {
                      res.json({success : "Added photo and updated main image", status : 200, id: fields.bike_id });
                    }
                  });
                }
              });
            }
          }

        });

      });

    } else {
      throw err;
    }

  });

});

module.exports = router;
