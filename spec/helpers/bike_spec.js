var assert = require('assert');
var bikeHelper = require('../../helpers/bike');

describe('bikeHelper > ', function() {
  // beforeAll(function() {
  //   var db = {};
  //   db.bike = {
  //     all: function() { return [{ id:1 }]; }
  //   };
  // });

  describe('transformForDisplay()', function() {
    var record = {
      id: 5,
      brand_unlinked: null,
      model_unlinked: null,
      created_at: '2017-03-21T21:07:26.975Z',
      updated_at: '2017-03-22T05:08:17.520Z',
      user_id: 6,
      description: 'why??',
      notes: null,
      nickname: null,
      manufacturer_id: null,
      model_id: null,
      serial_number: null,
      type_ids: null,
      reason_ids: [ 9 ],
      status: 1,
      main_photo_id: 6,
      type: null,
      username: null,
      type_id: null,
      manufacturer_name: null,
      model_name: null,
      era: '1990s',
      color: null,
      main_photo_path: '/dev/2017-03-21/5-149007960_{*}.jpg' 
    };

    describe('should take a bike record from the db and transform it in some ways', function() {
      
      var bike = bikeHelper.transformForDisplay(record);

      // there must be a more elegant way to test these keys.
      it('should add a title value', function() {
        expect(bike.title).not.toBeUndefined();
      });
      it('should add a for value', function() {
        expect(bike.for).not.toBeUndefined();
      });
      it('should add a photo_url value', function() {
        expect(bike.photo_url).not.toBeUndefined();
      });
      it('should add a details value', function() {
        expect(bike.details).not.toBeUndefined();
      });
    });
  });
});