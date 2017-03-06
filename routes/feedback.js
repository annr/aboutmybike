let express = require('express');
let router = express.Router();
const config = require('../config').appConfig;
let AWS = require('aws-sdk');
AWS.config.region = config.awsRegion;

/* GET bike listing. */
router.get('/', function(req, res, next) {
  res.render('feedback', {
    page_title: 'Feedback / Questions',
    is_feedback_page: true
  });
});

router.post('/', function(req, res, next) {
  let email = req.body.email;
  let comments = req.body.comments;
  let sns = new AWS.SNS();
  let params = {
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
