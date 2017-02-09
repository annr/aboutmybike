var db = require('./db');

// add query functions
function getAllBikes(callback) {
  db.any('select * from bike')
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed to retrieve bicycles: (' + err + ')'));
    });
}

function getBike(bikeID, callback) {
  db.one('select * from bike where id = $1', bikeID)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed get bike record: (' + err + ')'));
    });
}

function createBike(fields, photoPath, callback) {
  var brand = null;
  var model = null;
  var brand_id = null;
  var model_id = null;

  // careful. you can't parseInt(null)
  if(fields.brand_id !== "") {
    brand_id = parseInt(fields.brand_id);
  }
  if(fields.model_id !== "") {
    model_id = parseInt(fields.model_id);
  }

  if(!fields.description) { fields.description = null; }
  if(!fields.nickname) { fields.nickname = null; }

  if(!fields.brand_id && fields.brand !== '') {
    brand = fields.brand;
  }
  if(!fields.model_id && fields.model !== '') {
    model = fields.model;
  }

  db.one('insert into bike(user_id, main_photo_path, description, nickname, manufacturer_id, model_id, brand_unlinked, model_unlinked) ' +
      'values($1, $2, $3, $4, $5, $6, $7, $8) returning id', [parseInt(fields.user_id), photoPath, fields.description, fields.nickname, brand_id, model_id, brand, model])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed to create bike record: (' + err + ')'));
    });
}

function getManufacturer(manuId, callback) {
  db.one('select * from manufacturer where id = $1', manuId)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed to get manufacturer record: (' + err + ')'));
    });
}


module.exports = {
  getAllBikes: getAllBikes,
  getBike: getBike,
  createBike: createBike,
  getManufacturer: getManufacturer
};
