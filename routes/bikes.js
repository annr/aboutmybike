var express = require('express');
var router = express.Router();

const pg = require('pg');

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

router.get('/', (req, res, next) => {
  const results = [];
  // Get a Postgres client from the connection pool
  pg.connect(connectionObject, (err, client, done) => {
    // Handle connection errors
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({success: false, data: err});
    }
    // SQL Query > Select Data
    const query = client.query('SELECT * FROM bike;');
    // Stream results back one row at a time
    query.on('row', (row) => {
      results.push(row);
    });
    // After all data is returned, close connection and return results and show index page)
    query.on('end', () => {
      done();
      res.render('bikes', { layout: 'layout', title: 'About My Bike', results: results});
    });
  });
});

module.exports = router;