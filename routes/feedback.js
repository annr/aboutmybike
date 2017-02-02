
var express = require('express');
var router = express.Router();

var AWS = require('aws-sdk');
// Initialize the Amazon Cognito credentials provider
AWS.config.region = 'us-west-1'; // Region
// AWS.config.credentials = new AWS.CognitoIdentityCredentials({
//     IdentityPoolId: 'eu-west-1:e4c24108-5050-42f8-ac0b-761c46aa947f',
// });

/* GET bike listing. */
router.get('/', function(req, res, next) {
  res.render('feedback', {
    app_name: res.locals.app.name,
    page_title: 'Feedback / Questions',
    formSubmissionSuccess: false // just being explicit. when it's a get we don't show confirmation 
  });
});

router.post('/', function(req, res, next) {
  var feedback = sendFeedback(req.body.email, req.body.comments);  
  res.render('feedback', {
    app_name: res.locals.app.name,
    page_title: 'Feedback / Questions',
    formSubmissionSuccess: true
  });
});

sendFeedback = function(email, comments) {
    var sns = new AWS.SNS();
    var params = {
        Message: comments + "\n\nFrom:\n" + email,
        Subject: 'AMB Feedback / Questions Submission',
        TopicArn: 'arn:aws:sns:us-west-1:619254428467:ElasticBeanstalkNotifications-Environment-aboutmybike-dev'
    };
    sns.publish(params, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else return true;
    });
};



module.exports = router;
