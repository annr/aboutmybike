let ids = {
  production: {
    clientID: process.env.FACEBOOK_APP_ID,
    clientSecret: process.env.FACEBOOK_APP_SECRET,
    callbackURL: '/auth/facebook/callback',
  },
  localhost: {
    clientID: '395199327523676',
    clientSecret: 'c7b483a37c9fa5d74b9c258c2d469fe6',
    callbackURL: '/auth/facebook/callback',
  }
};

module.exports = ids;