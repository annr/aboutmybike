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
    $(elem).append('<div class="alert alert-' + (type || 'warning') + '" role="alert">' + msg + '</div>');
  }
  
  $("#uploadForm").submit(function( event ) {

    event.preventDefault();
    $('.alert').remove();

    var form = this;
    var uploadAction = $(form).attr('action');
    var formData = new FormData(form);

    $('.upload-target-wrapper .progress').css('visibility', 'visible');
    appendAlert('Validating and uploading photo...', null, 'info');

    if($('#selectAreaModal').is(':visible')) {
      $('#selectAreaModal').modal('hide');
    }

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
        $('.upload-target-wrapper .progress').css('visibility', 'hidden');
        // it's a question whether you should design as "success"
        if(data.error) {
          appendAlert(data.error, null, 'warning');
        } else {
          appendAlert('Successfully stored your bike photo.', null, 'success');
          if($('input[name=bike_id]').val() === '') {
            $('input[name=bike_id]').val(data.id);
          }
          // this doesn't work. we get a 403 as if the photo is too 'fresh'.
          //$('#upload-target').attr('src', data.photoPath);
          $('#hacked_main_path').val(data.photoPath);
        }
      },
      error: function(err) {
        // be transparent and output error.
        // but how to you get specific error and not whole page?
        appendAlert('Error attaching bike photo. Please try again later.', null, 'danger');
      }
    });
  });

  function filePreview(file, callback) {

    var preview = $('.upload-target-wrapper');
    var target = $('#upload-target');

    $('input[name=cropHeight]').val(preview.height());
    $('input[name=cropWidth]').val(preview.width());

    if (file) {
      $('input[name=original_filename]').val(file.name)
      let reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        var image = new Image();
        image.src = e.target.result;
        image.onload = function() {
          $('input[name=actualHeight]').val(this.height);
          $('input[name=actualWidth]').val(this.width);
          // access image size here 
          var ratio = this.height/this.width;
          var normalizedRatio = 0.75;
          var diff = 0.05;
          var cropWidth;
          var cropHeight;
          var adjustedHeight;
          var adjustedWidth;
          var scale;
          var shiftPixels;

          if(ratio < (normalizedRatio - diff) || ratio > (normalizedRatio + diff)) {
            preview.width(Math.floor(preview.width()));
            preview.height(Math.floor(preview.width() * 0.75));
            preview.css('overflow', 'hidden');
            target.css('position', 'absolute');
            target.css('left', '0'); // we need to manually set these because the
            target.css('top', '0');  // value can bleed over to the next attachment.
            scale = this.width/preview.width();
            if(ratio < 0.70) {
              target.css('height', preview.height());
              cropWidth = this.height * (1/normalizedRatio);
              adjustedWidth = Math.floor(preview.height() * 1/ratio);
              target.css('width', adjustedWidth);
              shiftPixels = Math.floor(this.width - cropWidth)/2;
              $('input[name=xValue]').val(shiftPixels);
              $('input[name=cropWidth]').val(Math.floor(cropWidth));
              $('input[name=cropHeight]').val(Math.floor(this.height));
              target.css('left', '-' + Math.floor(shiftPixels * 1/scale) + 'px');
            } else {
              target.css('width', preview.width());
              $('input[name=scale]').val(this.width/preview.width());
              cropHeight = this.width * normalizedRatio;
              adjustedHeight = Math.floor(preview.width() * ratio);
              target.css('height', adjustedHeight);
              shiftPixels = Math.floor(this.height - cropHeight)/2;
              $('input[name=yValue]').val(shiftPixels);
              $('input[name=cropHeight]').val(Math.floor(cropHeight));
              $('input[name=cropWidth]').val(Math.floor(this.width));
              target.css('top', '-' + Math.floor(shiftPixels * 1/scale) + 'px');
            }
          }
          $('#upload-target').attr('src', e.target.result);
          $('#upload-target').removeClass('upload-placeholder');
          $("#uploadForm").submit();
        }
      }
    } 
  }

  $("#bike_photo").change(function () {
    // if the photo is oblong, we load it in a modal for cropping
    if(simpleValidation(this)) {
      filePreview(this.files[0]);
    }
  });

  // TO-DO: have all of this validation come from the backend.
  function simpleValidation(input) {
    $('.alert').remove();
    let maxSize = 18000000; // from config/index. 18MB?
    let minSize = 50000;
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

  // this is a hack!!!
  // if there is a hacked_main_path, there is a new photo that was not able to be shown previously
  // for no known reason.
  if ($('#hacked_main_path').val() !== '') {
    $('#upload-target').attr('src', $('#hacked_main_path').val());
  }

});