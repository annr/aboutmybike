var express = require('express');
var router = express.Router();
let queries = require('../db/queries');

/* GET bike listing. */
router.get('/:id', function(req, res, next) {

  var id = req.params.id;

  queries.getBike(id, function(err, data) {
    if(err) {
      next(err);
    } else {
      var bike = data;
      var detailString = [];

      bike.title = (bike.brand + " " + bike.model).trim();

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

      bike.photo_url = res.locals.app.s3Url + bike.main_photo_path;

      res.render('bike', {
        app_name: res.locals.app.name,
        page_title: 'Bike Detail',
        bike: bike
      });
    }
  });

});

module.exports = router;
