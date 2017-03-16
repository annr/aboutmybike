  /*
    Requires awesomplete.
  */

  $(document).ready(function() {

    /* STEP 2 functions */ 
    function searchAndUpdateBrand(str) {
      let searchBrandAjax = new XMLHttpRequest();
      // use the value they entered to try to figure out the brand.
      searchBrandAjax.open("GET", "/api/brand_by_name/" + str, true);
      searchBrandAjax.onload = function() {
        let result = JSON.parse(searchBrandAjax.responseText);
        if (result.status === 'success') {
          $('#brand_id').val(result.data.id);
          // for some brands you may want to transform the #brand field text
          // but I can't think how, because brand vs manufacturer is usu. the shorter string:
          // Trek vs Trek Bicycle Foundation
        } else {
          // user may have previously selected another brand
          $('#brand_id').val('');
        }
      };
      searchBrandAjax.send();
    }

    if($('#brand').length !== 0) {
      let ajax = new XMLHttpRequest();
      ajax.open("GET", "/api/brands", true);
      ajax.onload = function() {
        let list = JSON.parse(ajax.responseText);
        new Awesomplete(
          document.querySelector("#brand"),
          { 
            list: list,
            filter: Awesomplete.FILTER_STARTSWITH,
            sort: function(item) { // need to override sort. false doesn't work
              return item;
            }
          });
      };
      ajax.send();
    
      $("#brand").change(function () {
        searchAndUpdateBrand(this.value);
      });

    }

    addEventListener("awesomplete-select", function(e) {
      let hiddenFieldToUpdate = '#' + e.target.name + '_id';
      $(hiddenFieldToUpdate).val(e.text.value);
    }, false);

});