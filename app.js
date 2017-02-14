let express = require('express');
let path = require('path');
let favicon = require('serve-favicon');
let logger = require('morgan');
let cookieParser = require('cookie-parser');
let bodyParser = require('body-parser');

let index = require('./routes/index');
let bikes = require('./routes/bikes');
let bike = require('./routes/bike');
let feedback = require('./routes/feedback');

let edit = require('./routes/edit');
let upload = require('./routes/upload');

let api = require('./api');

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

app.use(function(req,res,next){
  res.locals.app = {
    name : "About My Bike",
    s3Url: "https://s3-us-west-1.amazonaws.com/amb-storage"
  };

  next();
})

app.use('/', index);
app.use('/bikes', bikes);
app.use('/bike', bike);

app.use('/feedback', feedback);

//app.get('/:var(add|edit)', edit)
app.use(['/add', '/edit'], edit);

//app.use('/edit', edit);
//app.use('/add', add);
// app.use(['/abcd', '/xyza', /\/lmn|\/pqr/], function (req, res, next) {
//   next();
// });

app.use('/upload', upload);

// app.post('/upload', upload.single('bike_photo'), function (req, res, next) {
//   res.writeHead(200, {"Content-Type": "application/json"});
//   res.end(JSON.stringify({ tmp_path: req.file.path }));
// });

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  let err = new Error('404 Not Found');
  err.status = 404;
  next(err);
});

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
