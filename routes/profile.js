let express = require('express');
let router = express.Router();
const helper = require('../helpers/user');

router.get(['/', '/:username'], function (req, res, next) {
  let username = req.params.username;

  helper.getUserByUsername(username, function (err, data) {
    if (err) {
      next(err);
    } else {
      if(data.bike_main_photo) {
        data.bike_main_photo = data.bike_main_photo.replace('{*}', 's');
      }
      res.render('profile', {
        page_title: username  + '\'s Profile',
        profile_user: data,
        is_users_profile: req.user && (req.user.username === username)
      });
    }
  });
});

module.exports = router;
