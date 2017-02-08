var _ = require('../lodash');
var models = require('./batch-models').brand_models;
var queries = [];


for(var i = 0; i < models.length; i++) {
  //console.log(models[i].extracted_models);

  for(var j = 0; j < models[i].extracted_models.length; j++) {
    // capitalize first char
    queries.push("INSERT INTO model (manufacturer_id, name) VALUES (" + models[i].id + ", '" + models[i].extracted_models[j].charAt(0).toUpperCase() + models[i].extracted_models[j].substring(1) + "');"); 
  }

}

for (var i = 0; i < queries.length; i++) {
  console.log(queries[i]);
}


