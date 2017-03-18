const im = require('imagemagick');
const util= require('util');

/* 
 * prep photo
 *
 * takes a local path and overwrites it. 
 *   It normalizes the format and crops slightly if necessary.
 *   It may be doing a bit too much.
*/

let run = function(localPath, fields, callback) {
  // Three things:

  // - convert to JPEG (in any case)
  // - crop slightly
  // - crop with select area values

  let options = {
    srcPath: localPath,
    dstPath: localPath, // !!!!
    gravity: 'NorthWest',
    //quality: 1, // TO-DO: you need to get quality of the uploaded file and make it the same. this blows up file size for now reason.
    // I am choosing not to set quality right now. That means that the "full" size value is going to be reduced to .8 quality
    // also, if a user uploads a jpeg that has a lower quality the file size is going to blow up for no reason.
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
  // console.log('ratio: ' + ratio);
  // console.log('scale ' + fields.scale);
  // console.log('cropWidth ' + fields.scale);
  // console.log('cropHeight ' + fields.scale);
  // use the existence of these values to determine if the cropper is used. THIS SUCKS.
  if(fields.scale !== '' && fields.cropWidth !== '' && fields.cropHeight !== '' && fields.xValue !== '' && fields.yValue !== '') {
    console.log('cropper was used');
    options.width = parseInt(fields.cropWidth * fields.scale);
    options.height = parseInt(fields.cropHeight * fields.scale);
    options.xValue = parseInt(fields.xValue * fields.scale);
    options.yValue = parseInt(fields.yValue * fields.scale);
  } else {
    //console.log('cropper NOT used')
    // here we automatically normalize to 4:3 if necesssary. modal select area cropping is applied before this step
    // and so we can safely crop from the gravity "Center" (the default. vs NorthWest).
    if (ratio > 0.75) {
      console.log('oblong');
      options.width = width;
      options.height = Math.floor(width*0.75);
    } else if (ratio < 0.75) {
      console.log('wide');
      options.width = Math.round(height*1.3333333333);
      options.height = height;
    } else {
      options.width = width;
      options.height = height;
    }
  }

  console.log(util.inspect(options));

  // crop and change graphics format if nec.
  im.crop(options, function(err){
    if (err) throw new Error(err);
    callback({ message: 'prepped file overwrites ' + localPath});
  });
};

module.exports = {
  run,
}
