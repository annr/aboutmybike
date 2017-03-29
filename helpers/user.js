let db = require('../db');
let util = require('util');

function createUser(values, callback) {
  db.amb_user.add(values)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed to create new user: (${err})`));
    });
}

function getUser(userID, callback) {
//  db.one('select * from bike where id = $1', bikeID)
  db.amb_user.select(userID)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed get user record: (${err})`));
    });
}

function getUserByUsername(username, callback) {
//  db.one('select * from bike where id = $1', bikeID)
  db.amb_user.username_select(username)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed get user record with username: (${err})`));
    });
}

function getFacebookUser(facebookID, callback) {
//  db.one('select * from bike where id = $1', bikeID)
  db.amb_user.fb_select(facebookID)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed get Facebook user record: (${err})`));
    });
}

function createPhoto(userID, photoPath, callback) {
  db.user_photo.add([userID, photoPath])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      throw new Error(`Failed insert user_photo record: (${err})`);
    });
}

function setLastLogin(id) {
  db.amb_user.update_last_fb_login(id)
    .catch(function (err) {
      throw new Error(`Failed update last_login for user ${id}: (${err})`);
    });
}

module.exports = {
  createUser,
  getUser,
  getUserByUsername,
  getFacebookUser,
  createPhoto,
  setLastLogin,
}