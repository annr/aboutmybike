function getManufacturer(manuId, callback) {
  db.manufacturer.select(manuId)
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed to get manufacturer record: (${err})`));
    });
}

function getManufacturers(callback) {
  db.manufacturer.all()
    .then(function (data) {
      callback(null, data);
    })
    .catch(function (err) {
      callback(new Error(`Failed to get manus`));
    });
}

module.exports = {
  getManufacturer,
  getManufacturers,
}