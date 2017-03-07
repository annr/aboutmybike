let express = require('express');
let router = express.Router();
const formidable = require('formidable');
const queries = require('../db/queries');
const helper = require('../helpers/bike');
let page_heading = 'Let\'s make your bike page!';
let page_title = 'Add Your Bike';
let rows = 10;
let view = 'edit';

router.get(['/', '/:id'], function (req, res, next) {
  let maxRows = 24;
  let line = 60;
  let calculatedRows;

  // if logged in user has added created a bike record by uploading a photo, make sure that bike record is used.
  // we need to preserve add/edit versions.
  if (!req.user.bike_id) {
    res.render(view, {
      page_title,
      page_heading,
      reasons: helper.getFormReasons(),
      types: helper.getFormTypes(),
      eras: helper.getFormEras(),
      rows,
      is_new: true,
    });
  } else {
    let id = req.user.bike_id;
    helper.getBike(id, function (err, data) {
      if (err) {
        next(err);
      } else {
        // Try to guess how many textarea rows will be necessary to edit the text.
        // This is hard, because responsive, but if the text is really long, you can give more editor.
        if (data.description && data.description.length) {
          calculatedRows = Math.round(data.description.length / line);
          if (calculatedRows < maxRows && calculatedRows > rows) {
            rows = calculatedRows;
          }
        }
        res.render(view, {
          page_title,
          page_heading,
          bike: data,
          reasons: helper.getFormReasons(data.reason_ids),
          types: helper.getFormTypes(data.type_id),
          eras: helper.getFormEras(data.era),
          rows,
          is_new: true,
        });
      }
    });
  }
});

module.exports = router;
