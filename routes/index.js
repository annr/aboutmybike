var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.render('index', { 
    app_name: res.locals.app.name,
    page_title: 'Home'
  });
});

module.exports = router;
