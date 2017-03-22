// This is where the mocha tests would go. 
// I'm leaving this in here because mocha seems to go with node / express well.

// yYou can run it from the root folder with: ./node_modules/mocha/bin/mocha
// or by adding "test" : "mocha" to scripts {} and simply running `npm test`

var assert = require('assert');
describe('Array', function() {
  describe('#indexOf()', function() {
    it('should return -1 when the value is not present', function() {
      assert.equal(-1, [1,2,3].indexOf(4));
    });
  });
});