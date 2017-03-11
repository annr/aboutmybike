const express = require('express');
const router = express.Router();
const formidable = require('formidable');
const helper = require('../helpers/bike');
const photoHelper = require('../helpers/photo');

/* Create bike record */
router.post('/', function (req, res, next) {
  const config = req.app.locals;
  let form = new formidable.IncomingForm();

  form.parse(req, function (err, fields, files) {
    let photo = files.bike_photo;
    let localPath = photo.path;

    if (localPath) {

      let filename;
      // 1) Create records if necessary.
      // if there is no bike id, we must create the bike record.
      if (!fields.bike_id) {

        helper.createBike(fields, function (err, bike_id) {
          if (err) {
            next(err);
          } else {

            photoHelper.storeOriginal(bike_id, localPath);

            photoHelper.optimizeAndStoreBig(bike_id, localPath, function(photoPath) {
              helper.createPhoto(fields, photoPath, function (err, data) {
                if (err) {
                  console.log(err);
                  next(err);
                } else {
                  // set bike_id on session user
                  req.user.bike_id = bike_id;
                  res.json({ success: 'Created bike, added photo, and updated bike photo with the name.', status: 200, id: fields.bike_id });
                }
              });

            });
          
          }
        });
      } else {

        photoHelper.storeOriginal(fields.bike_id, localPath);

        photoHelper.optimizeAndStoreBig(fields.bike_id, localPath, function(photoPath) {
          console.log('optimized photo and now creating photo record: ');
          helper.createPhoto(fields, photoPath, function (err, data) {
            if (err) {
              console.log(err);
              next(err);
            } else {
              // set bike_id on session user
              req.user.bike_id = fields.bike_id;
              res.json({ success: 'Created bike, added photo, and updated bike photo with the name.', status: 200, id: fields.bike_id });
            }
          });

        });
      }

     
    } else {
      throw err;
    }
  });
});

module.exports = router;
