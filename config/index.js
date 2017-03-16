const config = {}

config.appConfig = {
  name : "About My Bike",
  s3Url: "https://s3-us-west-1.amazonaws.com/amb-storage",
  maxPhotoSize: 18000000,
  minPhotoSize: 50000,
  minPixelsWidth: 1024, // not yet used.
  acceptedFileTypes: ['image/jpeg', 'image/png'],
  topicArn: process.env.SNS_CONTACT_FORM_TOPIC_ARN || 'arn:aws:sns:us-west-1:619254428467:',
  snsContactFormTopicName: 'amb-contact-form',
  snsExpressErrorTopicName: 'amb-express-error',
  snsUserSignupTopicName: 'amb-user-signup',
  awsRegion: 'us-west-1',
  s3Bucket: 'amb-storage',
  rekognitionBucket: 'amb-processing',
  rekognitionRegion: 'us-west-2'
}

module.exports = config
