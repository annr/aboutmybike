var promise = require('bluebird');
var fs = require('fs');

var options = {
  // Initialization Options
  promiseLib: promise
};

var pgp = require('pg-promise')(options);

// default (development) options:
var connectionObject = {
  host: 'localhost',
  port: 5432,
  database: 'amb',
  user: 'arobson'
};

// if any AWS-configured values are set, it's prod
if(process.env.RDS_HOSTNAME !== undefined) {
  connectionObject = {
    host: process.env.RDS_HOSTNAME,
    port: process.env.RDS_PORT,
    database: process.env.RDS_DB_NAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD
  };
}

var db = pgp(connectionObject);

module.exports = db;