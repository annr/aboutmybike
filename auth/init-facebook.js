const passport = require('passport');
const FacebookStrategy = require('passport-facebook').Strategy;
const config = require('./oauth');
var db = require('../db/db');

const authenticationMiddleware = require('./middleware');

passport.serializeUser(function (user, callback) {
  callback(null, user.id);
});

passport.deserializeUser(function (id, callback) {
  db.one('select u.*, bike.id as bike_id from amb_user u left join bike on bike.user_id = u.id where u.id = $1 limit 1;', id)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed get user: (' + err + ')'));
    });
});

function initPassport () {
  var keys;
  // we should have a better way to determine if env is prod.
  // at least extract this into a helper funtion
  if(process.env.RDS_HOSTNAME !== undefined) {
    keys = config.production;
  } else {
    keys = config.localhost;
  }
  passport.use(new FacebookStrategy({
      clientID: keys.clientID,
      clientSecret: keys.clientSecret,
      callbackURL: keys.callbackURL,
      profileFields: ['id', 'first_name', 'last_name', 'gender', 'website', 'email']
    },
    function(accessToken, refreshToken, profile, callback) {
      db.one('select u.*, bike.id as bike_id from amb_user u left join bike on bike.user_id = u.id where u.facebook_id = $1 limit 1;', profile.id)
        .then(function (data) {
          // var user = {
          //   id: data.id,
          //   facebook: profile,
          //   amb: data
          // }
          // TO-DO: update last login.
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
              // var user = {
              //   id: data.id,
              //   facebook: profile,
              //   amb: data
              // }
              // TO-DO: update last login.
              console.log('AMB: creating new user.');
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
