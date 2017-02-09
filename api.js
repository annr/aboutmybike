var express = require('express');
var router = express.Router();

const db = require('./db/api-methods');

router.get('/bikes', db.getAllBikes);
router.get('/bike/:id', db.getBike);
router.put('/bike/:id', db.updateBike);
router.delete('/bike/:id', db.removeBike);
router.get('/brands', db.getAllManufacturers);
router.get('/brand_by_name/:name', db.getManufacturerByName);
router.get('/models_by_brand/:id', db.getModelsByBrandId);

module.exports = router;