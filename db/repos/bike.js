'use strict';

var sql = require('../sql').bike;

module.exports = (rep, pgp) => {
  return {

    // Adds a new bike, and returns the new id;
    add: user_id =>
      rep.one(sql.add, user_id, bike => bike),

    all: () =>
      rep.any(sql.all),

    select: id =>
      rep.one(sql.select, id, bike => bike),

    update: values => // -- [fields.description, fields.nickname, ${fields.type_id}, ${fields.reasons}  parseInt(fields.bike_id)])
      rep.result(sql.update, values),

    update_basics: values =>
      rep.result(sql.update_basics, values),

    update_main_photo: (main_photo_path, bike_id) =>
      rep.result(sql.update_main_photo, main_photo_path, bike_id),
  };
};
