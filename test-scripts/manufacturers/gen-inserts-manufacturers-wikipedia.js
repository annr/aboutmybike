/*

NOTE: we need to make sure we don't cause duplicates by adding this list.
// we check it against the bi api array.

*/

var _ = require('../lodash');
var wikipediaBrands = require('./manufacturers-wikipedia-objects').manufacturers;

var biBrands = require('./manufacturers-bi-objects').manufacturers;

var biNames = _.map(biBrands, function(elem) {
  return elem.name;
});

var queries = [];

for(var i = 0; i < wikipediaBrands.length; i++) {

  var manu = wikipediaBrands[i];

  // assume that the very first word is all you need to check to see if the manufacturer has already been added.
  var hasMatch = _.some(biNames,function(elem) {
    return elem.indexOf(manu.name.split(' ')[0]) === 0;
  });

  if (!manu.defunct) {
    manu.defunct = false;
  }

  var wikipedia_url_str = 'null';
  if (manu.wikipedia_url !== undefined) {
    wikipedia_url_str = "'" + manu.wikipedia_url + "'";
  }

  if(hasMatch) {
    //update it with the wikipedia value. (LATER)
    //queries.push("UPDATE manufacturer set wikipedia_url = '" + manu.wikipedia_url + "'  + where id = " + <id>;
    // language JP
   // console.log('DUPE::: ' + manu.name);
  } else {
    var query_string = manu.name.replace("'", "''") + "', " + wikipedia_url_str + ", " + manu.defunct;            
    queries.push("INSERT INTO manufacturer (name, wikipedia_url, discontinued) VALUES ('" + query_string  + ");"); 
  }

}

for (var i = 0; i < queries.length; i++) {
  console.log(queries[i]);
}


