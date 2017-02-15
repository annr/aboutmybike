var express = require('express');
var router = express.Router();

let helper = require('../helpers/bike');
let queries = require('../db/queries');

router.get('/', (req, res, next) => {
  queries.getAllBikes(function(err, data) {
    if(err) {
      next(err);
    } else {
      var descriptionCropLength = 250;
      // add titles to bikes in an inefficient way:
      for(var i = 0; i < data.length; i++) {
        if(helper.getTitle(data[i]) === 'Bike') {
          data[i].title = '(No Style Specified)'
        } else {
          data[i].title = helper.getTitle(data[i]);
        }
        if(data[i].description && data[i].description.length > (descriptionCropLength - 3)) {
          data[i].description = data[i].description.substring(0, 100) + '...';
        }
      }
      res.render('bikes', {
        app_name: res.locals.app.name,
        page_title: 'Bikes',
        results: data,
      });
    }
  });
});

module.exports = router;