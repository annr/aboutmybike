let express = require('express');
let router = express.Router();

router.get('/', function (req, res, next) {

  if(req.user) {
    req.flash('flashMessage', 'You are already logged in.')
    res.redirect('/');
  }

  res.render('signup', {
    page_title: 'Sign up',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
