const passport = require('passport');
const FacebookStrategy = require('passport-facebook').Strategy;
const config = require('./oauth');
const util = require('util');
var db = require('../db/db');

const authenticationMiddleware = require('./middleware');

passport.serializeUser(function (user, callback) {
  callback(null, user.id);
});

passport.deserializeUser(function (id, callback) {
  db.one('select * from amb_user where id = $1', id)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed get user: (' + err + ')'));
    });
});

function initPassport () {
  passport.use(new FacebookStrategy({
      clientID: config.facebook.clientID,
      clientSecret: config.facebook.clientSecret,
      callbackURL: config.facebook.callbackURL,
      profileFields: ['id', 'first_name', 'last_name', 'gender', 'website', 'email']
    },
    function(accessToken, refreshToken, profile, callback) {
      console.log('PROFILE: ');
      console.log(util.inspect(profile));

      db.one('select * from amb_user where facebook_id = $1', profile.id)
        .then(function (data) {
          // update last login.
          console.log('GOT USER: ');
          console.log(util.inspect(data));
          callback(null, data);
        })
        .catch(function (err) {
          var first_name = null;
          var last_name = null;
          var gender = null;
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
              callback(null, data);
            })
            .catch(function (err) {
              callback(new Error('Failed to get user and create bike record: (' + err + ')'));
            });
        });
    }
  ));

  passport.authenticationMiddleware = authenticationMiddleware;
}

module.exports = initPassport;
