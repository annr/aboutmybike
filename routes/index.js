var express = require('express');
var router = express.Router();
var util = require('util');

router.get('/', function(req, res, next) {

/*
  var sess = req.session;
  if (sess.views) {
    sess.views++;
    res.setHeader('Content-Type', 'text/html');
    console.log('<p>views: ' + sess.views + '</p>');
    console.log('<p>expires in: ' + (sess.cookie.maxAge / 1000) + 's</p>');
  } else {
    sess.views = 1;
    res.end('welcome to the session demo. refresh!')
  }
  */

  //console.log(util.inspect(res.app.locals));

  res.render('index', {
    page_title: 'Home',
    //session: sess,
    //user: req.user
  });
});

module.exports = router;
