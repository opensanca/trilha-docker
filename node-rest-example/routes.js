'use strict';
module.exports = function(app) {
  var minicursos = require('./minicursoController');


  app.route('/').get(function(req, res){console.log('Index'); res.json('Webserver Running!');});
  app.route('/minicursos')
    .get(minicursos.list_all)
    .post(minicursos.create);

  app.route('/minicursos/:minicursoId')
    .get(minicursos.read_one)
    .delete(minicursos.delete_one);
};

