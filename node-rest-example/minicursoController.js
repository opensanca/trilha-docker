'use strict';


var mongoose = require('mongoose'),
  Minicurso = mongoose.model('Minicurso');

exports.list_all = function(req, res) {
  Minicurso.find({}, function(err, minicurso) {
    if (err)
      res.send(err);
    res.json(minicurso);
  });
};

exports.create = function(req, res) {
  var new_minicurso = new Minicurso(req.body);
  new_minicurso.save(function(err, minicurso) {
    if (err)
      res.send(err);
    res.json(minicurso);
  });
};


exports.read_one = function(req, res) {
  Minicurso.findById(req.params.minicursoId, function(err, minicurso) {
    if (err)
      res.send(err);
    res.json(minicurso);
  });
};

exports.delete_one = function(req, res) {
  Minicurso.remove({
    _id: req.params.minicursoId
  }, function(err, minicurso) {
    if (err)
      res.send(err);
    res.json({ message: 'Minicurso deletado com sucesso' });
  });
};
