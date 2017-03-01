const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
var db = require('../db/db');

const authenticationMiddleware = require('./middleware');

passport.serializeUser(function (user, callback) {
  callback(null, user.id);
});

passport.deserializeUser(function (id, callback) {
  db.one('select * from amb_user where id = $1', [parseInt(id)])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error('Failed get user: (' + err + ')'));
    });
});

function initPassport () {
  passport.use(new LocalStrategy(
    function(username, password, callback) {
      db.one('select * from amb_user where username = $1', [username])
        .then(function (data) {
          callback(null, data);
        })
        .catch(function (err) {
          callback(new Error('Failed get user: (' + err + ')'));
        });
    }
  ));

  passport.authenticationMiddleware = authenticationMiddleware;
}

module.exports = initPassport;
