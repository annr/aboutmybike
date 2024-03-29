let db = require('../db');
let _ = require('../public/javascripts/lodash');
let photoHelper = require('../helpers/photo');

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
      db.bike_info.add(data.id)
        .then(function (bike_id) {
          callback(null, bike_id);
        })
        .catch(function (err) {
          callback(new Error(`Failed to create bike_info record: (${err})`));
        });
    })
    .catch(function (err) {
      callback(new Error(`Failed to create bike record: (${err})`));
    });
}

function updateIntro(fields, callback) {
  var reasons = (fields.reasons) ? fields.reasons.split(',') : null;
  var type_id = (fields.type_id) ? [parseInt(fields.type_id)] : null;
  // turn reasons into integers if nec.
  if (reasons) {
    reasons = reasons.map(function(r) {
      return parseInt(r);
    });
  }

  if (!fields.description) { fields.description = null; }
  if (!fields.nickname) { fields.nickname = null; }

  db.bike.update([fields.description, fields.nickname, type_id, reasons, parseInt(fields.bike_id)])
    .then(function (data) {
      callback(null);
    })
    .catch(function (err) {
      callback(new Error(`Failed to update bike record: (${err})`));
    });
}

function updateMainPhoto(main_photo_id, bike_id) {
  db.bike.update_main_photo([main_photo_id, bike_id])
    .catch(function (err) {
      throw new Error(`Failed to update main bike photo: (${err})`);
    });
}

function updateBasics(fields, callback) {
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

  // even when we have a brand linked to the manufacturers table, we still
  // insert the brand and models as text for easy retrieval. It would suck if
  // this ever became out of sync.
  if (fields.brand !== '') {
    brand = fields.brand;
  }
  if (fields.model !== '') {
    model = fields.model;
  }

  db.bike.update_basics([fields.serial_number, brand_id, model_id, brand, model, parseInt(fields.bike_id)])
    .then(function () {
      updateBasicsInfo(fields, callback);
    })
    .catch(function (err) {
      callback(new Error(`Failed to create bike record: (${err})`));
    });
}

function updateBasicsInfo(fields, callback) {
  // #dcdbdf is the color input  default; they did not select any color.
  if (!fields.color || fields.color === '#dcdbdf') { fields.color = null; }

  if (!fields.era) { fields.era = null; }
  db.bike_info.update([fields.color, fields.era, parseInt(fields.bike_id)])
    .then(function () {
      callback(null);
    })
    .catch(function (err) {
      callback(new Error(`Failed to update bike info record: (${err})`));
    });
}

/* There's hardly any reason to have a photo table at this point.
   The values are never queried and not all of the versions are in the table.
 */
function createOrUpdatePhoto(user_id, bike_id, original_filename, photoPath, metadata) {
  db.photo.bike_id_select(bike_id)
    .then(function (photo) {
      db.photo.update([photo.id, photoPath, metadata])
        .then(function () {
          // sets the id of the main photo added above on the bike record.
          updateMainPhoto(photo.id, bike_id);
          // we are safe to delete the old photo since the new one has been stored.
          // we need to remove the record and the file.
          photoHelper.deleteOldPhotos(photo.main_photo_path);
        })
        .catch(function (err) {
          throw new Error(`Failed to create photo record. May have orphaned photo on server. (${err})`);
        });
    })
    .catch(function (err) {
      // there isn't a photo record for this bike. add one.
      db.photo.add([user_id, bike_id, original_filename, photoPath, metadata])
        .then(function (photo_id) {
          // sets the id of the main photo added above on the bike record.
          updateMainPhoto(photo_id, bike_id);
        })
        .catch(function (err) {
          throw new Error(`Failed to create photo record. May have orphaned photo on server. (${err})`);
        });
    });

}

function transformForDisplay(data) {
  let bike = data;
  let detailString = [];

  bike.title = getDetailedTitle(bike);

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

  bike.photo_url = bike.main_photo_path.replace('{*}', 'b');
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

function getSingleType(type_ids) {
  if (!type_ids) return '';
  return _.find(types, {id: type_ids[0]}).label;
}

/* TITLE
 
  We want to get as much as possible that is available for the title.

  1) + era if it's interesting: < 2000s
  2) + brand if avail.
  3) + model if avail.
  4) + type and in most cases 'bike' 
      (exceptions include tricycle and cruiser)
*/

function getDetailedTitle(bike) {
  let title = '';
  let type = bike.type;
  var brand, model;

  if (bike.era && bike.era !== 'Recent' && bike.era !== '2000s') { // too recent to be interesting.
    title += `${bike.era}`;
  }

  if (bike.brand_unlinked) {
    brand = bike.brand_unlinked;
    title += ` ${bike.brand_unlinked}`;
    if (bike.model_unlinked) {
      model = bike.model_unlinked;
      title += ` ${bike.model_unlinked}`;
    }
  }
  // add 'bike' when there is an associated type and no model or nothing
  title += type ? ` ${type}` : '';

  // we just allow one type for now
  if (type) {
    if (!/cycle|bike|bicycle|cruiser|mixte/i.test(type) && !/cycle|bike|bicycle|cruiser|mixte/i.test(bike.brand_unlinked)) {
      title += ' Bike';
    }
  }
  // (bike.brand + ' ' + bike.model).trim();
  return title.trim() || '(No Style Specified)';
}

module.exports = {
  getAllBikes,
  getBike,
  createBike,
  updateIntro,
  updateBasics,
  updateBasicsInfo,
  createOrUpdatePhoto,
  getDetailedTitle,
  transformForDisplay,
  getFormReasons,
  getFormTypes,
  getFormEras,
};
