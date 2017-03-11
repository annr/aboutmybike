const express = require('express');
const router = express.Router();
const im = require('imagemagick');
const util = require('util');

router.post('/', function (req, res, next) {

  console.log(util.inspect(req.body));
  let photo = req.body.crop_photo;

  let tmpDirectory = photo.substr(0, photo.lastIndexOf('/')+1);
  let cropFilename = 'crop-' + photo.substr(photo.lastIndexOf('/')+1);

  // since this doesn't use the user_id it risks being a duplicate.
  var dstPath = tmpDirectory + cropFilename;
  console.log('crop file name: ' + dstFile);

  /*

  if(!req.body.cropWidth || req.body.cropHeight || req.body.yValue || req.body.xValue) {
    res.json({ status: 500, message: 'missing required values for crop'});
  }

  let options = {
    srcPath: photo,
    dstPath: dstFile,
    width: req.body.cropWidth,
    height: req.body.cropHeight,
    xValue: req.body.xValue,
    yValue: req.body.yValue,
    format: 'jpg',
  };  

  // crop and change graphics format if nec.
  im.crop(options, function(err, stdout, stderr){
    if(err) throw new Error(err);
    console.log('cropped??');
    res.json({ data: { file: dstFile }, status: 200});
  });
  */

  res.json({ data: { file: dstFile }, status: 200});

});


module.exports = router;
