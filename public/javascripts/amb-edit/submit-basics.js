/* 
  Bike edit form handler. Only the first step -- basics -- is submitted with ajax. step 2 is a server post for now.
*/
$(document).ready(function() {

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
          step2.tab('show');
        } else {
          // also can add "view bike"
          //appendAlert('Intro saved. <a data-toggle="tab" href="/edit/' + $('#intro input[name=bike_id]').val() +'#basics">Edit basics</a>');
          //appendAlert('Intro values saved.');
          location.replace('/bike/' + $('#intro input[name=bike_id]').val());
        }
      },
      error: function(err) {
        appendAlert(JSON.stringify(err));
      }
    });
  });


});
