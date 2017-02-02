/*
 * Copyright 2013. Amazon Web Services, Inc. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
**/

var AWS = require('aws-sdk');

// Initialize the Amazon Cognito credentials provider
AWS.config.region = 'us-west-1'; // Region
// AWS.config.credentials = new AWS.CognitoIdentityCredentials({
//    IdentityPoolId: 'eu-west-1:e4c24108-5050-42f8-ac0b-761c46aa947f',
// });

sendFeedback = function() {
    var sns = new AWS.SNS();
    var params = {
        Message: 'oh hey',
        Subject: 'Browser SNS publish - contact form',
        TopicArn: 'arn:aws:sns:us-west-1:619254428467:amb-contact-form'
    };
    sns.publish(params, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else     console.log(data);           // successful response
    });
};

sendFeedback();