var labels = require("./bike_labels_messy.js").labels;
var brands = require("./brand-names.js").brands;

function escapeRegExp(str) {
  return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
}

Array.prototype.customIndexOf = function (searchElement, fromIndex) {
    return this.map(function (value) {
        return value.toLowerCase();
    }).indexOf(searchElement.toLowerCase(), fromIndex);
};

for (var i = 0; i < brands.length; i++) {

  var brandLabel = brands[i].name.toLowerCase()
    .replace('bicycles', '')
    .replace('cycle company', '')
    .replace('bicycle company', '')
    .replace('bicycle corporation', '')
    .replace('bikes', '')
    .replace('cycles', '')
    .replace('fabrications', '')
    .replace('(bicycle)', '').trim();

  brandLabel = brandLabel.trim();
  brandLabel = brandLabel.replace('bike');
  //console.log("\nBRRAAAAAAAADNND:\n" + brandLabel);

  brands[i].extracted_models = [];

  for (var j = 0; j < labels.length; j++) {
  //for (var j = 0; j < 5000; j++) {
    var newLabel = '';

    // or the first part of brand label.

    var regExStr = '\\b' + escapeRegExp(brandLabel) + '\\b';
    var regEx = new RegExp(regExStr, 'i');
    if(regEx.test(labels[j])) {

      // remove "x" speed from label
      //var re =

      //var getAfterRegEx = "(.*)\\s(" + brandLabel + ")\\s(\\w+)";
      var getAfterRegEx = "("+brandLabel+"\\b)";

      var re = new RegExp(getAfterRegEx, "i");
      
      //newLabel = labels[j].replace(re, "$3");

      var matchResult = labels[j].match(re);

      newLabel = labels[j].substring(matchResult.index + brandLabel.length +1);

      var oldLabel = newLabel;

      var badStrRegExes = [
        /(\d\d?\s?speed\b)/i,
        /(\bsize\s?\d\d)/i,
        /(\d\d?-speed\b)/i,
        /(\w+-speed\b)/i,
        /(\w+\s?speed\b)/i,
        /(\bsold\b)/i,
        /(\b\d\dcm\b)/i,
        /(\b20\d\ds?\b)/i,
        /(\b19\d\ds?\b)/i,
        /(\b\d\d\scm\b)/i,
        /(\broad\s?bike\d+)/i,
        /(\brebuilt\b)/i,
        /(\brebuild\b)/i,
        /(\bretired\b)/i,
        /(\bvintage\b)/i,
        /(\bmodel\b)/i,
        /(\bcustom\b)/i,
        /(\btrack\b)/i,
        /(\bspecial\b)/i,
        /(\bclassic\b)/i,
        /(\bmodel\b)/i,
        /(\bwith\b)/i,
        /(\bearly\s?-?[2-9]0'?s\b)/i,
        /(\bmid\s?-?[2-9]0'?s\b)/i,
        /(\blate\s?-?[2-9]0'?s\b)/i,
        /(\b[1][9]?[2-9]0'?s\b)/i,
        /(\b[2-9]0'?s\b)/i,
        /(\bfor\s?sale\b)/i,
        /(\bgirl'?\s?bike\b)/i,
        /(\bgirl'?s\b)/i,
        /(\bgirl\b)/i,
        /(\bladies'?\b)/i,
        /(\bwomen\b)/i,
        /(\bwomen'?s\b)/i,
        /(\bbikes\b)/i,
        /(\bbike\b)/i,
        /(\bcycle\b)/i,
        /(\bbicycle\b)/i,
        /(\bstep\s?through\b)/i,
        /(\bstep-through\b)/i
      ];

      badStrRegExes.map(function(regex) {
        var match = newLabel.match(regex);
        if(match) {
          //console.log('old label:::' + newLabel);
          newLabel = newLabel.substring(0, match.index - 1) + newLabel.substring(match.index + match[0].length);
          // console.log('match...');
          // console.log(regex);
          // console.log('trimmed:: ' + newLabel);
        }
      });

      // take special characters off
      newLabel = newLabel.replace(/[^\w\s]/gi, '');

      newLabel = newLabel.replace('  ', ' ');

      newLabel = newLabel.trim();

      // if(newLabel.indexOf('90s') !== -1) {
      //   console.log('FOUND 90s!!!!!!!!!');
      //   console.log('old label:: ' + oldLabel);
      // }

      // words that show up in bad records, only because you know the outcome.
      var overrideCustom = [
        'gran criterum',
        'grand criterium',
        'hubs',
        'low-pro',
        'lopro',
        'pinky',
        'sanzhez',
        '3volumetrica',
        'tarck bike',
        'unknown',
        'unkown',
        'girls bike',
        'trak',
        'time trial',
        'fix',
        'jaskson',
        'fixer'
      ];

      // words that indicate it's not a probably model
      // you may want to word-boundary extract this instead of throwing whole record out.
      var badWords = [
        'mtb',
        'bmx',
        'fixed',
        'fixie',
        'frame',
        'tandem',
        'hub',
        'rip',
        'beater',
        'mixte',
        'fixte',
        'commuter',
        'and',
        'sexy',
        'aka',
        'sex',
        'bitchin',
        'cool',
        'conversion',
        'fork',
        'brooks',
        'new',
        'upgrade',
        'japanese',
        'made',
        'fast',
        'singlespeed',
        'project',
        'stolen',
        'touring',
        'bleu',
        'fun',
        'love',
        'mountain',
        'build',
        'at',
        'in',
        'i',
        'you',
        'of',
        'on',
        'by',
        'from',
        'after',
        'behind',
        'around',
        'too',
        'rad',
        'totally',
        'very',
        'such',
        'less',
        'bad',
        'beautiful',
        'cruiser',
        'beach',
        'tubing',
        'gone',
        'built',
        'amp',
        'home',
        'quipement',
        'update',
        'refurb',
        'hybrid',
        'cyclocross',
        'cyclo'
      ];

      var colors = [
        'black',
        'red',
        'blue',
        'green',
        'orange',
        'brown',
        'green',
        'yellow',
        'purple',
        'silver',
        'grey',
        'gray',
        'white',
        'gold',
        'orange',
        'tan',
        'teal',
        'magenta',
        'pink'
      ]

      var rejectWords = badWords.concat(overrideCustom);

      rejectWords = rejectWords.concat(colors);

      var remove = false;
      var remove = rejectWords.some(function(word) {
        var wordRegex= "\\b"+word+"\\b";
        var re = new RegExp(wordRegex, "i");
        return re.test(newLabel);
      });
      if(!remove && newLabel && newLabel.length > 2 && newLabel.length < 20 && newLabel.toLowerCase() !== 'road' && newLabel.indexOf('s ') !== 0 && newLabel.indexOf('x ') !== 0 && newLabel.indexOf('X ') !== 0 && newLabel.indexOf('r ') !== 0 && newLabel.toLowerCase() !== 'pro') {
        // if case-insensitive model is not already in array add it
        if(brands[i].extracted_models.customIndexOf(newLabel) === -1) {

          brands[i].extracted_models.push( newLabel );
        }
      }
    }

  }

  if(brands[i].extracted_models.length > 0) {
    console.log(JSON.stringify(brands[i]));
  }


}





