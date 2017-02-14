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
//  db.one('select * from bike where id = $1', bikeID)
  db.one('select  b.*, type.label as type, type.id as type_id, manufacturer.name as manufacturer_name, model.name as model_name from bike b left join bike_info on b.id = bike_info.bike_id left join manufacturer on b.manufacturer_id=manufacturer.id left join model on b.model_id=model.id left join type on b.type_ids[1]=type.id where b.id = $1', bikeID)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed get bike record: (' + err + ')'));
    });
}

function createBike(fields, photoPath, callback) {
  fields.type_id = (fields.type_id) ? 'ARRAY[' + fields.type_id + ']' : null;
  fields.reasons = (fields.reasons) ? 'ARRAY[' + fields.reasons + ']' : null;

  if(!fields.serial_number) { fields.serial_number = null; }
  if(!fields.description) { fields.description = null; }
  if(!fields.nickname) { fields.nickname = null; }

  db.one('insert into bike(user_id, main_photo_path, description, nickname, serial_number, type_ids, reason_ids) ' +
      'values($1, $2, $3, $4, $5, ' + fields.type_id + ', ' + fields.reasons + ') returning id', [parseInt(fields.user_id), photoPath, fields.description, fields.nickname, fields.serial_number])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed to create bike record: (' + err + ')'));
    });
}

function updateBike(fields, callback) {
  fields.type_id = (fields.type_id) ? 'ARRAY[' + fields.type_id + ']' : null;
  fields.reasons = (fields.reasons) ? 'ARRAY[' + fields.reasons + ']' : null;

  if(!fields.serial_number) { fields.serial_number = null; }
  if(!fields.description) { fields.description = null; }
  if(!fields.nickname) { fields.nickname = null; }

  db.none('update bike set description = $1, nickname = $2, serial_number = $3, type_ids = ' + fields.type_id + ', reason_ids = ' + fields.reasons + ' where id = $4', [fields.description, fields.nickname, fields.serial_number, parseInt(fields.bike_id)])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed to update bike record: (' + err + ')'));
    });
}

function updateBikePhoto(fields, photoPath, callback) {
  db.none('update bike set main_photo_path = $1 where id = $2', [photoPath, parseInt(fields.bike_id)])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed to update bike photo: (' + err + ')'));
    });
}

/*
function createBikeDetails(fields, callback) {
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
*/


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
  updateBike: updateBike,
  updateBikePhoto: updateBikePhoto,
  getManufacturer: getManufacturer
};
