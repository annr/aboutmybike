let express = require('express');
let router = express.Router();

router.get('/', function (req, res, next) {
  res.render('index', {
    page_title: 'Home',
    flash_message: req.flash('flashMessage'),
  });
});

module.exports = router;
