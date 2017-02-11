
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
  getTitle: getTitle
};