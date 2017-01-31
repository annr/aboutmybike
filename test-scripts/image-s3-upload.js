
var fs = require('fs');

// Load the SDK and UUID
var AWS = require('aws-sdk');

// Create an S3 client
var s3 = new AWS.S3();
var fs = require('fs');

// Create a bucket and upload something into it
//var bucketName = 'node-sdk-sample-' + uuid.v4();

var bucketName = 'amb-storage';

var keyName = 'hello_world.txt';

fs.readFile('./45.jpg', (err, data) => {
  if (err) throw err;
  console.log('gonna do it');
  var params = {Bucket: bucketName, Key: '45.jpg', Body: data};
  s3.putObject(params, function(err, data) {
    if (err)
      console.log(err)
    else
      console.log("Successfully uploaded data to " + '45.jpg' + "/" + keyName);
  });
});

//s3.createBucket({Bucket: bucketName}, function() {

//});
