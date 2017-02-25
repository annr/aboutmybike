var express = require('express');
var router = express.Router();
var util = require('util');

router.get('/', function(req, res, next) {
  res.render('index', {
    page_title: 'Home'
  });
});

module.exports = router;
