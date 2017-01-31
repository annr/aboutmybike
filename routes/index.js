var express = require('express');
var router = express.Router();

const db = require('../db/queries');

router.get('/', function(req, res, next) {
  res.render('index', { title: 'About My Bike', layout: 'layout' });
});

router.get('/api/bikes', db.getAllBikes);
router.get('/api/bike/:id', db.getSingleBike);
router.post('/api/bike/create', db.createBike);
router.put('/api/bike/:id', db.updateBike);
router.delete('/api/bike/:id', db.removeBike);

module.exports = router;
