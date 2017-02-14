var express = require('express');
var router = express.Router();
let queries = require('../db/queries');

let helper = require('../helpers/bike');

/* GET bike listing */
router.get('/:id', function(req, res, next) {

  var id = req.params.id;

  queries.getBike(id, function(err, data) {
    if(err) {
      next(err);
    } else {
      var bike = helper.transformForDisplay(data);

      bike.photo_url = res.locals.app.s3Url + bike.photo_url;

      res.render('bike', {
        app_name: res.locals.app.name,
        page_title: 'Bike Detail',
        bike: bike
      });
    }
  });

});

module.exports = router;
