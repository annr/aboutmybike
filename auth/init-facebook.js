const passport = require('passport');
const FacebookStrategy = require('passport-facebook').Strategy;
const oauth = require('./oauth');
const config = require('../config').appConfig;
let db = require('../db/db');
let AWS = require('aws-sdk');

const authenticationMiddleware = require('./middleware');

passport.serializeUser(function (user, callback) {
  callback(null, user.id);
});

passport.deserializeUser(function (id, callback) {
  db.one('select u.*, user_photo.web_url as picture, bike.id as bike_id from amb_user u left join bike on bike.user_id = u.id left join user_photo on user_photo.user_id = u.id where u.id = $1 limit 1;', id)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed get user: (' + err + ')'));
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
      db.one('select u.*, user_photo.web_url as picture, bike.id as bike_id from amb_user u left join bike on bike.user_id = u.id left join user_photo on user_photo.user_id = u.id where u.facebook_id = $1 limit 1;', profile.id)
        .then(function (data) {
          // let user = {
          //   id: data.id,
          //   facebook: profile,
          //   amb: data
          // }
          // TO-DO: update last login.
          callback(null, data);
        })
        .catch(function (err) {
          // send SNS alerting there is a new user.
          let sns = new AWS.SNS();
          let params;
          params = {
            Message: JSON.stringify(profile),
            Subject: 'User Signup',
            TopicArn: config.topicArn + config.snsUserSignupTopicName
          };
          sns.publish(params, function(err, data) {
            if (err) {
              console.err('Error sending User Signup SNS: ' + err);
            }
          });

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
          db.one('insert into amb_user(facebook_id, first_name, last_name, gender, email) ' +
              'values($1, $2, $3, $4, $5) returning *', [profile.id, first_name, last_name, gender, profile.emails[0].value])
            .then(function (data) {
              // add profile photo:
              db.one('insert into user_photo(user_id, web_url) ' +
                  'values($1, $2) returning *', [data.id, profile.photos[0].value])
                .then(function (data) {
                  callback(null, data);
                })
                .catch(function (err) {
                  callback(new Error('Failed to create new user and user photo records. (' + err + ')'));
                });
              callback(null, data);
            })
            .catch(function (err) {
              callback(new Error('Failed to create new user. (' + err + ')'));
            });
        });
    }
  ));

  passport.authenticationMiddleware = authenticationMiddleware;
}

module.exports = initPassport;
