const im = require('imagemagick');

/* 
 * crop photo
 *
 * takes a local path and overwrites it
*/

let run = function(localPath, fields, callback) {
  let options = {
    srcPath: localPath,
    dstPath: localPath,
    width: parseInt(fields.cropWidth),
    height: parseInt(fields.cropHeight),
    xValue: parseInt(fields.xValue),
    yValue: parseInt(fields.yValue),
  };  

  // crop and change graphics format if nec.
  im.crop(options, function(err){
    if (err) throw new Error(err);
    callback({ message: 'cropped file overwrites ' + localPath});
  });
};

module.exports = {
  run,
}
