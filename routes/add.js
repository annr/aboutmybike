
var express = require('express');
var router = express.Router();

/* GET bike listing. */
router.get('/', function(req, res, next) {
  res.render('add', { layout: 'layout', title: 'About My Bike'});
});

module.exports = router;
