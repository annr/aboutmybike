/* 
  Bike edit form handler. Only the first step -- basics -- is submitted with ajax. step 2 is a server post for now.
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

  $("#editIntro").submit(function(event) {
    event.preventDefault();
    let desc = $('#description');

    let step2 = $('a[href="#basics"]');

    if($(this).find('input[name=bike_id]').val() === '') {
      appendAlert('Please attach a bike photo before submitting this form.');
      return;
    }

    if(desc.val() === '') {
      //let originalBorderColor = desc.attr('border-color');
      appendAlert('Please enter some thoughts about your bike.');
      desc.focus();
      return;
    }

    let reasons = [];
    $("input[name='reason_ids']:checkbox:checked").each(function(){
      reasons.push($(this).val());
    })
    $("#reasons").val(reasons.join(','));

    $.ajax({
      url: $(this).attr('action'),
      type: 'POST',
      data: $(this).serialize(),
      success: function(data) {
        if($('#is_new').val() === '1') {
          $('.alert').remove();
          // we hide the basics tab until they finish intro.
          $('#basics_nav_item').show();
          let basicsTab = '#basics';
          $('a[href="'+ basicsTab + '"]').tab('show');
          history.pushState(null, null, basicsTab);
          //step2.tab('show');
        } else {
          location.replace('/bike/' + $('#intro input[name=bike_id]').val());
        }
      },
      error: function(err) {
        appendAlert(JSON.stringify(err));
      }
    });
  });


});
