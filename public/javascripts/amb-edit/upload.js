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
        // it's question if you should design this under "success"
        if(data.error) {
          appendAlert(data.error, null, 'warning');
        } else {
          appendAlert('Successfully stored your bike photo.', null, 'success');
          if($('input[name=bike_id]').val() === '') {
            $('input[name=bike_id]').val(data.id);
          }
          // make sure preview uses cache-busted new file
          //$('#upload-target').attr('src', data.photoPath+'?bust='+(new Date()).getTime());
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
    if (file) {
      $('input[name=original_filename]').val(file.name)
      let reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        var image = new Image();
        image.src = e.target.result;
        // load the image to get height and width. 
        // if oblong, open modal.
        image.onload = function() {
          // this will make it jump a bit:
          $('#upload-target').attr('src', e.target.result);

          $('input[name=actualHeight]').val(this.height);
          $('input[name=actualWidth]').val(this.width);
          // if ratio is close to 4:3, just crop.
          // technically is ratio between 3:2 (0.666667) and 4:5 (0.8)
          if(this.height/this.width > 0.66 && this.height/this.width < 0.801) {
            $('#upload-target').removeClass('upload-placeholder');
            $("#uploadForm").submit();
          } else {
            // we'll open up the modal dialog for cropping.
            // first unset the values:
            $('#cropTarget').attr('src', e.target.result);
            $('#selectAreaModal').modal('show');
          }
        };
      }
    } 
  }

  $('#selectAreaModal').on('shown.bs.modal', function (e) {
    $("#uploadForm").selekter({
      img: $('#cropTarget'),
      actualWidth: $('input[name=actualWidth]').val(),
      actualHeight: $('input[name=actualHeight]').val()
    });
  })

  $('#selectAreaModal').on('hidden.bs.modal', function (e) {
    // unset crop modal values. if the user chooses another photo to select, the old will still be attached.
    $('#uploadForm').selekter('destroy');
    //$('#cropTarget').attr('src', '');
    // now we need to load the inlined preview of the file with the crop.

    // that is, based on their selection we need to adjust the CSS of the area.

    // but for now just show full image. 

  });

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

});