'use strict';

var sql = require('../sql').photo;

module.exports = (rep, pgp) => {
  return {

    // Adds a new bike, and returns the new id;
    add: values =>
      rep.one(sql.add, values, photo => photo.id),

    update: values => // [id, file_path]
      rep.result(sql.update, values),

    select: id =>
      rep.one(sql.select, id, photo => photo),

    bike_id_select: bike_id => // LATER A BIKE CAN MORE THAN ONE PHOTO!!!! CHANGE THE RETURN
      rep.one(sql.bike_id_select, photo => photo),

  };
};
