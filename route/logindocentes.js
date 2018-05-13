/*
 * En este archivo utilizamos sha512 que nos servira para encriptar las
 * contraseñas antes de almacenarlas.
 */
var express = require('express');
var bodyParser = require("body-parser");
var sha512 = require('sha512');

var realizarQuery = require('../modulos/conexion').realizarQuery;
var realizarQrCB = require('../modulos/conexion').realizarQrCB;



var router = express.Router();
var urlEncodeParser = bodyParser.urlencoded({
  extended: false
});

router.use(bodyParser.json());



module.exports = router;
