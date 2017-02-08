var lis = $0.querySelectorAll('li');

var brands = [];
for (var i = 31; i < lis.length; i++) { 
  var contents = lis[i].innerHTML;
  var defunct = false;
  if(contents.indexOf('(defunct)') !== -1) {
     
    contents = contents.replace('(defunct)', '');
    defunct = true;
  } else {
    console.log('not setting def');
  }
  var link = lis[i].querySelector('a');
  var wikipedia_url = "";
  if (link && link.attributes) {
    wikipedia_url = 'https://en.wikipedia.org' + link.attributes[0].value;
  }
  var content_split = contents.split(' - ');
  console.log(defunct);
  brands.push({ defunct: defunct, country_name: content_split[1], wikipedia_url: wikipedia_url, name: link.innerHTML});

}


copy(JSON.stringify(brands));
