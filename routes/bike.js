let express = require('express');
let router = express.Router();
let helper = require('../helpers/bike');

/* GET bike listing */
router.get('/:id', function (req, res, next) {
  let id = parseInt(req.params.id);
  helper.getBike(id, function (err, data) {
    if (err) {
      next(err);
    } else {
      let bike = helper.transformForDisplay(data);
      res.render('bike', {
        page_title: 'Bike Detail',
        bike,
        is_users_bike: req.user && (req.user.bike_id === id),
      });
    }
  });
});

module.exports = router;
