
let express = require('express');
let router = express.Router();
const formidable = require('formidable');
const helper = require('../helpers/bike');
let page_title = 'Edit Bike';
let page_heading = page_title;
let rows = 10;
let view = 'edit';

router.get(['/', '/:id'], function (req, res, next) {
  let maxRows = 24;
  let line = 60;
  let calculatedRows;
  let id = req.params.id;

  helper.getBike(id, function (err, data) {

    // must be user's bike for them to edit
    if (data.user_id != req.user.id) {
      console.log('redirecting...');
      res.redirect(`/bike/${data.id}`);
    }

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
      data.photo_url = data.main_photo_path.replace('{*}', 'b');

      res.render(view, {
        page_title,
        page_heading,
        bike: data,
        reasons: helper.getFormReasons(data.reason_ids),
        types: helper.getFormTypes(data.type_id),
        eras: helper.getFormEras(data.era),
        rows,
        is_new: false,
        bust: new Date().getTime()
      });
    }
  });
});

/* Populate basic details */
router.post('/', function (req, res, next) {
  if (req.body.step === '1') {
    helper.updateIntro(req.body, function (err) {
      if (err) {
        next(err);
      } else {
        res.json({ success: 'Updated bike intro', status: 200 });
      }
    });
  } else if (req.body.step === '2') {
    helper.updateBasics(req.body, function (err) {
      if (err) {
        next(err);
      } else {
        // res.json({success : 'Updated bike basics', status : 200});
        res.redirect(`/bike/${req.body.bike_id}`);
      }
    });
  } else {
    throw err;
  }
});

module.exports = router;
