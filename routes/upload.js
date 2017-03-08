let express = require('express');
let router = express.Router();
let formidable = require('formidable');
let AWS = require('aws-sdk');
let fs = require('fs');
var im = require('imagemagick');

let helper = require('../helpers/bike');

function getFilename(bike_id) {
  let ts = new Date();
  let impreciseTs = (ts.setHours(0, 0, 0, 0)/10000);

  console.log('impreciseTS ' + impreciseTs);
  // TO-DO: Limit timestamp to a day or so.
  return `aboutmybike-${bike_id}-${impreciseTs}`;
}

function getOriginalFilePath(bike_id) {
  let ts = new Date();
  let dayTs = ts.setHours(0, 0, 0, 0);
  // TO-DO: Limit timestamp to a day or so.
  return `aboutmybike-${bike_id}-${dayTs}`;
}

/* Create bike record */
router.post('/', function (req, res, next) {
  let config = req.app.locals;
  let bucketName = 'amb-storage';

  let rootFolder = '/dev';
  if (process.env.RDS_HOSTNAME !== undefined) {
    rootFolder = '/photos';
  }
  let destinationFolder = `${rootFolder}/2017-001`;
  let originalsFolder = `${rootFolder}/2017-001/originals`;

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
        let filename;

        // we have to create the records before we upload the photo because the file name will include the bike_id
        // we do this so that we can overwrite the bike photo on the server for a single bike.

        if (err) throw err;

        // 1) Create records if necessary.
        // if there is no bike id, we must create the bike record.
        if (!fields.bike_id) {
          helper.createBike(fields, function (err, bike_id) {
            if (err) {
              next(err);
            } else {
              filename = `${getFilename(data.id)}.${extension}`;
              fields.bike_id = bike_id;
              let params = { Bucket: bucketName + destinationFolder, Key: filename, Body: fileData };

              let paramsOriginal = params;
              paramsOriginal.Bucket = bucketName + originalsFolder;

              s3.putObject(paramsOriginal, function (err, fileData) {
                if (err) {
                  console.log('Error uploading original upon creation of new bike record. ' + err);
                }
              });

              s3.putObject(params, function (err, fileData) {
                if (err) {
                  console.log(err);
                } else {
                  helper.createPhoto(fields, `${destinationFolder}/${filename}`, function (err, data) {
                    if (err) {
                      next(err);
                    } else {
                      // set bike_id on session user
                      req.user.bike_id = fields.bike_id;
                      res.json({ success: 'Created bike, added photo, and updated bike photo with the name.', status: 200, id: fields.bike_id });
                    }
                  });
                }
              });
            }
          });
        } else {
          filename = `${getFilename(fields.bike_id)}.${extension}`;
          let params = { Bucket: bucketName + destinationFolder, Key: filename, Body: fileData };
          let paramsOriginal = Object.assign({}, params);

          paramsOriginal.Bucket = bucketName + originalsFolder;
          console.log('confirm orig bucket: ' + paramsOriginal.Bucket);

          s3.putObject(paramsOriginal, function (err, fileData) {
            if (err) {
              console.log('Error uploading original for replacement image. ' + err);
            }
          });

          s3.putObject(params, function (err, fileData) {
            if (err) {
              console.log(err);
            } else {
              helper.createPhoto(fields, `${destinationFolder}/${filename}`, function (err, data) {
                if (err) {
                  next(err);
                } else {
                  // set bike_id on session user
                  req.user.bike_id = fields.bike_id;
                  // bike record exists, and there is probably an associated photo.
                  // For now, we'll just create a new record in the db; this does not mean we have a duplicate photo on S3.
                  // The justification is that we'll have a new created_at value and it will show us the most recent like an update_at value.
                  // since the path is stored on the bike table, we don't have to worry about selecting the wrong one.
                  helper.createPhoto(fields, `${destinationFolder}/${filename}`, function (err, data) {
                    if (err) {
                      next(err);
                    } else {
                      res.json({ success: 'Created another record for the main photo', status: 200, id: fields.bike_id });
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
