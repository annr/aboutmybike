var express = require('express');
var router = express.Router();

let queries = require('../db/queries');

router.get('/', (req, res, next) => {
  queries.getAllBikes(function(data) {
    res.render('bikes', { 
      app_name: res.locals.app.name,
      page_title: 'Bikes', 
      results: data
    });
  });
});

module.exports = router;