var db = require('./db');

// add query functions

function getAllBikes(req, res, next) {
  db.any('select * from bike')
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL bikes'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function getSingleBike(req, res, next) {
  var bikeID = parseInt(req.params.id);
  db.one('select * from bike where id = $1', bikeID)
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ONE bike'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function createBike(req, res, next) {
  var previewPath = req.body.preview_path;
  db.one('insert into bike(user_id, style, brand, model) ' +
      'values($1, $2, $3, $4) returning id', [parseInt(req.body.user_id), req.body.style, req.body.brand, req.body.model])
    .then(function (data) {
      var bikeId = data.id;
      var newDir = 'dist/images/mock/';
      var extension = previewPath.split('.')[1];
      var newPath = newDir+data.id+'.'+extension;
      fs.rename(previewPath, newPath, function() {
        console.log('successfully moved preview image');
      });
      res.status(200)
        .json({
          status: 'success',
          bikeId: bikeId
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function updateBike(req, res, next) {
  db.none('update bike set style=$1, brand=$2, model=$3, nickname=$4 where id=$5',
    [req.body.style, req.body.brand, req.body.model,
      req.body.nickname, parseInt(req.params.id)])
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Updated bike'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function removeBike(req, res, next) {
  var bikeID = parseInt(req.params.id);
  db.result('delete from bike where id = $1', bikeID)
    .then(function (result) {
      /* jshint ignore:start */
      res.status(200)
        .json({
          status: 'success',
          message: `Removed ${result.rowCount} bike`
        });
      /* jshint ignore:end */
    })
    .catch(function (err) {
      return next(err);
    });
}

function getAllManufacturers(req, res, next) {
  db.any('select id as value, name as label from manufacturer')
    .then(function (data) {
      res.status(200).json(data);
    })
    .catch(function (err) {
      return next(err);
    });
}

function getManufacturerByName(req, res, next) {
  var name = req.params.name;
  db.one("select * from manufacturer where name ilike " + "'" + name + "%' limit 1")
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved Brand'
        });
    })
    .catch(function (err) {
      res.status(404)
        .json({
          status: 'error',
          message: 'No data returned',
          data: {
            id: 0,
            name: "New or Unknown Brand"
          }
        });
    });
}

function getModelsByBrandId(req, res, next) {
  var manuID = parseInt(req.params.id);
  db.any('select id as value, name as label from model where manufacturer_id = $1', manuID)
    .then(function (data) {
      res.status(200).json(data);
    })
    .catch(function (err) {
      return next(err);
    });
}

module.exports = {
  getAllBikes: getAllBikes,
  getSingleBike: getSingleBike,
  createBike: createBike,
  updateBike: updateBike,
  removeBike: removeBike,
  getAllManufacturers: getAllManufacturers,
  getManufacturerByName: getManufacturerByName,
  getModelsByBrandId: getModelsByBrandId
};
