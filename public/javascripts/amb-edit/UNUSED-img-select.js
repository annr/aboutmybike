/* 
  Bike edit form handler. Only the first step -- basics -- is submitted with ajax. step 2 is a server post for now.
*/
$(document).ready(function() {

  function setupImgAreaSelect(img, points) {
    $(img).imgAreaSelect({
      handles: true,
      aspectRatio: "4:3",
      onSelectEnd: onImgAreaSelect,
      onInit: onImgAreaSelect,
      x1: points.x1,
      y1: points.x2,
      x2: points.y1,
      y2: points.y2,
    });
  }

  function updateImgAreaSelectFields(selection) {
    // set these values in a form
    $('#xValue').val(selection.x1);
    $('#yValue').val(selection.y1);
    // must figure out height and width and send those values
    $('#cropWidth').val(selection.x2 = selection.x1);
    $('#cropHeight').val(selection.y2 = selection.y1);
    console.log($('#cropHeight').val());
  }

  function onImgAreaSelect(img, selection) {
    updateImgAreaSelectFields(selection);
  }

  function prepareCropPoints(width, height) {
    var x1, y1, x2, y2;

    if (height/width > 0.75) {
      x1 = 0;
      x2 = width;
      var cropHeight = width*0.75;
      var offset = (height - cropHeight)/2;
      y1 = offset;
      y2 = offset + cropHeight; 
    } else {
      y1 = 0;
      y2 = height;
      var cropWidth = height*1.33333333;
      var offset = (width - cropWidth)/2;
      x1 = offset;
      x2 = offset + cropWidth;
    }

    console.log(' x1: ' + Math.round(x1) + ' y1: ' + Math.round(y1) + ' x2: ' + Math.round(x2) + ' y2: ' + Math.round(y2));

    return {
      x1: Math.round(x1),
      y1: Math.round(y1),
      x2: Math.round(x2),
      y2: Math.round(y2),
    }

  }
});