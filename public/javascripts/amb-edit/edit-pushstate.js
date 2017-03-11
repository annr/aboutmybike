/* 
  Bike photo validation and upload
*/
$(document).ready(function() {

  if (location.hash === '' || location.hash === '#_=_') {
    let defaultTab = '#intro';
    $('a[href="'+ defaultTab + '"]').tab('show');
    //history.pushState(null, null, defaultTab);
  }
  if (location.hash !== '') {
    $('a[href="' + location.hash + '"]').tab('show');
  }

  $('a[data-toggle="tab"]').on('click', function(e) {
    // you may need to remove the alert, say, if the user tries to undo
    // the desc of an existing bike and then go to the basics form
    $('.alert').remove();
    history.pushState(null, null, $(this).attr('href'));
  });

  window.addEventListener("popstate", function(e) {
    // this assumes that the URL has changed and this gets the right one.
    let activeTab = $('a[href="' + location.hash + '"]');
    if (activeTab.length) {
      activeTab.tab('show');
    } else {
      //$('.nav-tabs a:first').tab('show');
    }
  });

});
