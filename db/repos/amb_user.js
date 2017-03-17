'use strict';

var sql = require('../sql').amb_user;

module.exports = (rep, pgp) => {
  return {

    // Adds a new bike, and returns the new id;
    add: values =>
      rep.one(sql.add, values, amb_user => amb_user),

    update_last_login: id => // -- last_login
      rep.result(sql.update_last_login, id),

    select: id =>
      rep.one(sql.select, id, amb_user => amb_user),

    username_select: username =>
      rep.one(sql.username_select, username, amb_user => amb_user),

    fb_select: facebook_id =>
      rep.one(sql.fb_select, facebook_id, amb_user => amb_user),

  };
};
