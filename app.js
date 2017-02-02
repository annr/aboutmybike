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
let feedback = require('./routes/feedback');

let api = require('./api');

let queries = require('./db/queries');
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
  res.locals.app = { name : "About My Bike" };
  next();
})

app.use('/', index);
app.use('/bikes', bikes);

app.get('/bike/:id', function(req, res, next) {
  var id = req.params.id;

  queries.getSingleBike(id, function(data) {
    var bike = data;
    var detailString = [];

    bike.title = (bike.brand + " " + bike.model).trim();

    bike.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc et tempus orci. Aenean consectetur sagittis condimentum. Morbi efficitur turpis nec faucibus tincidunt. Duis in arcu facilisis, aliquet dolor quis, ultrices velit. Praesent vitae dolor risus. Phasellus blandit mattis laoreet. Nulla enim dui, semper eget risus et, placerat sodales nulla. Suspendisse facilisis orci ac consectetur aliquam. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi non est tempor, fermentum turpis sed, molestie lacus. Praesent commodo diam vel gravida sodales. Donec luctus rhoncus blandit. Pellentesque nec ipsum nec ipsum eleifend volutpat.';
    bike.city = "San Francisco";
    bike.era = "1980s";

    detailString.push(bike.era);
    if(bike.speeds) {
      detailString.push(bike.speeds + ' speed');
    }
    if(bike.handlebars) {
      detailString.push(bike.handlebars + ' handlebars');
    }
    if(bike.brakes) {
      detailString.push(bike.brakes + ' brakes');
    }
    bike.details = detailString.join(', ');

    res.render('bike', {
      app_name: res.locals.app.name,
      page_title: 'Bike Detail', 
      bike: bike
    });
  });
});

app.use('/add', add);
app.use('/feedback', feedback);

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
