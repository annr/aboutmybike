const express = require('express');
const router = express.Router();
const formidable = require('formidable');
const helper = require('../helpers/bike');
const photoHelper = require('../helpers/photo');
const validatePhoto = require('../helpers/validate_photo');
const cropPhoto = require('../helpers/crop_photo');
const uploadPhoto = require('../helpers/upload_photo');

/* Create bike record */
router.post('/', function (req, res, next) {
  const config = req.app.locals;
  let form = new formidable.IncomingForm();

  form.parse(req, function (err, fields, files) {
    let photo = files.bike_photo;
    let localPath = photo.path;

    if (localPath) {
      // upload does a few things:
      // 1) crops image if necessary
      if (photoHelper.hasCompleteCropObject(fields)) {
        cropPromise(localPath, fields).then(function() {
          validateAndUploadPhoto(localPath, fields).then(function(data) {
            if (!data.id) throw new Error('Promise requires bike id returned as id.');
            if (!req.user.bike_id) {
              req.user.bike_id = data.id;
            }
            res.json({ success: 'Cropped photo, validated photo, added bike record if nec., uploaded, and updated or added photo record', status: 200, id: data.id, photoPath: data.photoPath });
          }).catch(function(err) {
            console.log(err);
          });;
        }).catch(function(err) {
          console.log(err);
        });
      } else {
        // two ways to get here. after crop or by default as in this case.
        validateAndUploadPhoto(localPath, fields).then(function(data) {
          if (!data.id) throw new Error('Promise requires bike id returned as id.');
          if (!req.user.bike_id) {
            req.user.bike_id = data.id;
          }
          res.json({ success: 'Validated photo, added bike record if nec., uploaded, and updated or added photo record', status: 200, id: data.id, photoPath: data.photoPath });
        }).catch(function(err) {
          console.log(err);
        });
      }
    } else {
      throw err;
    }

  });

});

let cropPromise = function (photo_path, fields) {
  return new Promise(function(resolve, reject){
    cropPhoto.run(photo_path, fields, function(data) {
      resolve('message from inside crop: ' + data.message);
    });
  });
};

let validatePromise = function (photo_path) {
  return new Promise(function(resolve, reject){
    validatePhoto.run(photo_path, function(data) {
      resolve('message from validate: ' + data.message);
    });
  });
};

let uploadPromise = function (photo_path, fields) {
  return new Promise(function(resolve, reject) {
    uploadPhoto.run(photo_path, fields, function(data) {
      resolve(data);
    });
  });
};

let validateAndUploadPhoto = function(photo_path, fields) {

  return new Promise(function(resolve, reject) {

    validatePromise(photo_path).then(function(successMessage) {

      uploadPromise(photo_path, fields).then(function(data) {
        resolve(data);
      }).catch(function(err) {
        console.log(err);
      });

    }).catch(function(err) {
      console.log(err);
    });

  });
;
};

module.exports = router;
