var lis = $0.querySelectorAll('li');

var brands = [];

for (var i = 0; i < lis.length; i++) {

  var name = '';
  var notes = '';

  brands.push(lis[i].children[0].innerHTML.toLowerCase());

}

copy(JSON.stringify(brands));