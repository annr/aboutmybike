var express = require('express');
var router = express.Router();
var formidable = require('formidable');
var AWS = require('aws-sdk');
var fs = require('fs');

let queries = require('../db/queries');

function getFilename(bike_id) {
  var ts = new Date();
  var dayTs = ts.setHours(0,0,0,0);
  // TO-DO: Limit timestamp to a day or so.
  return "aboutmybike-" + bike_id + "-" + dayTs;
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

    // we need to get bike_id before we create the bike record.
    // RACE CONDITION ALERT!!!!!
    //var filename = getFilename() + '.' + extension;

    if(localPath) {

      // I'm not sure if this readFile is necessary or if formidable will stream the data.
      fs.readFile(localPath, (err, data) => {

        var fileData = data;
        var filename;

        // we have to create the records before we upload the photo because the file name will include the bike_id
        // we do this so that we can overwrite the bike photo on the server for a single bike.

        if (err) throw err;

        // 1) Create records if necessary. 
        //if there is no bike id, we must create the bike record.
        if(!fields.bike_id) {
          queries.createBike(fields, function(err, data) {
            if(err) {
              next(err);
            } else {
              filename = getFilename(data.id) + '.' + extension;
              fields.bike_id = data.id;
              var params = {Bucket: bucketName + destinationFolder, Key: filename, Body: fileData};
              s3.putObject(params, function(err, fileData) {
                if (err) {
                  console.log(err)
                }
                else {
                  queries.createBikePhoto(fields, destinationFolder + '/' + filename, function(err, data) {
                    if(err) {
                      next(err);
                    } else {
                      // set bike_id on session user
                      req.user.bike_id = fields.bike_id;
                      res.json({success : "Created bike, added photo, and updated bike photo with the name.", status : 200, id: fields.bike_id});
                    }
                  });
                }
              });
            }
          });
        } else {

          filename = getFilename(fields.bike_id) + '.' + extension;
          var params = {Bucket: bucketName + destinationFolder, Key: filename, Body: fileData};
          s3.putObject(params, function(err, fileData) {
            if (err) {
              console.log(err)
            }
            else {
              queries.createBikePhoto(fields, destinationFolder + '/' + filename, function(err, data) {
                if(err) {
                  next(err);
                } else {
                  // set bike_id on session user
                  req.user.bike_id = fields.bike_id;
                  // bike record exists, and there is probably an associated photo.
                  // For now, we'll just create a new record in the db; this does not mean we have a duplicate photo on S3.
                  // The justification is that we'll have a new created_at value and it will show us the most recent like an update_at value.
                  // since the path is stored on the bike table, we don't have to worry about selecting the wrong one.
                  queries.createBikePhoto(fields, destinationFolder + '/' + filename, function(err, data) {
                    if(err) {
                      next(err);
                    } else {
                      res.json({success : "Created another record for the main photo", status : 200, id: fields.bike_id});
                    }
                  });
                }
              });
            }
          });

        }

      });

    } else {
      throw err;
    }

  });

});

module.exports = router;
