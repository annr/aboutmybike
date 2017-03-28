let express = require('express');
let router = express.Router();

/* GET bike listing. */
router.get('/', function (req, res, next) {
  res.render('privacy', {
    page_title: 'Privacy Policy'
  });
});

module.exports = router;
