let express = require('express');
let router = express.Router();
const userHelper = require('../helpers/user.js');
const config = require('../config').appConfig;

var bcrypt = require('bcrypt');
const saltRounds = 10;

router.post('/', function (req, res, next) {
  bcrypt.hash(req.body.password, saltRounds, function(err, hash) {
    // Store hash in your password DB.
    userHelper.updatePasswordOfUsername(req.body.username, hash, function(err, data) {
      if (err) {
        req.flash('flashMessage', `Failed to update password for ${req.body.username}`);
      } else {
        req.flash('flashMessage', 'User password successfully updated.');
      }
      res.redirect('/admin');
    });
  });
});

// template shows more the one form but post only handles change password.
router.get('/', function (req, res, next) {
  res.render('admin', {
    page_title: 'Misc Admin Tools',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
