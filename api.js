let express = require('express');
let router = express.Router();

const api = require('./db/api-methods');

router.get('/brands', api.getAllManufacturers);
router.get('/brand_by_name/:name', api.getManufacturerByName);
router.get('/models_by_brand/:id', api.getModelsByBrandId);

module.exports = router;