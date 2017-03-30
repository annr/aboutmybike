'use strict';

var sql = require('../sql').amb_user;

module.exports = (rep, pgp) => {
  return {

    // Adds a new bike, and returns user
    add: values =>
      rep.one(sql.add, values, amb_user => amb_user),

    // Adds a new bike, and returns user
    add_facebook: values =>
      rep.one(sql.add_facebook, values, amb_user => amb_user),

    update_last_login: id =>
      rep.result(sql.update_last_login, id),

    update_profile: values =>
      rep.result(sql.update_profile, values),

    update_last_fb_login: facebook_id =>
      rep.result(sql.update_last_fb_login, facebook_id),

    select: id =>
      rep.one(sql.select, id, amb_user => amb_user),

    username_select: username =>
      rep.one(sql.username_select, username, amb_user => amb_user),

    fb_select: facebook_id =>
      rep.one(sql.fb_select, facebook_id, amb_user => amb_user),

    verified: id =>
      rep.result(sql.verified, id),

    update_password: values =>
      rep.result(sql.update_password, values),

    update_username: values =>
      rep.result(sql.update_username, values),

  };
};