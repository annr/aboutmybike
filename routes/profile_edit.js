let express = require('express');
let router = express.Router();
const helper = require('../helpers/user');

router.get(['/', '/:username'], function (req, res, next) {
  let username = req.params.username;
  helper.getUserByUsername(username, function (err, data) {
    if (err) {
      next(err);
    } else {
      // must be user's profile for them to edit
      if (data.id != req.user.id) {
       res.redirect('/');
      }
      res.render('profile_edit', {
        page_title: 'Edit Profile',
        profile_user: data
      });
    }
  });
});

/* Populate basic details */
router.post('/', function (req, res, next) {
  helper.updateProfile(req.body.id, req.body.bio, req.body.website, function (err) {
    if (err) {
      next(err);
    } else {
      // res.json({success : 'Updated bike basics', status : 200});
      res.redirect(`/u/${req.body.username}`);
    }
  });
});

module.exports = router;
