/*!
 * jQuery selekter plugin 
 * Author: @arobson
 * Licensed under the MIT license
 *
 * SELEKTER puts an image area select box on an image within a form that has a file input field.
 * The selecter will show the file that is attached as data inside an img tag. It's a preview that 
 * is separate from the uploader preview used in aboutmybike.
 *
 * We use it within a modal. If an attached photo needs cropping, then SELEKTER is attached. After the crop
 * is selected, SELEKTER is removed. The fields that SELEKTER updated remain on the form because they live
 * outside of SELEKTER
 *
 * It's a bit messy because it reaches into the form and sets values. It's not well-contained. Also the form
 * has to be set up in a certain way: requires an img tag and 5 hidden fields inside form. To prepare the form to
 * use SELEKTER add these elements:
 * 
 *   <img alt="Selected image to crop" id="cropTarget" src="./large_screenshots/a.png" />
 *
 *
 *
 *
 *
 */

// using this boilerplate: jquery-patterns/patterns/jquery.basic.plugin-boilerplate.js
;(function ( $, window, document, undefined ) {

  var pluginName = "selekter",
    defaults = {
      scale: 1, // this will always come form setup.
      requiredFields: [
        'scale',
        'xValue',
        'yValue',
        'cropWidth',
        'cropHeight',
      ]
    };

  // The actual plugin constructor
  function Plugin( element, options ) {
    this.element = element;
    var $el = $(element);

    this.image = options.img;

    this.options = $.extend( {}, defaults, options) ;
    this._defaults = defaults;
    this._name = pluginName;
    this.init();
  }

  Plugin.prototype = {

    OBLONG: 0.801,

    init: function() {
      var values = this.prepareSelectBoxValues(this.image.width(), this.image.height());

      // all of these fields need to be set on the form SELEKTER is attached to.
      // any are not found, bail.
      // this.options.requiredFields.forEach(function(field) {
      //   if($(this.element).find('input[name='+field+']').length === 0) {
      //     throw new Error('Field ' + field + ' missing in form');
      //   }
      // }).bind(this);

      // scale is set once, unless window is resized or something.
      var scale = parseFloat(this.options.actualWidth)/this.image.width();
      $(this.element).find('input[name='+this.options.requiredFields[0]+']').val(scale);

      // make and position a box on the image
      var cropBox = this.appendCropBox(this.image, values);

      // prepare dragSelecter options:
      var options = {
        container: this.image,
        requiredFields: this.options.requiredFields,
        form: this.element,
        onSelectMove: this.updatePositionValues
      };
     
      if ((this.image.height()/this.image.width()) > this.OBLONG) {
        // it can move vertically.
        options.orientation = 'vertical';
        options.maxVert = Math.round(this.image.offset().top + this.image.height() - cropBox.height());
      } else {
        options.orientation = 'horizontal';
        options.maxHoriz = Math.round(this.image.offset().left + this.image.width() - cropBox.width());
      }

      cropBox.dragSelecter(options);

      this.updateFormValues(this.element, this.options.requiredFields, values);
    },

    updateFormValues: function(el, fieldsArray, values) {
      $(el).find('input[name='+fieldsArray[1]+']').val(values.xValue);
      $(el).find('input[name='+fieldsArray[2]+']').val(values.yValue);
      $(el).find('input[name='+fieldsArray[3]+']').val(values.cropWidth);
      $(el).find('input[name='+fieldsArray[4]+']').val(values.cropHeight);
    },

    updatePositionValues: function(el, fieldsArray, values) {
      $(el).find('input[name='+fieldsArray[1]+']').val(values.xValue);
      $(el).find('input[name='+fieldsArray[2]+']').val(values.yValue);
    },

    // this is going to set the static box: height and width will not be changebale
    prepareSelectBoxValues: function(width, height) {
      var xValue, yValue, cropHeight, cropWidth;
      var scale = height/width;

      if (scale > 0.75) {
        // oblong.
        xValue = 0;
        cropWidth = width;
        cropHeight = width*0.75;
        yValue = (height - cropHeight)/2;
      } else {
        yValue = 0;
        cropHeight = height;
        cropWidth = height*1.33333333;
        xValue = (width - cropWidth)/2;
      }

      return {
        xValue: Math.round(xValue),
        yValue: Math.round(yValue),
        cropHeight: Math.round(cropHeight),
        cropWidth: Math.round(cropWidth),
      }
    },

    appendCropBox: function(img, values) {
      var cropBox = $('<div class="'+ pluginName + '"></div>');
      cropBox.css('width', values.cropWidth);
      cropBox.css('height', values.cropHeight);
      cropBox.css('top', values.yValue);
      cropBox.css('left', values.xValue);
      img.parent().append(cropBox);
      return cropBox;
    }
  };

  // A really lightweight plugin wrapper around the constructor,
  // preventing against multiple instantiations
  $.fn[pluginName] = function ( options ) {
    return this.each(function () {
      if (options === 'destroy') {
        $(this).find('div.selekter').remove()
        $.data(this, 'plugin_' + pluginName, null);
      } else if (!$.data(this, "plugin_" + pluginName)) {
        $.data(this, "plugin_" + pluginName,
        new Plugin( this, options ));
      }
    });
  };

})( jQuery, window, document );

/*!
 * jQuery drag-selecter plugin 
 * Author: @arobson
 * Licensed under the MIT license
 */

// using this boilerplate: jquery-patterns/patterns/jquery.basic.plugin-boilerplate.js
;(function ( $, window, document, undefined ) {

  var pluginName = "dragSelecter";
  var defaults = {};

  function Plugin( element, options ) {
    this.element = element;

    this.options = $.extend({ cursor: "move" }, defaults, options) ;

    this._defaults = defaults;
    this._name = pluginName;

    this.init();
  }

  Plugin.prototype = {

    init: function() {

      var opt = this.options;

      $(this.element).css('cursor', opt.cursor).on("mousedown", function(e) {
        var $drag = $(this).addClass('draggable');

        var cont_h = $(opt.container).outerHeight();
        var cont_w = $(opt.container).outerWidth();
        var cont_x = $(opt.container).offset().top;
        var cont_y = $(opt.container).offset().left;

        console.log('cont_h ' + cont_h + ' cont_w: ' + cont_w + ' cont_x: ' + cont_x + ' cont_y: ' + cont_y);

        var z_idx = $drag.css('z-index'),
          drg_h = $drag.outerHeight(),
          drg_w = $drag.outerWidth(),
          pos_y = $drag.offset().top + drg_h - e.pageY,
          pos_x = $drag.offset().left + drg_w - e.pageX;

        $drag.css('z-index', 1000).parent().on("mousemove", function(e) {

          // top value is min cont_x, max cont_x + cont_h
          var top = e.pageY + pos_y - drg_h;
          var left = e.pageX + pos_x - drg_w;
          if(top < cont_x) top = cont_x;
          if(top > (cont_x + cont_h)) top = (cont_x + cont_h - drg_h);


          if(left < cont_y) left = cont_y;
          if(left > (cont_y + cont_w)) left = (cont_y + cont_w - drg_w);

          if(opt.orientation === 'vertical') {
            left = $(opt.container).offset().left;
          }

          if(opt.orientation === 'horizontal') {
            top = $(opt.container).offset().top;
          }

          if (opt.maxVert) {
            top = Math.min(top, opt.maxVert);
          }

          if (opt.maxHoriz) {
            left = Math.min(left, opt.maxHoriz);
          }

          $('.draggable').offset({
            top: top,
            left: left
          }).on("mouseup", function() {
              $(this).removeClass('draggable').css('z-index', z_idx);
              opt.onSelectMove(opt.form, opt.requiredFields, {
                yValue: Math.round(top - $(opt.container).offset().top),
                xValue: Math.round(left - $(opt.container).offset().left),
              });
          });
        });
        e.preventDefault(); // disable selection

      }).on("mouseup", function() {
          if(opt.handle === "") {
              $(this).removeClass('draggable');
          } else {
              $(this).removeClass('active-handle').parent().removeClass('draggable');
          }

          // also update the values in the form
      });

    }

  };

  $.fn[pluginName] = function ( options ) {
    return this.each(function () {
      if (options === 'destroy') {
        $.data(this, 'plugin_' + pluginName, null);
      } else if (!$.data(this, "plugin_" + pluginName)) {
        $.data(this, "plugin_" + pluginName,
        new Plugin( this, options ));
      }
    });
  };

})( jQuery, window, document );