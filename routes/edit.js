
let express = require('express');
let router = express.Router();
const formidable = require('formidable');
const queries = require('../db/queries');
const helper = require('../helpers/bike');
let page_heading =  'Let\'s make your bike page!';
let page_title = 'Add Your Bike';
var rows = 10;

/* GET upload form. */
router.get('/', function(req, res, next) {
  res.render('edit', {
    app_name: res.locals.app.name,
    page_title: page_title,
    page_heading: page_heading,
    reasons: helper.getFormReasons(),
    types: helper.getFormTypes(),
    rows: rows
  });
});

router.get('/:id', function(req, res, next) {

  let id = req.params.id;
  let page_title = 'Edit Bike Details';
  let page_heading = page_title;
  var maxRows = 24;
  var line = 60;
  var calculatedRows;

  queries.getBike(id, function(err, data) {
    if(err) {
      next(err);
    } else {

      data.photo_url = res.locals.app.s3Url + data.main_photo_path;

      // Try to guess how many textarea rows will be necessary to edit the text. 
      // This is hard, because responsive, but if the text is really long, you can give more editor.
      if(data.description.length) {
        calculatedRows = Math.round(data.description.length/line);
        if(calculatedRows < maxRows && calculatedRows > rows) {
          rows = calculatedRows;
        }
      }

      res.render('edit', {
        app_name: res.locals.app.name,
        page_title: page_title,
        page_heading: page_heading,
        bike: data,
        reasons: helper.getFormReasons(data.reason_ids),
        types: helper.getFormTypes(data.type_id),
        rows: rows
      });
    }
  });

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
