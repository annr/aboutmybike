/* DEPRECATED. THIS FILE WILL BE REMOVED. */

let promise = require('bluebird');
let fs = require('fs');

let options = {
  // Initialization Options
  promiseLib: promise,
};

let pgp = require('pg-promise')(options);

// default (development) options:
let connectionObject = {
  host: 'localhost',
  port: 5432,
  database: 'amb',
  user: 'arobson',
};

// if any AWS-configured values are set, it's prod
if (process.env.RDS_HOSTNAME !== undefined) {
  connectionObject = {
    host: process.env.RDS_HOSTNAME,
    port: process.env.RDS_PORT,
    database: process.env.RDS_DB_NAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD,
  };
}

let db = pgp(connectionObject);

module.exports = db;
