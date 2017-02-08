var express = require('express');
var router = express.Router();
let queries = require('../db/queries');

/* GET bike listing. */
router.get('/:id', function(req, res, next) {

  var id = req.params.id;

  queries.getSingleBike(id, function(data) {
    var bike = data;
    var detailString = [];

    bike.title = (bike.brand + " " + bike.model).trim();

    bike.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc et tempus orci. Aenean consectetur sagittis condimentum. Morbi efficitur turpis nec faucibus tincidunt. Duis in arcu facilisis, aliquet dolor quis, ultrices velit. Praesent vitae dolor risus. Phasellus blandit mattis laoreet. Nulla enim dui, semper eget risus et, placerat sodales nulla. Suspendisse facilisis orci ac consectetur aliquam. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi non est tempor, fermentum turpis sed, molestie lacus. Praesent commodo diam vel gravida sodales. Donec luctus rhoncus blandit. Pellentesque nec ipsum nec ipsum eleifend volutpat.';
    bike.city = "San Francisco";
    bike.era = "1980s";

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

    res.render('bike', {
      app_name: res.locals.app.name,
      page_title: 'Bike Detail', 
      bike: bike
    });

  });

});

module.exports = router;
