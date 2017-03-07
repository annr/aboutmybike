'use strict';

var sql = require('../sql').photo;

module.exports = (rep, pgp) => {
  return {

    // Adds a new bike, and returns the new id;
    add: values =>
      rep.one(sql.add, values, photo => photo.bike_id),

  };
};
