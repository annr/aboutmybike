const express = require('express');
const router = express.Router();
const formidable = require('formidable');
const helper = require('../helpers/bike');
const photoHelper = require('../helpers/photo');
const validatePhoto = require('../helpers/validate_photo');
const prepPhoto = require('../helpers/prep_photo');
const storePhotos = require('../helpers/store_photos');
const util = require('util');
/* Create bike record */
router.post('/', function (req, res, next) {
  const config = req.app.locals;
  let form = new formidable.IncomingForm();

  form.parse(req, function (err, fields, files) {
    let photo = files.bike_photo;
    let localPath = photo.path;

    if (localPath) {
      // prepPromise overwrites local file. Hope nothing goes wrong!!!!
      prepPromise(localPath, fields).then(function(newPath) {

        validateAndUploadPhotos(newPath, fields).then(function(data) {
          if (data.message === 'not_bicycle') {
            res.json({ error: 'Bicycle not recognized or it is not the primary image in the photo. Please attach a clearer photo of your bike.', status: 200 });
            return;
          }
          if (!data.id) {
            throw new Error('Promise requires bike id returned as id.');
            res.json({ error: 'Could not upload bicycle photo', status: 200 });
            return;
          }
          if (!req.user.bike_id) {
            req.user.bike_id = data.id;
          }
          // upload the file the user attached.
          // We should capture original until we know how to process jpegs better. (jpegs are lossy)
          // But we are not going to save the path in the db. The file, if it needs to be found, can be easily.
          // It will be located in DESTINATION_FOLDER/originals/user_id/original_filename.(jpg|png)
          photoHelper.storeOriginal(localPath, parseInt(fields.user_id), fields.original_filename, function(err){
            if(err) {
              console.log('- - - - -');
              console.log('WARNING: could not store original....');
              console.log('- - - - -');
            }
          });
          res.json({ success: 'Cropped and validated photo, added bike record if nec., uploaded and added photo record', status: 200, id: data.id, photoPath: data.photoPath });
        }).catch(function(err) {
          console.log(err);
        });;

      }).catch(function(err) {
        console.log(err);
      });
    } else {
      throw err;
    }

  });

});

let prepPromise = function (photo_path, fields) {
  return new Promise(function(resolve, reject){
    prepPhoto.run(photo_path, fields, function(data) {
      resolve(data);
    });
  });
};

let validatePromise = function (photo_path) {
  return new Promise(function(resolve, reject){
    validatePhoto.run(photo_path, function(result) {
      resolve(result);
    });
  });
};

let storePromise = function (photo_path, fields) {
  return new Promise(function(resolve, reject) {
    storePhotos.run(photo_path, fields, function(data) {
      resolve(data);
    });
  });
};

let validateAndUploadPhotos = function(photo_path, fields) {

  return new Promise(function(resolve, reject) {

    // we either get a result from validation or data from upload.
    validatePromise(photo_path).then(function(result) {
      if(result.message === 'bicycle') {
        storePromise(photo_path, fields).then(function(data) {
          resolve(data);
        }).catch(function(err) {
          console.log(err);
        });

      } else {
        resolve(result);
      }
    }).catch(function(err) {
      console.log(err);
    });

  });
};

module.exports = router;
