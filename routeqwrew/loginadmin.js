var express = require('express');
var bodyParser = require("body-parser"); 
var realizarQuery = require('../modulos/conexion').realizarQuery;

var router = express.Router();
var urlEncodeParser = bodyParser.urlencoded({
  extended: false
});

router.use(bodyParser.json());

router.post("/getSuscripcion", urlEncodeParser, function(request, response){
    var sql = "SELECT codPlanPago, codUsuario, fechaAprobación, fechaVencimiento, estadoPlan FROM tblhistorialplanes WHERE codUsuario=? AND estadoPlan='activo'";
    var values = [request.body.codigo];
    realizarQuery(sql,values, function(res){
      response.send(res);
    });
});

router.post("/getHistorial", urlEncodeParser, function(request, response){
    var sql = "SELECT codPlanPago, codUsuario, fechaAprobación, fechaVencimiento, estadoPlan FROM tblhistorialplanes WHERE codUsuario=? AND estadoPlan='vencido'";
    var values = [request.body.codigo];
    realizarQuery(sql,values, function(res){
      response.send(res);
    });
});

router.post("/getEmpresa", urlEncodeParser, function(request, response){
    var sql = "SELECT codEmpresa FROM tblempresas WHERE codUsuario=?";
    var values = [request.body.codigoUser];
    realizarQuery(sql,values, function(res){
      response.send(res);
    });
});


module.exports = router;