const passport = require('passport');
const FacebookStrategy = require('passport-facebook').Strategy;
const config = require('./oauth');
const util = require('util');

const authenticationMiddleware = require('./middleware');

function findUser (username, callback) {
  if (username === user.username) {
    return callback(null, user)
  }
  return callback(null)
}

passport.serializeUser(function(user, cb) {
  //nothing to do here as we use the username as it is
  cb(null, user);
} );

passport.deserializeUser(function(obj, cb) {
  //again, we just pass the username forward
  cb(null, obj);
});

function initPassport() {
  console.log('in initPassport FB');
  passport.use( new passportFacebook({
    clientID: FACEBOOK_ID,
    clientSecret: FACEBOOK_SECRET,
    callbackURL: '//localhost/login/facebook/return'
  },
  function(accessToken, refreshToken, profile, cb) {
    return cb(null, profile);
  }));

  passport.authenticationMiddleware = authenticationMiddleware
}

module.exports = initPassport;
