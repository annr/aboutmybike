var express = require('express');
var router = express.Router();

const db = require('./db/queries');

router.get('/bikes', db.getAllBikes);
router.get('/bike/:id', db.getSingleBike);
router.post('/bike/create', db.createBike);
router.put('/bike/:id', db.updateBike);
router.delete('/bike/:id', db.removeBike);

module.exports = router;