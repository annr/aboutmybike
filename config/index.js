const config = {}

config.appConfig = {
  name : "About My Bike",
  adminUserIds: [1, 5],
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
  rekognitionRegion: 'us-west-2',
  mainImageSizes: [ // 1024x768, 500x375, 240x180, 100x75
    {label: 'Full', size_key: 'f'}, // full resolution but quality currently at 0.8
    {label: 'Large', size_key: 'b', width: 1024, height: 768},
    {label: 'Medium', size_key: 'm', width: 500, height: 375},
    {label: 'Small', size_key: 's', width: 240, height: 180},
    {label: 'Thumbnail', size_key: 't', width: 100, height: 75}
  ],
  mainImageSizeKeyOriginal: 'o',
}

module.exports = config
