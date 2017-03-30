const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
let db = require('../db');
const bcrypt = require('bcrypt');
const authenticationMiddleware = require('./middleware');
let util = require('util');

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
  passport.use(new LocalStrategy({
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

  passport.authenticationMiddleware = authenticationMiddleware;
}

module.exports = initPassport;
