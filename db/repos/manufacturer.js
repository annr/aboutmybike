'use strict';

var sql = require('../sql').manufacturer;

module.exports = (rep, pgp) => {
  return {
    all: () =>
      rep.any(sql.all),
  };
};
