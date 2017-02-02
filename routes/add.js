
var express = require('express');
var router = express.Router();

/* GET bike listing. */
router.get('/', function(req, res, next) {
  res.render('add', {
      app_name: res.locals.app.name,
      page_title: 'Add Your Bike'
    });
});

/* Create bike record */
router.post('/', function(req, res, next) {
   console.log('Create bike record');

});


module.exports = router;
