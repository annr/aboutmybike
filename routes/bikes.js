let express = require('express');
let router = express.Router();
let bikeHelper = require('../helpers/bike');

router.get('/', (req, res, next) => {
  bikeHelper.getAllBikes(function (err, data) {
    if (err) {
      next(err);
    } else {
      let descriptionCropLength = 250;
      // add titles to bikes in an inefficient way:
      for (let i = 0; i < data.length; i++) {
        data[i].title = bikeHelper.getDetailedTitle(data[i]);
        if (data[i].description && data[i].description.length > (descriptionCropLength - 3)) {
          data[i].description = `${data[i].description.substring(0, 100)}...`;
        }
        data[i].photo_url = data[i].main_photo_path.replace('{*}', 'b');
      }
      res.render('bikes', {
        page_title: 'Bikes',
        results: data,
      });
    }
  });
});

module.exports = router;
