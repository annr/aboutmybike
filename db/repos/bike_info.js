'use strict';

var sql = require('../sql').bike_info;

module.exports = (rep, pgp) => {
  return {

    // Adds a new bike, and returns the new id;
    add: bike_id =>
      rep.one(sql.add, bike_id, bike_info => bike_info.bike_id),

    update: values => // -- color, era, bike_id
      rep.result(sql.update, values),

  };
};
