var express = require('express');
var router = express.Router();

/* GET bikes listing. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Bikes', layout: 'layout' });
});

module.exports = router;