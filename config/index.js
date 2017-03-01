const config = {}

config.appConfig = {
  name : "About My Bike",
  s3Url: "https://s3-us-west-1.amazonaws.com/amb-storage",
  maxPhotoSize: 5000000,
  minPhotoSize: 200000,
  acceptedFileTypes: ['image/jpeg', 'image/png'],
  topicArn: process.env.SNS_CONTACT_FORM_TOPIC_ARN || 'arn:aws:sns:us-west-1:619254428467:amb-contact-form',
  awsRegion: 'us-west-1'
}

module.exports = config
