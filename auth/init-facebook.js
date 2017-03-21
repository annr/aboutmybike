const passport = require('passport');
const FacebookStrategy = require('passport-facebook').Strategy;
const oauth = require('./oauth');
const config = require('../config').appConfig;
let db = require('../db');
let AWS = require('aws-sdk');
const userHelper = require('../helpers/user.js');

const authenticationMiddleware = require('./middleware');

passport.serializeUser(function (user, callback) {
  callback(null, user.id);
});

passport.deserializeUser(function (id, callback) {
  userHelper.getUser(id, function (err, data) {
    if (err) {
      callback(new Error('Failed to get user by id: (' + err + ')'));
    } else {
      callback(null, data);
    }
  });
});

function initPassport () {
  let keys;
  // we should have a better way to determine if env is prod.
  // at least extract this into a helper funtion
  if(process.env.RDS_HOSTNAME !== undefined) {
    keys = oauth.production;
  } else {
    keys = oauth.localhost;
  }
  passport.use(new FacebookStrategy({
      clientID: keys.clientID,
      clientSecret: keys.clientSecret,
      callbackURL: keys.callbackURL,
      profileFields: ['id', 'first_name', 'last_name', 'gender', 'website', 'email', 'photos']
    },
    function(accessToken, refreshToken, profile, callback) {
      userHelper.getFacebookUser(profile.id, function (err, data) {
        if (err) {
          // send SNS alerting there is a new user.
          // let sns = new AWS.SNS();
          // let params;
          // params = {
          //   Message: JSON.stringify(profile),
          //   Subject: 'User Signup',
          //   TopicArn: config.topicArn + config.snsUserSignupTopicName
          // };
          // sns.publish(params, function(err, data) {
          //   if (err) {
          //     console.err('Error sending User Signup SNS: ' + err);
          //   }
          // });

          let first_name = null;
          let last_name = null;
          let gender = null;
          if(profile.gender) {
            gender = profile.gender;
          }
          if(profile.name) {
            if(profile.name.givenName) {
              first_name = profile.name.givenName;
            }
            if(profile.name.familyName) {
              last_name = profile.name.familyName;
            }
          }

          userHelper.createUser([profile.id, first_name, last_name, gender, profile.emails[0].value], function (err, data) {
            if (err) {
              callback(new Error('Failed to create new user. (' + err + ')'));
            } else {
              userHelper.createPhoto(data.id, profile.photos[0].value, function(err, data) {
                if (err) {
                  callback(new Error('Failed to create user profile photo. (' + err + ')'));
                } else {
                  callback(null, data);
                }
              });
              callback(null, data);
            }
          });
        } else {
          // existing user logged in again.
          userHelper.setLastLogin(profile.id);
          callback(null, data);
        }
      });
    }
  ));

  passport.authenticationMiddleware = authenticationMiddleware;
}

module.exports = initPassport;
