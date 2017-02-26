let express = require('express');
let path = require('path');
let favicon = require('serve-favicon');

let pg = require('pg');
let logger = require('morgan');
let bodyParser = require('body-parser');
let session = require('express-session');

const config = require('./config').appConfig;

// routes
let index = require('./routes/index');
let bikes = require('./routes/bikes');
let bike = require('./routes/bike');
let feedback = require('./routes/feedback');
let edit = require('./routes/edit');
let upload = require('./routes/upload');
let profile = require('./routes/profile');

let api = require('./api');

let app = express();

// these are globally added values. can be used in templages like {{app_name}}
app.locals.app_name = config.name;
app.locals.s3Url = config.s3Url;

app.locals.maxPhotoSize = config.maxPhotoSize;
app.locals.minPhotoSize = config.minPhotoSize;
app.locals.acceptedFileTypes = config.acceptedFileTypes;

let passport = require('passport');
let pgSession = require('connect-pg-simple')(session);

// session stuff:
require('./auth').init(app);

app.set('trust proxy', 1); // trust first proxy

var connectionString = 'postgres://localhost:5432/amb';

if (process.env.RDS_HOSTNAME !== undefined) {
  connectionString = 'postgres://' + process.env.RDS_USERNAME + ':' + process.env.RDS_PASSWORD + '@' + process.env.RDS_HOSTNAME + ':' + process.env.RDS_PORT + '/' + process.env.RDS_DB_NAME;
}

app.use(session({
  store: new pgSession({
    pg: pg,                          // Use global pg-module
    conString: connectionString,     // Connect using something else than default DATABASE_URL env variable
    tableName: 'session'             // Use another table-name than the default "session" one
  }),
  secret: 's3Cur3', // TO-DO make secret secret!!!
  resave: false,
  cookie: { maxAge: 30 * 24 * 60 * 60 * 1000 } // 30 days
}));

app.use(passport.initialize());
app.use(passport.session());

let userValues = function(req, res, next) {
  req.app.locals.user = req.user;
  next();
};

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use(express.static(path.join(__dirname, 'public')));

app.use(userValues);

app.use('/api', api);

app.use('/', index);
app.use('/bikes', bikes);
app.use('/bike', bike);
app.use('/feedback', feedback);
app.use(['/add', '/edit'], edit);
app.use('/upload', upload);
app.use('/profile', profile);

app.get('/auth/facebook',
  passport.authenticate('facebook', { scope: ['email'] }),
  function(req, res){});
app.get('/auth/facebook/callback',
  passport.authenticate('facebook', { failureRedirect: '/' }),
  function(req, res) {
    res.redirect('/add');
  });

/*
app.post('/login',
  passport.authenticate('local'),
  function(req, res) {
    // if the target is "/" but the user does not yet have a bike,
    // maybe redirect them to the bike page.

    // also keep the add bike links around until they create one.
    res.redirect(req.body.target);
  }
);
*/

app.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  let err = new Error('404 Not Found');
  err.status = 404;
  next(err);
});


/* TO-DO: use this middleware for the routes that reqiuire auth. */
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) { return next(); }
  res.redirect('/');
}

// error handler
app.use(function(err, req, res, next) {

  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
