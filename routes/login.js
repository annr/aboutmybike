let express = require('express');
let router = express.Router();
let util = require('util');

router.get('/', function (req, res, next) {

  // if user is authenticated, redirect them.
  if(req.user) {
    req.flash('flashMessage', 'You are already logged in.')
    res.redirect('/');
  }

  res.render('login', {
    page_title: 'Log in',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
