var express = require('express');
var router = express.Router();

let queries = require('../db/queries');

router.get('/', (req, res, next) => {
  queries.getAllBikes(function(err, data) {
    if(err) {
      next(err);
    } else {
      res.render('bikes', {
        app_name: res.locals.app.name,
        page_title: 'Bikes',
        results: data,
      });
    }
  });
});

module.exports = router;