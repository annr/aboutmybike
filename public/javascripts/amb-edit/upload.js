/* 
  Bike photo validation and upload
*/
$(document).ready(function() {

  function appendAlert(msg, elem, type) {
    // remove any existing alert warnings
    $('.alert').remove();
    if(!elem) {
      elem = $('.alert-area')[0];
    }
    elem.append('<div class="alert alert-' + (type || 'warning') + '" role="alert">' + msg + '</div>');
  }

  
  $("#cropForm").submit(function( event ) {
    event.preventDefault();
    //crop and load saved photo

    $.ajax({
      url: '/crop',
      type: 'POST',
      // Form data
      data: new FormData(this),
      cache: false,
      contentType: false,
      processData: false,
      xhr: function() {
        let myXhr = $.ajaxSettings.xhr();
        return myXhr;
      },
      success: function(data) {
        console.log('seems to have cropped. does it return data?');
        // inline the image and automatically save it.
        $('#upload-target').attr('src', data);
        //$("#uploadForm").submit();
      },
      error: function(err) {
        throw new Error(err)
      }
    });

  });

  $("#uploadForm").submit(function( event ) {
    event.preventDefault();
    $('.alert').remove();

    appendAlert('Uploading...', null, 'info');
    //disable submit until photo is updated.
    // is this nec?? If they've attached a new image it will get updated even if the user
    // navigates away, right?

    //$("#submitIntro").prop("disabled",true);
    var uploadAction = $(this).attr('action');
    var formData = new FormData(this);

    $.ajax({
      url: '/validate_photo',
      type: 'POST',
      // Form data
      data: new FormData(this),
      cache: false,
      contentType: false,
      processData: false,
      xhr: function() {
        let myXhr = $.ajaxSettings.xhr();
        return myXhr;
      },
      success: function(data) {
        if (data.message === 'bicycle') {
          appendAlert('Validated bicycle. (Confidence: ' + Math.floor(data.confidence) + ')', null, 'success');

          $.ajax({
            url: uploadAction,
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            xhr: function() {
              let myXhr = $.ajaxSettings.xhr();
              return myXhr;
            },
            success: function(data) {
              appendAlert('Successfully stored your bike photo.');
              if($('input[name=bike_id]').val() === '') {
                $('input[name=bike_id]').val(data.id);
              }
            },
            error: function(err) {
              // be transparent and output error.
              // but how to you get specific error and not whole page?
              appendAlert('Error attaching bike photo. Please try again later.', null, 'danger');
            }
          });

        } else {
          appendAlert(data.message, null, 'warning');
        }
      },
      error: function(err) {
        throw new Error(err)
      }
    });
  });

  function filePreview(input, callback) {
    if (input.files && input.files[0]) {  
      let reader = new FileReader();
      reader.readAsDataURL(input.files[0]);
      reader.onload = function (e) {
        var image = new Image();
        image.src = e.target.result;
        // load the image to get height and width. 
        // if oblong, open modal.
        image.onload = function() {
          // if ratio is close to 4:3, just crop.
          // technically is ratio between 3:2 (0.666667) and 4:5 (0.8)
          console.log('ratio: ' + this.height/this.width);
          if(this.height/this.width > 0.66 && this.height/this.width < 0.801) {
            $('#upload-target').attr('src', e.target.result);
            $('#upload-target').removeClass('upload-placeholder');
            $("#uploadForm").submit();
          } else {
            $('#crop-target').attr('src', e.target.result);
            console.log(this.width + ': ' +  this.height);
            setupImgAreaSelect($('#crop-target'), prepareCropPoints(this.width, this.height));
            $('#selectAreaModal').modal('show');
          }
        };
      }
    } 
  }

  $("#bike_photo").change(function () {
    // if the photo is oblong, we load it in a modal for cropping
    if(simpleValidation(this)) {
      filePreview(this);
    }
  });

  function simpleValidation(input) {
    $('.alert').remove();
    let maxSize = 5000000; // from config/index
    let minSize = 100000;
    // lame
    let acceptedFileTypes = ['image/jpeg', 'image/png'];

    if (input.files && input.files[0]) {  
      if(input.files[0].type !== 'image/jpeg' && input.files[0].type !== 'image/png') {
        appendAlert('Bike photo must be an image.');
        return false;
      }
      if(input.files[0].size <= minSize) {
        appendAlert('Image size must be at least ' + minSize/1000 + 'K (Yours is ' + Math.round(input.files[0].size/1000) + 'K). Please attach a larger photo of your bike.');
        return false;
      }
      if(input.files[0].size > maxSize) {
        appendAlert('Image size must be at less than <nowrap>' + maxSize/1000000 + ' Megabytes</nowrap> (Yours is ' + (input.files[0].size/1000000).toFixed(2) + 'M). Please attach a smaller photo of your bike.');
        return false;
      }
      return true;
    } 
  }

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
