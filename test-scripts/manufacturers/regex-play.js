
var newLabel = '10speed 20 cm Trek Sprtizter 1997'
var badStrRegExes = new Array(
  /(\b\d\d\d\d\b)/i,
  /(\d\d?\s?speed\b)/i,
  /(\w+\s?speed\b)/i,
  /(\bsold\b)/i,
  /(\b\d\dcm\b)/i,
  /(\b\d\d\scm\b)/i);
//newLabel = newLabel.replace(speedStrRegEx, "$1");


var l = "boo 10speed 20 cm Trek Sprtizter 1997 ten speed";
var m = l.match(badStrRegExes[0]);

console.log(m);


badStrRegExes.map(function(regex) {
  var match = newLabel.match(regex);
  if(match) {
    newLabel = newLabel.substring(0, match.index - 1) + newLabel.substring(match.index + match[0].length);
    //console.log('speed trimmed: ' + newLabel);
  }
});

var newLabel = "10speed 20 cm Trek Sprtizter 1997 late 60s vintage 80s for sale 50's";

      var badStrRegExes = [
        /(\b50'?s\b)/i,
        /(\bmid-?60'?s\b)/i
      ];
//newLabel = newLabel.replace(speedStrRegEx, "$1");

badStrRegExes.map(function(regex) {
  var match = newLabel.match(regex);
  if(match) {
    newLabel = newLabel.substring(0, match.index - 1) + newLabel.substring(match.index + match[0].length);
  }
});

console.log(newLabel);

var badStrRegEx = /(\b\d\d\d\d\b)/i;
//newLabel = newLabel.replace(speedStrRegEx, "$1");
var l = "boo 10speed 20 cm Trek Sprtizter 1997 ten speed";
var m = l.match(badStrRegEx);



var badStrRegEx = /(\b\d\d\d\d\b)/i;
//newLabel = newLabel.replace(speedStrRegEx, "$1");
var l = "boo 10speed 20 cm Trek Sprtizter 1997 ten speed";
var m = l.match(badStrRegEx);
m



var newLabel = 'boo 10speed 20 cm Trek Sprtizter 1997 ten speed'
var badStrRegExe = /(\b\d\d\d\d\b)/i;


//newLabel = newLabel.replace(speedStrRegEx, "$1");

badStrRegExes.map(function(regex) {
  var match = newLabel.match(badStrRegEx);
  if(match) {
    newLabel = newLabel.substring(0, match.index - 1) + newLabel.substring(match.index + match[0].length);
    console.log(m.index);
  }
});




var newLabel = 'boo 10speed 20 cm Trek Sprtizter 1997 ten speed'
var badStrRegExes = [
  /(\b\d\d\d\d\b)/i
];
//newLabel = newLabel.replace(speedStrRegEx, "$1");

badStrRegExes.map(function(regex) {
  console.log(regex);
  console.log(regex.test(newLabel));
  //var match = newLabel.match(regex);
  //if(match) {
  //  newLabel = newLabel.substring(0, match.index - 1) + newLabel.substring(match.index + match[0].length);
  //  console.log(m.index);
  //}
});




//GOOD FOR SPEED:

var speedStrRegEx = /(\d*\sspeed)|(\w+\sspeed)/i;
//newLabel = newLabel.replace(speedStrRegEx, "$1");

var matchSpeeds = newLabel.match(speedStrRegEx);
if(matchSpeeds) {
  newLabel = newLabel.substring(0, matchSpeeds.index - 1) + newLabel.substring(matchSpeeds.index + matchSpeeds[0].length);
}


/*

var str = "good bad";

var re = /(\w+)\s(\w+)/;

//str.match(re);

str.replace(re, "$2")
//str.replace(regex, function(match, $1, $2, offset, original) { return someFunc($2); })

function someFunction(piece) {
  console.log(piece);
}

*/


// working:

var newLabel = '';
var label = "2001 Trek Speeder";
var brand = "Trek";
//var getAfterRegEx = '(\w+)(' + brand + '\\b)?\s(\w+)';
//var getAfterRegEx = "(\d+)";
//var re = new RegExp(getAfterRegEx, "i");
var re = /(\w+)\s(\w+)\s(\w+)/;

console.log(label.match(re));

newLabel = label.replace(re, "$1, $2, $3");

console.log(newLabel);



//still working: 

var newLabel = '';
var label = "2001 Trek Speeder";
var brand = "Trek";
//var getAfterRegEx = '(\w+)(' + brand + '\\b)?\s(\w+)';
var getAfterRegEx = "(.*)\\s(" + brand + ")\\s(\\w+)";
var re = new RegExp(getAfterRegEx, "i");
//var re = /(\w+)\s(\w+)\s(\w+)/;
console.log(label.match(re));

newLabel = label.replace(re, "$1: $2: $3");

// good:

var newLabel = '';
var label = "2001 Boo Boo Trek Speeder";
var brand = "trek";
//var getAfterRegEx = '(\w+)(' + brand + '\\b)?\s(\w+)';
var getAfterRegEx = "(.*)\\s(" + brand + ")\\s(\\w+)";
var re = new RegExp(getAfterRegEx, "i");
//var re = /(\w+)\s(\w+)\s(\w+)/;
console.log(label.match(re));

newLabel = label.replace(re, "$3");

// outputs: 

// ["2001 Boo Boo Trek Speeder", "2001 Boo Boo", "Trek", "Speeder", index: 0, input: "2001 Boo Boo Trek Speeder"]
// "Speeder"


var newLabel = '';
var label = "Baddass Cruiser, Jamis, 2000 Hot Rodded, high performance";
var brand = "jamis";
//var getAfterRegEx = '(\w+)(' + brand + '\\b)?\s(\w+)';
//var getAfterRegEx = "(.*)\\s(" + brand + ")\\s(\\w+)";
var getAfterRegEx = "("+brand+"\\b)";
var re = new RegExp(getAfterRegEx, "i");
//var re = /(\w+)\s(\w+)\s(\w+)/;
var matchResult = label.match(re);

console.log(label.substring(matchResult.index + brand.length +1));

newLabel = label.replace(re, "$1: $2::: $3");

//console.log(newLabel);


// trek version:

var newLabel = '';
var label = "2001 Boo Boo Trek Speeder";
var brand = "trek";
//var getAfterRegEx = '(\w+)(' + brand + '\\b)?\s(\w+)';
//var getAfterRegEx = "(.*)\\s(" + brand + ")\\s(\\w+)";
var getAfterRegEx = "("+brand+"\\b)";
var re = new RegExp(getAfterRegEx, "i");
//var re = /(\w+)\s(\w+)\s(\w+)/;
var matchResult = label.match(re);

console.log(label.substring(matchResult.index + brand.length +1));

newLabel = label.replace(re, "$1: $2::: $3");

//console.log(newLabel);


// fix:

BRRAAAAAAAADNND:
jamis
found this :jamis in this :Baddass Cruiser, Jamis, 2000 Hot Rodded, high performance

RTURN AFTER: Baddass Cruiser, Jamis, 2000 Hot Rodded, high performance



