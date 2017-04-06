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
      bikeHelper.createBike(fields, function (err, bike_id) {
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
  
  let storedPath = photoHelper.getStoredPath(bike_id);
  let fullStoredPath = photoHelper.DESTINATION_FOLDER + '/' + storedPath;

  // get properties so that we have image format for optimizing and storing
  // as well as storing in the database after success.

  // note these properties are of the prepared file. it may have been cropped to 4:3.
  photoHelper.getPhotoProperties(localPath, function(img) {
    let propertiesToStore = {
      width: img.width,
      height: img.height,
      filesize: img.filesize,
      number_pixels: img['number pixels'],
    };
    photoHelper.optimizeAndStoreCopies(localPath, storedPath, img, function() {
      bikeHelper.createOrUpdatePhoto(parseInt(fields.user_id), bike_id, fields.original_filename, fullStoredPath, JSON.stringify(propertiesToStore));
      // we can only send this callback with the new photo when storing all the photos succeeds
      callback({
        message: 'Created filename, uploaded versions of photo and created photo record',
        id: bike_id,
        photoPath: config.s3Url + photoHelper.replacePathWildcard(fullStoredPath, 'b'),
      });
    });

  });

};

module.exports = {
  run,
};