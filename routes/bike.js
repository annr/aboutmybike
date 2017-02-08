var express = require('express');
var router = express.Router();

/* GET bike listing. */
router.get('/', function(req, res, next) {
  res.send('return with a response');
});

module.exports = router;
