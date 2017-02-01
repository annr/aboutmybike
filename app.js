let express = require('express');
let path = require('path');
let favicon = require('serve-favicon');
let logger = require('morgan');
let cookieParser = require('cookie-parser');
let bodyParser = require('body-parser');

let index = require('./routes/index');
let bikes = require('./routes/bikes');
let bike = require('./routes/bike');
let add = require('./routes/add');

let api = require('./api');

let static = require('./db/static-bikes');
let app = express();

app.use('/api', api);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', index);
app.use('/bikes', bikes);

app.get('/bike/:id', function(req, res, next) {
  var id = req.params.id;

  // get bike and pass to bike object.

  res.render('bike', { title: 'About My Bike', layout: 'layout', bike: static.getSingleBike(id) });
});

app.use('/add', add);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  let err = new Error('404 Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {

  console.log('SHOULD SHOW ERROR');
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
