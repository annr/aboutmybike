const im = require('./imagemagick');
const util= require('util');

/* 
 * prep photo
 *
 * takes a local path and overwrites it. 
 *   It normalizes the format and crops slightly if necessary.
 *   It may be doing a bit too much.
*/

let run = function(localPath, fields, callback) {
  let newPath = localPath + '-tmp';
  // Three things:
  // - convert to JPEG (in any case)
  // - crop slightly
  // - crop with select area values

  let options = {
    progressive: true,
    srcPath: localPath,
    dstPath: newPath,
    //quality: 1, // because we are going to use this cropped photo to make the other versions, we cannot reduce quality!
  };

  //if (fields.cropWidth === '' || fields.cropHeight === '' || fields.xValue !== '' || fields.yValue !== '') {
  if (fields.actualHeight === '' || fields.actualWidth === '') {
    throw new Error(`form field values actualHeight and actualWidth are required for prep, currently (could be improved)`);
  }
  // here we choose to get the actualWidth and actualHeight from the form.
  // may be a bad idea. We can always validate this easily.
  let width = parseInt(fields.actualWidth);
  let height = parseInt(fields.actualHeight);
  let ratio = Math.round((height/width) * 100)/100;
  if(fields.scale !== '' && fields.cropWidth !== '' && fields.cropHeight !== '' && fields.xValue !== '' && fields.yValue !== '') {
    options.width = parseInt(fields.cropWidth * fields.scale);
    options.height = parseInt(fields.cropHeight * fields.scale);
    options.xValue = parseInt(fields.xValue * fields.scale);
    options.yValue = parseInt(fields.yValue * fields.scale);
    options.gravity = 'NorthWest';
  } else {
    options.width = width;
    options.height = height;
    // here we automatically normalize to 4:3 if necesssary. modal select area cropping is applied before this step
    // and so we can safely crop from the gravity "Center" (the default. vs NorthWest).
    if (ratio > 0.75) {
      options.height = Math.floor(width*0.75);
    } else if (ratio < 0.75) {
      options.width = Math.round(height*1.3333333333);
    }
  }

  // crop and change graphics format if nec.
  im.crop(options, function(err){
    if (err) throw new Error(err);
    callback(newPath);
  });
};

module.exports = {
  run,
}
