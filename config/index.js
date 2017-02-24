const config = {}

config.appConfig = {
  name : "About My Bike",
  s3Url: "https://s3-us-west-1.amazonaws.com/amb-storage",
  maxPhotoSize: 5000000,
  minPhotoSize: 200000,
  acceptedFileTypes: ['image/jpeg', 'image/png']
}

module.exports = config
