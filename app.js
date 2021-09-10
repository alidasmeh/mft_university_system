var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
require('dotenv').config()

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

// set cookie as middleware ( We will delete it in future)
app.use(function (req, res, next) {
  res.cookie('user_id', 1);
  next();
});

app.use(express.static(path.join(__dirname, 'public')));


app.use('/courses', require('./routes/courses'));

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

module.exports = app;
