let express = require('express');
let router = express.Router();
const userHelper = require('../helpers/user');
var bcrypt = require('bcrypt');
const saltRounds = 10;

router.get(['/', '/:username'], function (req, res, next) {

  let username = req.params.username;
  // must be user's account for them to chnage password
  // and also they can't have a federated login
  if (req.user.facebook_id) {
    req.flash('flashMessage', `If you've logged in with a third-party service you have no AMB-managed password to change.`);
    res.redirect('/');
  }

  if (username !== req.user.username) {
    req.flash('flashMessage', `Permission denied.`);
    res.redirect('/');
  }

  res.render('password_change', {
    page_title: 'Change Your Password',
    profile_user: req.user
  });
});

router.post('/', function (req, res, next) {
  let username = req.body.username;
  // must be user's account for them to chnage password
  if (username !== req.user.username) {
    req.flash('flashMessage', `Permission denied.`);
    res.redirect('/');
  }
  bcrypt.hash(req.body.password, saltRounds, function(err, hash) {
    // Store hash in your password DB.
    userHelper.updatePasswordOfUsername(req.body.username, hash, function(err, data) {
      if (err) {
        req.flash('flashMessage', `Failed to update password for ${req.body.username}`);
      } else {
        req.flash('flashMessage', 'Your password was successfully updated.');
      }
      res.redirect(`/u/${req.body.username}`);
    });
  });
});

module.exports = router;
