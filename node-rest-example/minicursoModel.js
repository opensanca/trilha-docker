'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var minicursoSchema = new Schema({
  name: {
    type: String,
    Required: 'Nome do minicurso'
  },
  created_date: {
    type: Date,
    default: Date.now
  },
  description: {
    type: String,
    Required: 'Descrição do minicurso'
  }
});

module.exports = mongoose.model('Minicurso', minicursoSchema);