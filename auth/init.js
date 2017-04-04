const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
let db = require('../db');
const authenticationMiddleware = require('./middleware');
let util = require('util');

const userHelper = require('../helpers/user.js');
var bcrypt = require('bcrypt');
const saltRounds = 10;

passport.serializeUser(function (user, callback) {
  callback(null, user.id);
});

passport.deserializeUser(function (id, callback) {
  userHelper.getUserForDeserialize(id, function (err, data) {
    if (err) {
      callback(err);
    } else {
      callback(null, data);
    }
  });
});

function validateEmail(email) {
  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}

function initPassport () {

  passport.use('local-login',
    new LocalStrategy({
      usernameField: 'username',
      passwordField: 'password',
      passReqToCallback : true
    },
    function(req, username, password, done) {
      // user can enter email or usename
      // the "username" field holds either.
      let email = null;
      let confirmed_username = username;
      if(validateEmail(username)) {
        email = username;
        confirmed_username = null;
      }
      userHelper.getUserWithLoginValues(email, confirmed_username, function(err, data) {
        if (err) {
          return done(null, false, req.flash('flashMessage', 'No user found.'));
        } else {
          if (data.facebook_id) {
            return done(null, false, req.flash('flashMessage', 'This username or email is associated with a Facebook account. Please continue with Facebook or contact About My Bike support.'));
          }
          if (!data.password) {
            return done(null, false, req.flash('flashMessage', 'Password is not set for this user. Please contact support.'));
          }
          bcrypt.compare(password, data.password, function(err, res) {
            if (err) {
              return done(err);
            }
            if (res) {
              return done(null, data);
            } else {
              return done(null, false, req.flash('flashMessage', 'Incorrect password.'));
            }
          });
        }
      });
    }
  ));

  passport.use('local-signup',
    new LocalStrategy({
      usernameField: 'username',
      passwordField: 'password',
      passReqToCallback : true
    },
    function(req, username, password, done) {
      // if the user is already logged in, don't do anything.
      if (req.user) {
        return done(null, req.user); // you're logged in alrady!!!
      } else {

        if (req.body.email && username && password) {
          let email = req.body.email.toLowerCase();
          username = username.toLowerCase();

          userHelper.getUserWithLoginValues(email, username, function(err, data) {
            if (err) {

              // insert user record
              bcrypt.hash(password, saltRounds, function(err, hash) {
                if(err) {
                  return done(err);
                }
                // Store hash in your password DB.
                userHelper.createUser([email, username, hash], function(err, data) {
                  if(err) {
                    return done(err);
                  }
                  return done(null, data);
                });

              });

            } else {
              // you can try to log them in with password they provided.
              // either username or email was found.
              if (email === data.email) {
                if (data.facebook_id) {
                  return done(null, false, req.flash('flashMessage', 'You\'ve previously logged in with Facebook. Do you want to continue with Facebook?'));
                }
                return done(null, false, req.flash('flashMessage', 'The email you entered belongs to an existing user. If you forgot your password please contact support.'));
              }
              if (username === data.username) {
                return done(null, false, req.flash('flashMessage', 'Username is associated with an existing account. Please log in or choose another username.'));
              }
              return done(null, false, req.flash('flashMessage', 'Email or username are used by an existing account.'));
            }

          });

        } else {
          return done(null, req.user); // you're logged in alrady!!!
        }

      }
    }
  ));

  passport.authenticationMiddleware = authenticationMiddleware;
}

module.exports = initPassport;
