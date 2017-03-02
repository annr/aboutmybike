let types = require('./bike-types').types;
let reasons = [
  { "id" : 1, "label": "fun"},
  { "id" : 2, "label": "commute"},
  { "id" : 3, "label": "work"},
  { "id" : 4, "label": "exercise"},
  { "id" : 5, "label": "social"},
  { "id" : 6, "label": "style"},
  { "id" : 7, "label": "adventure"},
  { "id" : 8, "label": "thrill"},
  { "id" : 9, "label": "freedom"}
];

let eras = [
  { "label": "Recent"},
  { "label": "2000s"},
  { "label": "1990s"},
  { "label": "1980s"},
  { "label": "1970s"},
  { "label": "Mid-Century"},
  { "label": "Early 1900s"},
  { "label": "Late 1800s"}
];

let _ = require('../public/javascripts/lodash');

function transformForDisplay(data) {
  var bike = data;
  var detailString = [];

  bike.title = getTitle(bike);

  bike.for = getReasonsList(bike.reason_ids);

  detailString.push(bike.era);
  if(bike.speeds) {
    detailString.push(bike.speeds + ' speed');
  }
  if(bike.handlebars) {
    detailString.push(bike.handlebars + ' handlebars');
  }
  if(bike.brakes) {
    detailString.push(bike.brakes + ' brakes');
  }
  bike.details = detailString.join(', ');

  bike.photo_url = bike.main_photo_path;

  return bike;
}

function getReasonsList(reason_ids) {
  if(!reason_ids) return '';
  // override label for reason id 9:
  var reasonsSaved = _.map(_.filter(reasons, function(reason) {
    return reason_ids.indexOf(reason.id) !== -1
  }), 'label');

  return reasonsSaved.join(', ');
}

/* the following three helpers can be written way more efficiently */

function getFormTypes(type_id) {
  // I think this can be done much more efficeintly.

  let formTypes = [];

  _.map(types, function(t) {
    var z = { id: t.id, label: t.label };
    if(type_id && t.id === type_id) {
      z.selected = true;
    }
    if(t.related_type_ids) {
      z.label = ' - ' + t.label;
    }
    formTypes.push(z);
  });

  return formTypes;
}

function getFormReasons(reason_ids) {
  let formReasons = [];
  // default reason 'adventure' !
  if(!reason_ids) reason_ids = [9];
  // transform reasons to add checked state
  _.map(reasons, function(r) {
    var z = { id: r.id, label: r.label };
    if(z.label === "freedom") {
      z.label = "The feeling of being in motion again. It's the most extraordinary thing in the world.";
    }
    if(reason_ids && reason_ids.indexOf(r.id) !== -1) {
      z.checked = true;
    }
    formReasons.push(z);
  });
  return formReasons;
}

function getFormEras(era) {
  let formEras = [];
  _.map(eras, function(e) {
    var z = { label: e.label };
    if(era === e.label) {
      z.selected = true;
    }
    formEras.push(z);
  });
  return formEras;
}


/* if available add era, bike type and " Bike". 
   otherwise just return " Bike".

   Ex. return "1980s Road Bike"
*/
function getTitle(bike) {
  var title = '';

  if(bike.era && bike.era !== 'Recent' && bike.era !== '2000s' ) { // too recent to be interesting.
    title += bike.era;
  }

  title += bike.type ? (' ' + bike.type) : '';

  // add ' Bike' for most bike types OR neither era or type
  if(bike.type || title === '') {
    if(!/cycle|bike|bicycle|cruiser|mixte/i.test(bike.type)) {
      title +=' Bike';
    }
  }
  // title might have an space at the beginning; in front of type or " Bike"
  return title.trim();
}


/* get brand and model if brand exists + bike type + " Bike" */
function getTitleWithBrandAndModel(bike) {
  var title = '';
  var type = bike.type;

  if(!!bike.manufacturer_name) {
    title += bike.manufacturer_name;
    if(!!bike.model_name) {
      title += " " + bike.model_name;
    } else if (bike.model_unlinked !== '') { 
      // complicated, but they could have an
      // unlinked model name with a stored manufacturer
      title += " " + bike.model_unlinked;
    }
  } else if (!!bike.brand_unlinked) {
    title += bike.brand_unlinked;
    if(!!bike.model_unlinked) {
      title += " " + bike.model_unlinked;
    }
  }

  // add 'bike' when there is an associated type on nothing
  title += type ? ' ' + type : '';

  if(type || title === '') {
    if(!/cycle|bike|bicycle|cruiser|mixte/i.test(type)) {
      title +=' Bike';
    }
  }
  //(bike.brand + " " + bike.model).trim();
  return title.trim();
}


module.exports = {
  getTitle: getTitle,
  transformForDisplay: transformForDisplay,
  getFormReasons: getFormReasons,
  getFormTypes: getFormTypes,
  getFormEras: getFormEras
};