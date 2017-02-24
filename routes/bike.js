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

      bike.photo_url = req.app.locals.s3Url + bike.photo_url;

      console.log(req.app.locals.s3Url);

      res.render('bike', {
        page_title: 'Bike Detail',
        bike: bike
      });
    }
  });

});

module.exports = router;
