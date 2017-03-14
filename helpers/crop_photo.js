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
    width: parseInt(fields.cropWidth * fields.scale),
    height: parseInt(fields.cropHeight * fields.scale),
    xValue: parseInt(fields.xValue * fields.scale),
    yValue: parseInt(fields.yValue * fields.scale),
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
