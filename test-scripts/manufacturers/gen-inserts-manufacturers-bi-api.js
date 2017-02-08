
// sources:

// wikipedia:
// vintage bikes: velobase.com

// bike index: 
var request = require("request");
var TRIES = 30; // there are about 28 pages
var apiUrl = 'https://bikeindex.org/api/v3/manufacturers?per_page=50&page=';

var brands = require('./common-brands-array').brands;


var commonBikeBrands = brands.common;
var lessCommonBikeBrands = brands.lessCommon;

for(var i = 1; i <= TRIES; i++) {
  request('https://bikeindex.org/api/v3/manufacturers?page='+i+'&per_page=100', function (error, response, body) {
    if (!error && response.statusCode == 200) {
        var list = JSON.parse(body).manufacturers;

          var queries = [];
          // output the first "x"
          for(var j = 0; j < list.length; j++) {

            var market_size_str = 'null';

            var market_size = '';
            if(commonBikeBrands.indexOf(list[j].name) !== -1) {
              market_size = 'A';
            }
            if(lessCommonBikeBrands.indexOf(list[j].name) !== -1) {
              market_size = 'B';
            }

            if(market_size !== '') {
              market_size_str = "'" + market_size + "'";
            } 

            var query_string =   list[j].name.replace("'", "''") + "', '" + list[j].company_url.replace("'", "''") + "', " + market_size_str + ", " + list[j].id;            
            queries.push("INSERT INTO manufacturer (name, company_web_url, market_size, bike_index_id) VALUES ('" + query_string  + ");"); 
          }

          for (var i = 0; i < queries.length; i++) {
            console.log(queries[i]);
          }
     }
  })

}