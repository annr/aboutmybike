const express = require('express');
const path = require('path');
const favicon = require('serve-favicon');
const AWS = require('aws-sdk');
const pg = require('pg');
const logger = require('morgan');
const bodyParser = require('body-parser');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const flash = require('connect-flash');
const hbs = require('hbs');
const config = require('./config').appConfig;
const api = require('./api');
const passport = require('passport');
const PGSession = require('connect-pg-simple')(session);

// routes
const index = require('./routes/index');
const bikes = require('./routes/bikes');
const bike = require('./routes/bike');
const feedback = require('./routes/feedback');
const edit = require('./routes/edit');
const add = require('./routes/add');
const upload = require('./routes/upload');
const profile = require('./routes/profile');
const profile_edit = require('./routes/profile_edit');
const password_change = require('./routes/password_change');

const privacy = require('./routes/privacy');
const terms = require('./routes/terms');

const signup = require('./routes/signup');
const login = require('./routes/login');

const admin = require('./routes/admin');
const username = require('./routes/username');

const verify = require('./routes/verify');

const app = express();

AWS.config.region = config.awsRegion;

// these are globally added values. can be used in templages like {{app_name}}
app.locals.app_name = config.name;
app.locals.year = new Date().getFullYear();
app.locals.s3Url = config.s3Url;

app.locals.maxPhotoSize = config.maxPhotoSize;
app.locals.minPhotoSize = config.minPhotoSize;
app.locals.acceptedFileTypes = config.acceptedFileTypes;

// session stuff:
require('./auth').initFacebook(app);
require('./auth').init(app);

app.set('trust proxy', 1); // trust first proxy

const env = process.env.NODE_ENV || 'development';

const HOST = process.env.RDS_HOSTNAME || 'localhost';
const PORT = process.env.RDS_PORT || '5432';
const DB_NAME = process.env.RDS_DB_NAME || 'amb';
const DB_USER = process.env.RDS_USERNAME || 'arobson';
const DB_PASSWORD = process.env.RDS_PASSWORD;

let connectionString = `postgres://${HOST}:${PORT}/${DB_NAME}`;
let iconFile = 'favicon.ico';

if (env !== 'development') {
  connectionString = `postgres://${DB_USER}:${DB_PASSWORD}@${HOST}:${PORT}/${DB_NAME}`;
}

if (env !== 'production') {
 iconFile = `favicon-${env}.ico`;
}

app.use(cookieParser());
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use(session({
  store: new PGSession({
    pg,
    conString: connectionString,
    tableName: 'session',
  }),
  secret: 'ilovebikesbikesbikes',
  resave: false,
  cookie: { maxAge: 30 * 24 * 60 * 60 * 1000 },
  saveUninitialized: false, // TO-DO: Understand this setting better.
}));
app.use(flash());

app.use(passport.initialize());
app.use(passport.session());

app.get('/auth/facebook',
  passport.authenticate('facebook', { scope: ['email'] }),
  function (req, res) {});

app.get('/auth/facebook/callback',
  passport.authenticate('facebook', { failureRedirect: '/' }),
  function (req, res) {
    // if they haven't added their username yet, take them to the form.
    if (!req.user.username) {
      req.flash('flashMessage', 'You are successfully authenticated. We need just one more piece of information to create your account: a username.')
      res.redirect('/username');
    } else if (req.user.bike_id) {
      res.redirect(`/bike/${req.user.bike_id}`);
    } else {
      res.redirect('/add');
    }
  });

// TO-DO: send user to their bike page or the add page if they have not yet added their bike.
app.post('/login',
  passport.authenticate('local-login', {
    successRedirect: '/add', // the home page will have bikes on it soon.
    failureRedirect: '/login',
    failureFlash: true
  })
);

// TO-DO: send user to their bike page or the add page if they have not yet added their bike.
app.post('/signup',
  passport.authenticate('local-signup', {
    successRedirect: '/add', // the home page will have bikes on it soon.
    failureRedirect: '/signup',
    failureFlash: true
  })
);

/* MIDDLEWARE */
const ensureAuthenticated = function (req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect('/');
};

const ensureAdmin = function (req, res, next) {
  // assumes logged in.
  if (env === 'development' || config.adminUserIds.indexOf(req.user.id) !== -1) {
    return next();
  }
  res.redirect('/');
};

const userValues = function (req, res, next) {
  req.app.locals.user = req.user; // eslint-disable-line no-param-reassign
  next();
};

/* END MIDDLEWARE */

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

hbs.registerPartials(__dirname + '/views/partials');
hbs.registerHelper('preserve-linebreaks', function (str) {
  // we have to escape all the special chars and then conver line breaks to brs.
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
    .replace(/(?:\r\n|\r|\n)/g, '<br />');
});

app.use(favicon(path.join(__dirname, 'public', iconFile)));

app.use(express.static(path.join(__dirname, 'public')));

app.use(userValues);

app.use('/api', api);

app.use('/', index);
app.use('/bikes', bikes);
app.use('/bike', bike);
app.use('/feedback', feedback);
app.use('/privacy', privacy);
app.use('/terms', terms);

app.use('/login', login);
app.use('/signup', signup);

app.use('/admin', ensureAuthenticated, ensureAdmin, admin);
app.use('/username', ensureAuthenticated, username);

// these routes need to be authenticated:
app.use('/edit', ensureAuthenticated, edit);
app.use('/add', ensureAuthenticated, add);
app.use('/upload', ensureAuthenticated, upload);
app.use('/u', ensureAuthenticated, profile);
app.use('/profile_edit', ensureAuthenticated, profile_edit);
app.use('/password_change', ensureAuthenticated, password_change);

app.use('/verify', ensureAuthenticated, ensureAdmin, verify);

app.get('/logout', function (req, res) {
  req.logout();
  res.redirect('/');
});

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  let err = new Error('404 Not Found');
  err.status = 404;
  if (env !== 'development') {
    //res.render('404', { layout: 'error-layout' });
  } else {
    next(err);
  }
});

// error handler
// there is no next()
// app.use(function (err, req, res, next) {
app.use(function (err, req, res) {
  let sns = new AWS.SNS();
  let params;
  // set locals, only providing error in development
  res.locals.message = err.message; // eslint-disable-line no-param-reassign
  res.locals.error = req.app.get('env') === 'development' ? err : {}; // eslint-disable-line no-param-reassign

  // publish prod and staging SNS errors:
  if (env !== 'development') {
    params = {
      Message: `${err.message}\n\n${err.message.stack}`,
      Subject: `Express Error: ${err.message.substring(0, 20)}`,
      TopicArn: config.topicArn + config.snsExpressErrorTopicName,
    };
    sns.publish(params, function (err) {
      if (err) {
        console.log(`Error sending SNS: ${err}`);
        console.log('Config of SNS error: ');
        console.log(AWS.config);
      }
    });
  }

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
