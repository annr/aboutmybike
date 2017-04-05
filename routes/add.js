let express = require('express');
let router = express.Router();
const formidable = require('formidable');
const helper = require('../helpers/bike');
let page_heading = 'Let\'s make your bike page!';
let page_title = 'Add Your Bike';
let rows = 10;
let view = 'edit';

router.get(['/', '/:id'], function (req, res, next) {
  let maxRows = 24;
  let line = 60;
  let calculatedRows;

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
    // go to edit
    let id = req.user.bike_id;
    res.redirect(`/edit/${req.user.bike_id}`);
  }
});

module.exports = router;
