

let types = require('./bike-types').types;
let reasons = [
  { "id" : 1, "label": "fun"},
  { "id" : 2, "label": "commute"},
  { "id" : 3, "label": "work"},
  { "id" : 4, "label": "exercise"},
  { "id" : 5, "label": "social"},
  { "id" : 6, "label": "style"},
  { "id" : 8, "label": "thrill"},
  { "id" : 7, "label": "The feeling of being in motion again. It's the most extraordinatry thing in the world."}
];

let _ = require('../public/javascripts/lodash');

function transformForDisplay(data) {
  var bike = data;
  var detailString = [];

  bike.title = parseInt(bike.user_id) + "'s " + getTitle(bike);

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
  var reasonsSaved = _.map(_.filter(reasons, function(reason) { return reason_ids.indexOf(reason.id) !== -1 } ), 'label');
  return reasonsSaved.join(', ');
}

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
  if(!reason_ids) reason_ids = [7];
  // transform reasons to add checked state
  _.map(reasons, function(r) {
    var z = { id: r.id, label: r.label };
    if(reason_ids && reason_ids.indexOf(r.id) !== -1) {
      z.checked = true;
    }
    formReasons.push(z);
  });
  return formReasons;
}

function getTitle(bike) {
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
    if(!/cycle|bike|bicycle/i.test(type)) {
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
  getFormTypes: getFormTypes
};