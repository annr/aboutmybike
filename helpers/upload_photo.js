let fs = require('fs');
let config = require('../config').appConfig;
let bikeHelper = require('../helpers/bike');
let photoHelper = require('../helpers/photo');

/* 
 * upload photo
 *
 * takes a local path and fields and creates the bike, uploads versions of photo and finally creates bike photo record.
*/

let run = function(localPath, fields, callback) {
  fs.readFile(localPath, (err, data) => {
    if (err) throw err;
    if (!fields.bike_id) {
      helper.createBike(fields, function (err, bike_id) {
        if (err) {
          callback(err);
        } else {
          storePhotos(bike_id, localPath, fields, callback);
        }
      });
    } else {
      storePhotos(fields.bike_id, localPath, fields, callback);
    }
  });
}

// using bike_id get filename template and then do the rest of the things.
let storePhotos = function (bike_id, localPath, fields, callback) {
    photoHelper.getPhotoPath(bike_id, localPath, function(photoPath) {
      photoHelper.storeOriginal(bike_id, localPath, photoPath);
      photoHelper.optimizeAndStoreCopies(bike_id, localPath, photoPath);
      bikeHelper.createPhoto(fields, photoPath);
      callback({
        message: 'Created filename, uploaded versions of photo and created photo record',
        id: fields.bike_id,
        photoPath: config.s3Url + photoHelper.replacePathWildcard(photoPath),
      });
  });
};


module.exports = {
  run,
};
