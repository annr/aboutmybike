
let express = require('express');
let router = express.Router();
const formidable = require('formidable');
const queries = require('../db/queries');
const helper = require('../helpers/bike');
let page_heading =  'Let\'s make your bike page!';
let page_title = 'Add Your Bike';
let rows = 10;
let view = 'edit';
let util = require('util');

router.get(['/', '/:id'], function(req, res, next) {
  var maxRows = 24;
  var line = 60;
  var calculatedRows;

  if (!req.params.id) {
    res.render(view, {
      page_title: page_title,
      page_heading: page_heading,
      reasons: helper.getFormReasons(),
      types: helper.getFormTypes(),
      eras: helper.getFormEras(),
      rows: rows
    });
  } else {
    let id = req.params.id;
    page_title = 'Edit Bike';
    page_heading = page_title;

    queries.getBike(id, function(err, data) {
      if(err) {
        next(err);
      } else {
        // Try to guess how many textarea rows will be necessary to edit the text.
        // This is hard, because responsive, but if the text is really long, you can give more editor.
        if(data.description && data.description.length) {
          calculatedRows = Math.round(data.description.length/line);
          if(calculatedRows < maxRows && calculatedRows > rows) {
            rows = calculatedRows;
          }
        }
        res.render(view, {
          page_title: page_title,
          page_heading: page_heading,
          bike: data,
          reasons: helper.getFormReasons(data.reason_ids),
          types: helper.getFormTypes(data.type_id),
          eras: helper.getFormEras(data.era),
          rows: rows
        });
      }
    });
  }

});

/* Populate basic details */
router.post('/', function(req, res, next) {

  if(req.body.step === "1") {
    queries.updateBikeIntro(req.body, function(err) {
      if(err) {
        next(err);
      } else {
        res.json({success : "Updated bike intro", status : 200});
      }
    });

  } else if (req.body.step === "2") {
    queries.updateBikeBasics(req.body, function(err) {
      if(err) {
        next(err);
      } else {
        //res.json({success : "Updated bike basics", status : 200});
        res.redirect('/bike/' + req.body.bike_id);
      }
    });
  } else {
    throw err;
  }

});

module.exports = router;
