// Bluebird is the best promise library available today,
// and is the one recommended here:
let promise = require('bluebird');

// Loading all the database repositories separately,
// because event 'extend' is called multiple times:
let repos = {
  bike: require('./repos/bike'),
  bike_info: require('./repos/bike_info'),
  manufacturer: require('./repos/manufacturer'),
};

// pg-promise initialization options:
let options = {

    // Use a custom promise library, instead of the default ES6 Promise:
  promiseLib: promise,

    // Extending the database protocol with our custom repositories:
  extend: (obj) => {
        // Do not use 'require()' here, because this event occurs for every task
        // and transaction being executed, which should be as fast as possible.
    obj.bike = repos.bike(obj, pgp);
    obj.bike_info = repos.bike_info(obj, pgp);
    obj.manufacturer = repos.manufacturer(obj, pgp);

        // Alternatively, you can set all repositories in a loop:
        //
        // for (let r in repos) {
        //    obj[r] = repos[r](obj, pgp);
        // }
  },

};

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

// Load and initialize pg-promise:
let pgp = require('pg-promise')(options);

// Create the database instance:
let db = pgp(connectionObject);

// Load and initialize optional diagnostics:
let diag = require('./diagnostics');
diag.init(options);

// If you ever need to change the default pool size, here's an example:
// pgp.pg.defaults.poolSize = 20;

// Database object is all that's needed.
// If you even need access to the library's root (pgp object),
// you can do it via db.$config.pgp
// See: http://vitaly-t.github.io/pg-promise/Database.html#.$config
module.exports = db;
