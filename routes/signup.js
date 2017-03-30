let express = require('express');
let router = express.Router();

router.get('/', function (req, res, next) {
  res.render('signup', {
    page_title: 'Sign up',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
