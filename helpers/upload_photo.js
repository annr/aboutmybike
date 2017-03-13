let fs = require('fs');
let config = require('../config').appConfig;
let helper = require('../helpers/bike');
let photoHelper = require('../helpers/photo');

/* 
 * validate photo
 *
 * takes a local path to a file to validate
*/

let run = function(localPath, fields, callback) {
  fs.readFile(localPath, (err, data) => {
    if (err) throw err;

    if (!fields.bike_id) {

      helper.createBike(fields, function (err, bike_id) {
        if (err) {
          next(err);
        } else {
          fields.bike_id = bike_id;
          photoHelper.storeOriginal(fields, localPath);
          photoHelper.optimizeAndStoreBig(fields, localPath, function(photoPath) {
            helper.createPhoto(fields, photoPath, function (err, data) {
              if (err) {
                throw err;
              } else {
                // return bike_id to set on user session.
                callback({ message: 'Added photo, and updated bike photo with the name.', id: data.bike_id, photoPath: config.s3Url + photoHelper.replacePathWildcard(photoPath) }); // or fields.bike_id
              }
            });
          });
        }
      });
    } else {
      photoHelper.storeOriginal(fields, localPath);

      photoHelper.optimizeAndStoreBig(fields, localPath, function(photoPath) {
        console.log('optimized photo and now creating photo record: ');
        helper.createPhoto(fields, photoPath, function (err, data) {
          if (err) {
            throw err;
          } else {
            // set bike_id on session user
            // REPRO:
            //req.user.bike_id = fields.bike_id;
            callback({ message: 'Created bike, added photo, and updated bike photo with the name.', id: fields.bike_id, photoPath: config.s3Url + photoHelper.replacePathWildcard(photoPath) });
          }
        });

      });
    }
  });
}

module.exports = {
  run,
};
