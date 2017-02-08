var db = require('./db');

// add query functions
function getAllBikes(callback) {
  db.any('select * from bike')
    .then(function (data) {
      callback(data);
    })
    .catch(function (err) {
      console.log(err);
    });
}

function getSingleBike(bikeID, callback) {
  db.one('select * from bike where id = $1', bikeID)
    .then(function (data) {
      callback(data);
    })
    .catch(function (err) {
      console.log(err);
    });
}

function createBike(fields, photoPath, callback) {
  db.one('insert into bike(user_id, main_photo_path) ' +
      'values($1, $2) returning id', [parseInt(fields.user_id), photoPath])
    .then(function (data) {
      callback(data);
    })
    .catch(function (err) {
      return next(err);
    });
}

/*
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
      res.status(200)
        .json({
          status: 'success',
          message: `Removed ${result.rowCount} bike`
        });
    })
    .catch(function (err) {
      return next(err);
    });
}
*/

module.exports = {
  getAllBikes: getAllBikes,
  getSingleBike: getSingleBike,
  createBike: createBike//,
  //updateBike: updateBike,
  //removeBike: removeBike
};
