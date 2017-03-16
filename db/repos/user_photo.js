'use strict';

var sql = require('../sql').user_photo;

module.exports = (rep, pgp) => {
  return {

    // Adds a new bike, and returns the new id;
    add: values =>
      rep.one(sql.add, values, user_photo => user_photo),

  };
};
