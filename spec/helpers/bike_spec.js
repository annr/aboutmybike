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
      id: 1,
      brand_unlinked: null,
      model_unlinked: null,
      created_at: '2017-02-27T19:08:28.874Z',
      updated_at: '2017-02-27T19:08:28.874Z',
      user_id: 4,
      description: 'I found this bike when I was at home visiting my parents in France. My father was renting a little house to this man named Antoine, who was somewhat of a mysterious man. My father had not heard from him in a while so he decided to pay him a visit, and I went along with him. It turned out that Antoine had moved out without telling anyone in the village. The house was left mostly empty with the exception of a few things, including this bicycle, which was left to rust, leaning against one of the outside walls. The fenders and wheels were quite rusty, and at first glance, it seemed unsalvageable. My father was about to throw it in the back of the van with a bunch of other junk to bring it to the recycling center. I decided I\'d try and salvage the frame, to see if I could give it a second life.\r\n\r\nThe top tube was a little rusty (around the brake cable braze ons) so I got the leather top tube wrap from Velo Orange to protect it. I also installed a new bottom bracket, cranks, pedals, wheels, handlebar, and seatpost. The rack is from SOMA fabrications, and I bolted to wine box to it (perfect for carrying stuff around and making trips to the grocery store). The Compass tires make this an amazingly comfortable ride and pure fun cruising around town! I\'m not sure where Antoine is now, but I\'m sure he would have never imagined his bike looking this good and being ridden on the other side of the world. See you out there!',
      notes: null,
      nickname: null,
      manufacturer_id: 5815,
      model_id: null,
      serial_number: null,
      type_ids: [ 13 ],
      reason_ids: [ 1, 2, 4, 5, 6, 9 ],
      status: 1,
      main_photo_path: 'example.jpg',
      era: '1990s'
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