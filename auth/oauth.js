var ids = {
  facebook: {
    clientID: process.env.FACEBOOK_APP_ID,
    clientSecret: process.env.FACEBOOK_APP_SECRET,
    callbackURL: 'http://aboutmybike.com/auth/facebook/callback'
  }
};

module.exports = ids;