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

function createFacebookUser(values, callback) {
  db.amb_user.add(values)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed to create new facebook user: (${err})`));
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

function setVerified(id) {
  db.amb_user.verify(id)
    .catch(function (err) {
      throw new Error(`Failed to set verified switch for user ${id}: (${err})`);
    });
}

function updatePasswordOfUsername(username, password, callback) {
  db.amb_user.update_password([username, password])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      throw new Error(`Failed to update password for ${username}: (${err})`);
    });
}


function addUsernameAndVerify(username, id, callback) {
  db.amb_user.update_username([parseInt(id), username])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      throw new Error(`Failed to update username for ${id}: (${err})`);
    });
}

module.exports = {
  createUser,
  createFacebookUser,
  getUser,
  getUserByUsername,
  getFacebookUser,
  createPhoto,
  setLastLogin,
  setVerified,
  updatePasswordOfUsername,
  addUsernameAndVerify,
}