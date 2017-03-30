let express = require('express');
let router = express.Router();
const userHelper = require('../helpers/user.js');

var bcrypt = require('bcrypt');
const saltRounds = 10;

router.post('/', function (req, res, next) {
  
  // if username exists, redirect to login.
  // (although we should put this test in client ajax)

  // insert user record
  bcrypt.hash(req.body.password, saltRounds, function(err, hash) {
    // Store hash in your password DB.
    userHelper.createUser([req.body.email, req.body.username, hash], function(data) {
      res.redirect('/add');
    });
  });

});

module.exports = router;
