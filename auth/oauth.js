var ids = {
  production: {
    clientID: process.env.FACEBOOK_APP_ID,
    clientSecret: process.env.FACEBOOK_APP_SECRET,
    callbackURL: 'http://aboutmybike.com/auth/facebook/callback'
  },
  localhost: {
    clientID: '395199327523676',
    clientSecret: 'c7b483a37c9fa5d74b9c258c2d469fe6',
    callbackURL: 'http://localhost:3000/auth/facebook/callback'
  }
};

module.exports = ids;