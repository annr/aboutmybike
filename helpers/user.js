let db = require('../db');
let util = require('util');

function createUser(values, callback) {
  db.amb_user.add(values)
    .then(function (data) {
      console.log('inserted user maybe: ');
      console.log(util.inspect(data));
    })
    .catch(function (err) {
      callback(new Error(`Failed to create bike record: (${err})`));
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

function getFacebookUser(facebookID, callback) {
//  db.one('select * from bike where id = $1', bikeID)
  db.amb_user.select(facebookID)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed get Facebook user record: (${err})`));
    });
}

function createPhoto(userID, photoPath) {
  console.log('In crate ohoho');
  db.user_photo.add([userID, photoPath])
    .catch(function (err) {
      throw new Error(`Failed insert user_photo record: (${err})`);
    });
}

module.exports = {
  createUser,
  getUser,
  getFacebookUser,
  createPhoto,
}