let express = require('express');
let router = express.Router();

/* GET bike listing. */
router.get('/', function (req, res, next) {
  res.render('terms', {
    page_title: 'Terms of Service'
  });
});

module.exports = router;