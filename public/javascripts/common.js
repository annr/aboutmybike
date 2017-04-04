/* 
  Bike photo validation and upload
*/
$(document).ready(function() {
  // some form validation

  $('#profileEdit').on('submit', function() {
    event.preventDefault();
    var urlField = $(this).find('input[name=website]');
    var urlRegex = /^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/;
    if (urlField.val() !== '' && !urlRegex.test(urlField.val())) {
      $('.error-message').html('Please provide a valid URL, starting with http.');
    } else {
      this.submit();
    }
  });

  $('form').on('submit', function() {
    event.preventDefault();
    var requiredFields = $("input").prop('required', true);
    // make sure any required fields are entered.
    console.log('there are ' + requiredFields.length + ' required fields.'); 
    // everything is fine. submit.
  });

});
