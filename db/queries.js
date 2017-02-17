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
  db.one('select  b.*, type.label as type, type.id as type_id, manufacturer.name as manufacturer_name, model.name as model_name, bike_info.era as era, bike_info.color as color from bike b left join bike_info on b.id = bike_info.bike_id left join manufacturer on b.manufacturer_id=manufacturer.id left join model on b.model_id=model.id left join type on b.type_ids[1]=type.id where b.id = $1', bikeID)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed get bike record: (' + err + ')'));
    });
}

function createBike(fields, photoPath, callback) {
  db.one('insert into bike(user_id, main_photo_path) ' +
      'values($1, $2) returning id', [parseInt(fields.user_id), photoPath])
    .then(function (data) {
      db.one('insert into bike_info(bike_id) ' +
          'values($1) returning bike_id as id', [data.id])
        .then(function (data) {
          callback(null, data);
        })
        .catch(function (err) {
          callback(new Error('Failed to create bike info record: (' + err + ')'));
        });
    })
    .catch(function (err) {
      callback(new Error('Failed to create bike record: (' + err + ')'));
    });
}

function updateBikeIntro(fields, callback) {
  fields.type_id = (fields.type_id) ? 'ARRAY[' + fields.type_id + ']' : null;
  fields.reasons = (fields.reasons) ? 'ARRAY[' + fields.reasons + ']' : null;

  if(!fields.description) { fields.description = null; }
  if(!fields.nickname) { fields.nickname = null; }
 
  db.none('update bike set description = $1, nickname = $2, type_ids = ' + fields.type_id + ', reason_ids = ' + fields.reasons + ' where id = $3', [fields.description, fields.nickname, parseInt(fields.bike_id)])
    .then(function () {
      callback(null);
    })
    .catch(function (err) {
      callback(new Error('Failed to update bike record: (' + err + ')'));
    });
}

function updateBikeBasics(fields, callback) {
  if(!fields.serial_number) { fields.serial_number = null; }
  //model/brand
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

  db.none('update bike set serial_number = $1, manufacturer_id = $2, model_id = $3, brand_unlinked = $4, model_unlinked = $5 where id = $6',
    [fields.serial_number, brand_id, model_id, brand, model, parseInt(fields.bike_id)])
    .then(function () {
      updateBikeBasicsInfo(fields, callback);
    })
    .catch(function (err) {
      callback(new Error('Failed to create bike record: (' + err + ')'));
    });
}

function updateBikeBasicsInfo(fields, callback) {
  console.log('in update info ');
  // #dcdbdf is the color input  default; they did not select any color.
  if(!fields.color || fields.color === '#dcdbdf') { fields.color = null; }

  if(!fields.era) { fields.era = null; }
  db.none('update bike_info set color = $1, era = $2 where bike_id = $3', [fields.color, fields.era, parseInt(fields.bike_id)])
    .then(function () {
      console.log('seemed successful.');
      callback(null);
    })
    .catch(function (err) {
      callback(new Error('Failed to update bike info record: (' + err + ')'));
    });
}

function createBikePhoto(fields, photoPath, callback) {
  console.log('creating bike photo....', parseInt(fields.user_id), parseInt(fields.bike_id), fields.original_filename, photoPath);

  db.one('insert into photo(user_id, bike_id, original_filename, file_path) ' +
      'values($1, $2, $3, $4) returning id', [parseInt(fields.user_id), parseInt(fields.bike_id), fields.original_filename, photoPath])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed to create photo record: (' + err + ')'));
    });
}

function updateMainPhoto(fields, photoPath, callback) {
  db.none('update bike set main_photo_path = $1 where id = $2', [photoPath, parseInt(fields.bike_id)])
    .then(function () {
      callback(null);
    })
    .catch(function (err) {
      callback(new Error('Failed to update main bike photo: (' + err + ')'));
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
  updateBikeIntro: updateBikeIntro,
  updateBikeBasics: updateBikeBasics,
  updateBikeBasics: updateBikeBasics,
  updateBikeBasicsInfo: updateBikeBasicsInfo,
  createBikePhoto: createBikePhoto,
  updateMainPhoto: updateMainPhoto,
  getManufacturer: getManufacturer
};
