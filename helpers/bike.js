

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

let _ = require('../public/javascripts/lodash');


function transformForDisplay(data) {
  var bike = data;
  var detailString = [];

  bike.title = parseInt(bike.user_id) + "'s " + getTitle(bike);

  if(bike.type_ids) {
    bike.type = getType(bike.type_ids);
  }

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

function getType(type_ids) {
  // we only allow one type for now, even though we've created the postgres field as an array
  if (!type_ids) return null;
  return _.find(types, { 'id': parseInt(type_ids[0]) }).label;
}

function getReasonsList(reason_ids) {
  var reasonsSaved = _.map(_.filter(reasons, function(reason) { return reason_ids.indexOf(reason.id) !== -1 } ), 'label');
  return reasonsSaved.join(', ');
}

function getTitle(bike) {
  var title = '';
  var type = getType(bike.type_ids);

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
  transformForDisplay: transformForDisplay
};