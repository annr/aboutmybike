let express = require('express');
let router = express.Router();
const userHelper = require('../helpers/user.js');
let util = require('util');
router.post('/', function (req, res, next) {

  // later break this up into separate handlers.
  if(req.body.username && req.body.oauth_id) {
    userHelper.addUsernameAndVerify(req.body.username, req.body.oauth_id, function(err) {
      if (err) {
        req.flash('flashMessage', 'Unable to update username.');
        res.redirect('/username');
      }
      // if they haven't added a bike (most likely path, take them to add.)
      let bikeNeedsWork = false;
      if (!req.user.bike_id) {
        res.redirect('/add');
      } else if (bikeNeedsWork) {
        res.redirect('`/edit/${req.user.bike_id}`');
      } else {
        res.redirect('/');
      }
    });
  } else {
    req.flash('flashMessage', 'Not enough information for form handler to complete action.');
    res.redirect('/username');
  }
});

router.get('/', function (req, res, next) {
  if (req.user.username) {
    req.flash('flashMessage', 'Your username is set. To change your username after setting it, please contact support.');
  }
  res.render('username', {
    page_title: 'Create a username',
    formClass: 'page-form',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
