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

function createFacebookUser(values, callback) { // profile.id, first_name, last_name, gender, profile.emails[0].value
  db.amb_user.add_facebook(values)
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

function getUserWithLoginValues(email, username, callback) {
  db.amb_user.select_with_login_values([email, username])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed get user record with username or email: (${err})`));
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
  db.amb_user.set_verified(id)
    .catch(function (err) {
      throw new Error(`Failed to set verified switch for user ${id}: (${err})`);
    });
}

function setVerifiedByUsername(username, value, callback) {
  var toggle = value === '1' ? true : false;
  db.amb_user.set_verified_by_username([username, toggle])
    .then(function () {
      callback(null);
    })
    .catch(function (err) {
      throw new Error(`Failed to set verified switch for user ${username}: (${err})`);
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

function updateProfile(id, bio, website, callback) {
  db.amb_user.update_profile([id, bio, website])
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      throw new Error(`Failed to update profile for ${id}: (${err})`);
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
  setVerifiedByUsername,
  updatePasswordOfUsername,
  addUsernameAndVerify,
  updateProfile,
  getUserWithLoginValues,
}