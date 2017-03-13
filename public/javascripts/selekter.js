/*!
 * jQuery selekter plugin 
 * Author: @arobson
 * Licensed under the MIT license
 */

// using this boilerplate: jquery-patterns/patterns/jquery.basic.plugin-boilerplate.js
;(function ( $, window, document, undefined ) {

  // undefined is used here as the undefined global
  // variable in ECMAScript 3 and is mutable (i.e. it can
  // be changed by someone else). undefined isn't really
  // being passed in so we can ensure that its value is
  // truly undefined. In ES5, undefined can no longer be
  // modified.

  // window and document are passed through as local
  // variables rather than as globals, because this (slightly)
  // quickens the resolution process and can be more
  // efficiently minified (especially when both are
  // regularly referenced in your plugin).

  // Create the defaults once
  var pluginName = "selekter",
    defaults = {
      aspectRatio: "4:3",
      x1: 0,
      y1: 0,
      x2: 100,
      y2: 100,
      onInit: function() {}
    };

  // The actual plugin constructor
  function Plugin( element, options ) {
    this.element = element;

    // jQuery has an extend method that merges the
    // contents of two or more objects, storing the
    // result in the first object. The first object
    // is generally empty because we don't want to alter
    // the default options for future instances of the plugin
    this.options = $.extend( {}, defaults, options) ;

    this._defaults = defaults;
    this._name = pluginName;

    this.init();
  }

  Plugin.prototype = {

    init: function() {

      // make and position a box on the image
      this.showCropBox(this.element, this.options);

      this.options.onInit(null, {
        x1: this.options.x1,
        x2: this.options.x2,
        y1: this.options.y1,
        y2: this.options.y2,
      });
    },

    showCropBox: function(el, options) {
      var cropBox = $('<div class="selekter-croparea"></div>');
      cropBox.css('width', options.x2 - options.x1);
      cropBox.css('height', options.y2 - options.y1);
      cropBox.css('top', options.y1);
      cropBox.css('left', options.x1);
      $(el).parent().append(cropBox);
    }
  };

  // A really lightweight plugin wrapper around the constructor,
  // preventing against multiple instantiations
  $.fn[pluginName] = function ( options ) {
    return this.each(function () {
      if (!$.data(this, "plugin_" + pluginName)) {
        $.data(this, "plugin_" + pluginName,
        new Plugin( this, options ));
      }
    });
  };

})( jQuery, window, document );