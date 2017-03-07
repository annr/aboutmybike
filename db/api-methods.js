let db = require('../db');

function getAllManufacturers(req, res, next) {
  db.any('select id as value, name as label from manufacturer order by market_size')
    .then(function (data) {
      res.status(200).json(data);
    })
    .catch(function (err) {
      return next(err);
    });
}

function getManufacturerByName(req, res, next) {
  let name = req.params.name;
  db.one(`${'select * from manufacturer where name ilike ' + "'"}${name}%' limit 1`)
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data,
          message: 'Retrieved Brand',
        });
    })
    .catch(function (err) {
      res.status(404)
        .json({
          status: 'error',
          message: 'No data returned',
          data: {
            id: 0,
            name: 'New or Unknown Brand',
          },
        });
    });
}

function getModelsByBrandId(req, res, next) {
  let manuID = parseInt(req.params.id);
  db.any('select id as value, name as label from model where manufacturer_id = $1', manuID)
    .then(function (data) {
      res.status(200).json(data);
    })
    .catch(function (err) {
      return next(err);
    });
}

module.exports = {
  getAllManufacturers,
  getManufacturerByName,
  getModelsByBrandId,
};
