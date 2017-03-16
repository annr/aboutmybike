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
            // error will be thrown if there is an issue creating photo, from createPhoto.
            helper.createPhoto(fields, photoPath);
            callback({
              message: 'Added photo, and updated bike photo with the name.',
              id: fields.bike_id,
              photoPath: config.s3Url + photoHelper.replacePathWildcard(photoPath),
            }); // or fields.bike_id
          });
        }
      });


    } else {
      photoHelper.storeOriginal(fields, localPath);
      photoHelper.optimizeAndStoreBig(fields, localPath, function(photoPath) {
        helper.createPhoto(fields, photoPath);
        callback({
          message: 'Created bike, added photo, and updated bike photo with the name.',
          id: fields.bike_id,
          photoPath: config.s3Url + photoHelper.replacePathWildcard(photoPath),
        });
      });
    }
  });
}

module.exports = {
  run,
};
