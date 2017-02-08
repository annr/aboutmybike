
/*
Creating inserts from ULs

var insert_str = "INSERT INTO manufacturer (name, country) VALUES ('";
inserts = "";
for( var i = 0; i < rows.length; i++) {
  if (rows[i].children.length === 0) {

    inserts += insert_str + rows[i].innerHTML + "', 'JP');\n\n"; 
  } else {
    inserts += insert_str + rows[i][0].innerHTML + "', 'JP');\n\n"; 
  }
}
copy(inserts);

*/

var manufacturers = require('./manufacturers-array-bi').manufacturers;

var brands = require('./common-brands.array')

var commonBikeBrands = brands.common;

var lessCommonBikeBrands = brands.lessCommon;

//var queries = ["INSERT INTO manufacturer (name) VALUES ('New or Unknown Brand');"];
var queries = [];

for (var i = 0; i < manufacturers.length; i++) {

  // get bike_index_id and build insert string???? 

  // ABANDONED THIS SCRIPT!!!! YOU NEED TO COLLECT THE VALUES FROM THE API BECAUSE YOU CAN'T GET ID FROM NAME

  var query_string =   manufacturers[i].name.replace("'", "''") + "', '" + manufacturers[i].webUrl.replace("'", "''") + "'";
  if(commonBikeBrands.indexOf(manufacturers[i].name) !== -1) {
    query_string += ", market_size = 'A'";
  }
  if(lessCommonBikeBrands.indexOf(manufacturers[i].name) !== -1) {
    query_string += ", market_size = 'B'";
  }
  queries.push("INSERT INTO manufacturer (name, company_web_url, bike_index_id, market_size) VALUES ('" + query_string  + "');");
}

for (var i = 0; i < queries.length; i++) {
  console.log(queries[i]);
}

// probably a more efficient way to do this:
// console.log('var manufacturers = [');
// for (var i = 0; i < manufacturersArray.length; i++) {
//   console.log('  ' + JSON.stringify(manufacturersArray[i]) + ',');
// }
// console.log(']');