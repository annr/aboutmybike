let express = require('express');
let router = express.Router();

router.get('/', function (req, res, next) {
  res.render('profile', {
    page_title: 'Profile',
    username: req.user.username,
  });
});


module.exports = router;
