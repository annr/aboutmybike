

-- generated from https://en.wikipedia.org/wiki/List_of_Japanese_bicycle_brands_and_manufacturers

-- with this code:
brands = [];
//var insert_str = "INSERT INTO manufacturer (name, country) VALUES ('";
//inserts = "";
for( var i = 0; i < rows.length; i++) {

  var brand = {
     "country": "JP"
  }
  if (rows[i].children.length === 0) {
    brand.name = rows[i].innerHTML;
    //inserts += insert_str + rows[i].innerHTML + "', 'JP');\n\n"; 
  } else {
    //inserts += insert_str + rows[i].children[0].innerHTML + "', 'JP');\n\n"; 
    brand.name = rows[i].children[0].innerHTML;
  }

  brands.push(brand)
}

console.log(JSON.stringify(brands));
//copy(inserts);

-- two or three brands I needed to hand-correct. 

// to make this properly you need to hand-correct the output.