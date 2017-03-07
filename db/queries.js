/* DEPRECATED. THIS FILE WILL BE REMOVED. */

let db = require('../db');

function updateBikeIntro(fields, callback) {
  fields.type_id = (fields.type_id) ? `ARRAY[${fields.type_id}]` : null;
  fields.reasons = (fields.reasons) ? `ARRAY[${fields.reasons}]` : null;

  if (!fields.description) { fields.description = null; }
  if (!fields.nickname) { fields.nickname = null; }

  db.none(`update bike set description = $1, nickname = $2, type_ids = ${fields.type_id}, reason_ids = ${fields.reasons} where id = $3`, [fields.description, fields.nickname, parseInt(fields.bike_id)])
    .then(function () {
      callback(null);
    })
    .catch(function (err) {
      callback(new Error(`Failed to update bike record: (${err})`));
    });
}

function updateBikeMainPhoto(bike_id, main_photo_path, callback) {
  db.none('update bike set main_photo_path = $1 where id = $2', [main_photo_path, bike_id])
    .then(function () {
      callback(null);
    })
    .catch(function (err) {
      callback(new Error(`Failed to update main bike photo: (${err})`));
    });
}

function updateBikeBasics(fields, callback) {
  if (!fields.serial_number) { fields.serial_number = null; }
  // model/brand
  let brand = null;
  let model = null;
  let brand_id = null;
  let model_id = null;

  // careful. you can't parseInt(null)
  if (fields.brand_id !== '') {
    brand_id = parseInt(fields.brand_id);
  }
  if (fields.model_id !== '') {
    model_id = parseInt(fields.model_id);
  }

  if (!fields.description) { fields.description = null; }
  if (!fields.nickname) { fields.nickname = null; }

  if (!fields.brand_id && fields.brand !== '') {
    brand = fields.brand;
  }
  if (!fields.model_id && fields.model !== '') {
    model = fields.model;
  }

  db.none('update bike set serial_number = $1, manufacturer_id = $2, model_id = $3, brand_unlinked = $4, model_unlinked = $5 where id = $6',
    [fields.serial_number, brand_id, model_id, brand, model, parseInt(fields.bike_id)])
    .then(function () {
      updateBikeBasicsInfo(fields, callback);
    })
    .catch(function (err) {
      callback(new Error(`Failed to create bike record: (${err})`));
    });
}

function updateBikeBasicsInfo(fields, callback) {
  // #dcdbdf is the color input  default; they did not select any color.
  if (!fields.color || fields.color === '#dcdbdf') { fields.color = null; }

  if (!fields.era) { fields.era = null; }
  db.none('update bike_info set color = $1, era = $2 where bike_id = $3', [fields.color, fields.era, parseInt(fields.bike_id)])
    .then(function () {
      callback(null);
    })
    .catch(function (err) {
      callback(new Error(`Failed to update bike info record: (${err})`));
    });
}

function createBikePhoto(fields, photoPath, callback) {
  db.one('insert into photo(user_id, bike_id, original_file, file_path) ' +
      'values($1, $2, $3, $4) returning *', [parseInt(fields.user_id), parseInt(fields.bike_id), fields.original_filename, photoPath])
    .then(function (data) {
      updateBikeMainPhoto(data.bike_id, data.file_path, callback);
    })
    .catch(function (err) {
      callback(new Error(`Failed to create photo record. May have orphaned photo on server. (${err})`));
    });
}

function getManufacturer(manuId, callback) {
  db.one('select * from manufacturer where id = $1', manuId)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed to get manufacturer record: (${err})`));
    });
}


module.exports = {
  updateBikeIntro,
  updateBikeMainPhoto,
  updateBikeBasics,
  updateBikeBasicsInfo,
  createBikePhoto,
  getManufacturer,
};
