
var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000
 mongoose = require('mongoose'),
 Minicurso = require('./minicursoModel'),
 bodyParser = require('body-parser');
  
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://c_mongo/opensanca');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


var routes = require('./routes');
routes(app);

app.listen(port);

console.log('Opensanca Minicursos RESTful API server started on: ' + port);