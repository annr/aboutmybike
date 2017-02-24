var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.render('profile', { 
    app_name: res.locals.app.name,
    page_title: 'Profile',
    username: req.user.username
  });
});


module.exports = router;
