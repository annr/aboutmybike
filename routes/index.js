let express = require('express');
let app = express();
let router = express.Router();
const pg = require('pg');
const path = require('path');
const db = require('../db/queries');

//let connection = 'postgres://localhost:5432/amb';
let connection = {
    host: process.env.RDS_HOSTNAME,
    port: process.env.RDS_PORT,
    database: process.env.RDS_DB_NAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD
};

/*
router.get('/', (req, res, next) => {
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
*/

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'AMB' });
});

router.get('/api/bikes', db.getAllBikes);
router.get('/api/bike/:id', db.getSingleBike);
router.post('/api/bike/create', db.createBike);
router.put('/api/bike/:id', db.updateBike);
router.delete('/api/bike/:id', db.removeBike);

module.exports = router;
