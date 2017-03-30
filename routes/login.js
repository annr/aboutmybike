let express = require('express');
let router = express.Router();
let util = require('util');

router.post('/', function (req, res, next) {


});

router.get('/', function (req, res, next) {
  res.render('login', {
    page_title: 'Log in',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
