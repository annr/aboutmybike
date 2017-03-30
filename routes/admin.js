let express = require('express');
let router = express.Router();
const userHelper = require('../helpers/user.js');
const config = require('../config').appConfig;

var bcrypt = require('bcrypt');
const saltRounds = 10;

router.post('/', function (req, res, next) {

  // later break this up into separate handlers.
  if(req.body.password) {
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
  } else {
    req.flash('flashMessage', 'Not enough information for form handler to complete action.');
    res.redirect('/admin');
  }

});

router.get('/', function (req, res, next) {

  // in order to see this page the user has to be in the list of admin ids. 
  // adminUserIds
  if (config.adminUserIds.indexOf(req.user.id) === -1) {
   res.redirect('/');
  }

  res.render('admin', {
    page_title: 'Misc Admin Tools',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
