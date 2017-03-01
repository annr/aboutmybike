var express = require('express');
var router = express.Router();
const config = require('../config').appConfig;
var AWS = require('aws-sdk');
AWS.config.region = config.awsRegion;

/* GET bike listing. */
router.get('/', function(req, res, next) {
  throw new Error('fake error');
  res.render('feedback', {
    page_title: 'Feedback / Questions',
    is_feedback_page: true
  });
});

router.post('/', function(req, res, next) {
  var email = req.body.email;
  var comments = req.body.comments;
  var sns = new AWS.SNS();
  var params = {
    Message: comments + "\n- - -\n\nFrom:\n" + email,
    Subject: 'Inquiry from ' + email,
    TopicArn: config.topicArn + config.snsContactFormTopicName
  };
  sns.publish(params, function(err, data) {
    if (err) {
      throw new Error('Contact form submission error: ' + err)
      res.json({error : err, status : 500 });
    }
    else {
      res.json({success : "Feedback sent.", status : 200 });
    }
  });
});

module.exports = router;
