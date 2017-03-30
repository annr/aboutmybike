const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
let db = require('../db');
const authenticationMiddleware = require('./middleware');
let util = require('util');

const userHelper = require('../helpers/user.js');
var bcrypt = require('bcrypt');
const saltRounds = 10;

passport.serializeUser(function (user, callback) {
  console.log('in serizalize user');
  callback(null, user.id);
});

passport.deserializeUser(function (id, callback) {
  console.log('in deserizalize user');
  db.one('select * from amb_user where id = $1', [parseInt(id)])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(err);
    });
});

function initPassport () {


  passport.use('local-login',
    new LocalStrategy({
      usernameField: 'username',
      passwordField: 'password',
      passReqToCallback : true
    },
    function(req, username, password, callback) {
      db.one('select * from amb_user where username = $1', [username])
        .then(function (data) {
          if (!data) {
            return callback(null, false, req.flash('flashMessage', 'No user found.'));
          }

          if (data.facebook_id) {
            return callback(null, false, req.flash('flashMessage', 'This username or email is associated with a Facebook account. Please continue to log in with Facebook or contact About My Bike support.'));
          }

          if (!data.password) {
            return callback(null, false, req.flash('flashMessage', 'Password is not set for this user. Please contact support.'));
          }
          bcrypt.compare(password, data.password, function(err, res) {
            if (err) {
              return callback(err);
            }
            if (res) {
              return callback(null, data);
            } else {
              return callback(null, false, req.flash('flashMessage', 'Incorrect password.'));
            }
          });

        })
        .catch(function (err) {
          return callback(err);
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

          /// TO-DO: test if username or email already exists!!!!
          ////
          ///

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
                return done(null, false, req.flash('flashMessage', 'The email you entered belongs to an existing user. Please log in or contact support if this is your email.'));
              }
              if (username === data.username) {
                return done(null, false, req.flash('flashMessage', 'Username is associated with an existing account. Please log in or choose another username.'));
              }
              return done(null, false, req.flash('flashMessage', 'Email or username are used by an existing account.'));
            }

          });

        } else {
          console.log('missing signup fields.');

          //return done(null, req.user); // you're logged in alrady!!!
        }

      }
    }
  ));

  passport.authenticationMiddleware = authenticationMiddleware;
}

module.exports = initPassport;
