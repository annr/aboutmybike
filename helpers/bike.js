let db = require('../db');

let types = require('./bike-types').types;
let reasons = [
  { id: 1, label: 'fun' },
  { id: 2, label: 'commute' },
  { id: 3, label: 'work' },
  { id: 4, label: 'exercise' },
  { id: 5, label: 'social' },
  { id: 6, label: 'style' },
  { id: 7, label: 'adventure' },
  { id: 8, label: 'thrill' },
  { id: 9, label: 'freedom' },
];

let eras = [
  { label: 'Recent' },
  { label: '2000s' },
  { label: '1990s' },
  { label: '1980s' },
  { label: '1970s' },
  { label: 'Mid-Century' },
  { label: 'Early 1900s' },
  { label: 'Late 1800s' },
];

let _ = require('../public/javascripts/lodash');

function getAllBikes(callback) {
  // for grid only, for now.
  db.bike.all()
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed to retrieve bicycles: (${err})`));
    });
}

function getBike(bikeID, callback) {
//  db.one('select * from bike where id = $1', bikeID)
  db.bike.select(bikeID)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed get bike record: (${err})`));
    });
}

function createBike(fields, callback) {
  db.bike.add(parseInt(fields.user_id))
    .then(function (data) {
      console.log(data);
      console.log('add to bike returning ' + data.id);
      db.bike_info.add(data.id)
        .then(function (data) {
          console.log('add to bike_info returning ' + data);          
          callback(null, data);
        })
        .catch(function (err) {
          callback(new Error(`Failed to create bike info record: (${err})`));
        });
    })
    .catch(function (err) {
      callback(new Error(`Failed to create bike record: (${err})`));
    });
}

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
  db.one('insert into photo(user_id, bike_id, original_filename, file_path) ' +
      'values($1, $2, $3, $4) returning *', [parseInt(fields.user_id), parseInt(fields.bike_id), fields.original_filename, photoPath])
    .then(function (data) {
      updateBikeMainPhoto(data.bike_id, data.file_path, callback);
    })
    .catch(function (err) {
      callback(new Error(`Failed to create photo record. May have orphaned photo on server. (${err})`));
    });
}

function transformForDisplay(data) {
  let bike = data;
  let detailString = [];

  bike.title = getTitle(bike);

  bike.for = getReasonsList(bike.reason_ids);

  detailString.push(bike.era);
  if (bike.speeds) {
    detailString.push(`${bike.speeds} speed`);
  }
  if (bike.handlebars) {
    detailString.push(`${bike.handlebars} handlebars`);
  }
  if (bike.brakes) {
    detailString.push(`${bike.brakes} brakes`);
  }
  bike.details = detailString.join(', ');

  bike.photo_url = bike.main_photo_path;

  return bike;
}

function getReasonsList(reason_ids) {
  if (!reason_ids) return '';
  // override label for reason id 9:
  let reasonsSaved = _.map(_.filter(reasons, function (reason) {
    return reason_ids.indexOf(reason.id) !== -1;
  }), 'label');

  return reasonsSaved.join(', ');
}

/* the following three helpers can be written way more efficiently */

function getFormTypes(type_id) {
  // I think this can be done much more efficeintly.

  let formTypes = [];

  _.map(types, function (t) {
    let z = { id: t.id, label: t.label };
    if (type_id && t.id === type_id) {
      z.selected = true;
    }
    if (t.related_type_ids) {
      z.label = ` - ${t.label}`;
    }
    formTypes.push(z);
  });

  return formTypes;
}

function getFormReasons(reason_ids) {
  let formReasons = [];
  // default reason 'adventure' !
  if (!reason_ids) reason_ids = [9];
  // transform reasons to add checked state
  _.map(reasons, function (r) {
    let z = { id: r.id, label: r.label };
    if (z.label === 'freedom') {
      z.label = 'The feeling of being in motion again. It\'s the most extraordinary thing in the world.';
    }
    if (reason_ids && reason_ids.indexOf(r.id) !== -1) {
      z.checked = true;
    }
    formReasons.push(z);
  });
  return formReasons;
}

function getFormEras(era) {
  let formEras = [];
  _.map(eras, function (e) {
    let z = { label: e.label };
    if (era === e.label) {
      z.selected = true;
    }
    formEras.push(z);
  });
  return formEras;
}


/* if available add era, bike type and ' Bike'.
   otherwise just return ' Bike'.

   Ex. return '1980s Road Bike'
*/
function getTitle(bike) {
  let title = '';

  if (bike.era && bike.era !== 'Recent' && bike.era !== '2000s') { // too recent to be interesting.
    title += bike.era;
  }

  title += bike.type ? (` ${bike.type}`) : '';

  // add ' Bike' for most bike types OR neither era or type
  if (bike.type || title === '') {
    if (!/cycle|bike|bicycle|cruiser|mixte/i.test(bike.type)) {
      title += ' Bike';
    }
  }
  // title might have an space at the beginning; in front of type or ' Bike'
  return title.trim();
}


/* get brand and model if brand exists + bike type + ' Bike' */
function getTitleWithBrandAndModel(bike) {
  let title = '';
  let type = bike.type;

  if (bike.manufacturer_name) {
    title += bike.manufacturer_name;
    if (bike.model_name) {
      title += ` ${bike.model_name}`;
    } else if (bike.model_unlinked !== '') {
      // complicated, but they could have an
      // unlinked model name with a stored manufacturer
      title += ` ${bike.model_unlinked}`;
    }
  } else if (bike.brand_unlinked) {
    title += bike.brand_unlinked;
    if (bike.model_unlinked) {
      title += ` ${bike.model_unlinked}`;
    }
  }

  // add 'bike' when there is an associated type on nothing
  title += type ? ` ${type}` : '';

  if (type || title === '') {
    if (!/cycle|bike|bicycle|cruiser|mixte/i.test(type)) {
      title += ' Bike';
    }
  }
  // (bike.brand + ' ' + bike.model).trim();
  return title.trim();
}


module.exports = {
  getAllBikes,
  getBike,
  createBike,
  updateBikeIntro,
  updateBikeMainPhoto,
  updateBikeBasics,
  updateBikeBasicsInfo,
  createBikePhoto,
  getTitle,
  transformForDisplay,
  getFormReasons,
  getFormTypes,
  getFormEras,
};
