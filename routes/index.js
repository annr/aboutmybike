var express = require('express');
var router = express.Router();
const pg = require('pg');
const path = require('path');

let connection = {
    host: process.env.RDS_HOSTNAME,
    port: process.env.RDS_PORT,
    database: process.env.RDS_DB_NAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD
};

router.get('/', (req, res, next) => {
  if(req.app.get('env') === 'development') {
    connection = 'postgres://localhost:5432/amb';
  }
  const results = [];
  // Get a Postgres client from the connection pool
  pg.connect(connection, (err, client, done) => {
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
      res.render('index', { title: 'About My Bike Home', results: results});
    });
  });
});

/* GET home page. */
// router.get('/', function(req, res, next) {
//   res.render('index', { title: 'Express' });
// });

module.exports = router;
