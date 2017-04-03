let express = require('express');
let router = express.Router();
const userHelper = require('../helpers/user.js');

router.post('/', function (req, res, next) {

  // TO-DO: disallow this action if user is not an admin.
  userHelper.setVerifiedByUsername(req.body.username, req.body.verify, function(err) {
    if (err) {
      req.flash('flashMessage', `Failed to mark ${req.body.verify_username} as verified`);
    } else {
      req.flash('flashMessage', `Verified switch set (${req.body.verify})`);
    }
    res.redirect('/admin');
  });

});


module.exports = router;
