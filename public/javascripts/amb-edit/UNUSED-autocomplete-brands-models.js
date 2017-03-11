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
        getBrandModels(result.data.id);
      };
      searchBrandAjax.send();
    }

    function getBrandModels(brand_id) {
      let getModelsAjax = new XMLHttpRequest();
      // use the value they entered to try to figure out the brand.
      getModelsAjax.open("GET", "/api/models_by_brand/" + brand_id, true);
      getModelsAjax.onload = function() {
        let list = JSON.parse(getModelsAjax.responseText);
        if(list.length > 0) {
          new Awesomplete(
            document.querySelector("#model"),
            { 
              list: list,
              filter: Awesomplete.FILTER_STARTSWITH
            });
        }
      };
      getModelsAjax.send();
    }

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

    addEventListener("awesomplete-select", function(e) {
      if(e.target.name === 'brand') {
        getBrandModels(e.text.value);
      }
      let hiddenFieldToUpdate = '#' + e.target.name + '_id';
      $(hiddenFieldToUpdate).val(e.text.value);
    }, false);

});