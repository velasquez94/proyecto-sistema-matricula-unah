var express = require('express');
var bodyParser = require("body-parser");
var sha512 = require('sha512');

var router = express.Router();

var urlEncodeParser = bodyParser.urlencoded({
  extended: false
});

router.use(bodyParser.json());

var realizarQuery = require('../modulos/conexion').realizarQuery;

router.post('/', urlEncodeParser, function(peticion,respuesta){

	//console.log("consiguiendo datos");
	var sql = "SELECT codUsuario as codigo, nombres, apellidos, telefono, correo, contrasena FROM tblusuarios WHERE codUsuario=?";
    var values = [peticion.body.codigo];
    //console.log(values);

    realizarQuery(sql, values, function(data){
         respuesta.send(data);
     });

});



router.post('/actualizarInfo', urlEncodeParser, function(peticion,respuesta){
	var hash = sha512(peticion.body.contrasena);
  	var contrasena = hash.toString('hex');
	//console.log("consiguiendo datos");
	var sql = "UPDATE tblusuarios SET nombres=?, apellidos=?, telefono=?, correo=?, contrasena=? WHERE codUsuario=?";
    var values = [peticion.body.nombre,
				  peticion.body.apellido,
				  peticion.body.telefono,
				  peticion.body.email,
				  contrasena,
				  peticion.body.codigo];
    //console.log(values);
    realizarQuery(sql, values, function(data){
         respuesta.send(data);
     });

});

router.post('/obtenerOrdenes', urlEncodeParser, function(peticion,respuesta){
	
	//console.log("consiguiendo datos");
	var sql = 'SELECT  DATE_FORMAT(A.fecha,"%d/%m/%Y") as fecha, CONCAT(C.nombres," ",C.apellidos) as nombreRepatidor, '+
					  'A.tiempoEstimado, A.cantArticulos, A.costoDeCompra, A.costoDeEntrega, A.costoOrden '+
			   'FROM  tblordenes AS A '+
			   'INNER JOIN tblarticulosordenados AS B '+
			   'ON(A.codUsuarioRepartidor) '+
			   'INNER JOIN tblusuarios AS C '+
			   'ON(A.codUsuarioRepartidor=C.codUsuario) '+
			   'WHERE A.codUsuarioCliente= ? ';
    var values = [peticion.body.codigo];
    
    //console.log(values);
    realizarQuery(sql, values, function(data){
    	//console.log(respuesta);
         respuesta.send(data);
     });

});

router.post('/obtenerFacturas', urlEncodeParser, function(peticion,respuesta){
	
	//console.log("consiguiendo datos");
	var sql = 'SELECT  DATE_FORMAT(A.fecha,"%d/%m/%Y") as fecha ,D.origenFabricacion , '+ 
				'CONCAT(F.nombres," ",F.apellidos) AS nombreRepatidor, '+ 'B.cantArticulos, B.costoDeCompra,B.costoDeEntrega,B.costoOrden '+
				'FROM tblfacturascliente as A '+
				'INNER JOIN tblordenes as B '+
				'ON(A.codOrden=B.codOrden) '+
				'INNER JOIN tblarticulosordenados AS C '+
				'ON(B.codOrden=C.codOrden) '+
				'INNER JOIN tblarticulos AS D '+
				'ON(D.codArticulo=C.codArticulo) '+
				'INNER JOIN tblusuarios AS F '+
				'ON(B.codUsuarioRepartidor=F.codUsuario) '+
				'WHERE B.codUsuarioCliente=?';
    var values = [peticion.body.codigo];
    
    //console.log(values);
    realizarQuery(sql, values, function(data){
    	//console.log(respuesta);
         respuesta.send(data);
     });

});

router.post('/obtenerListaDeseo', urlEncodeParser, function(peticion,respuesta){
	
	//console.log("consiguiendo datos");
	var sql = 'SELECT A.colItem, B.nombreArticulo, B.precio, B.origenFabricacion, B.descripcion '+
				'FROM tbllistadeseos AS A '+
				'INNER JOIN tblarticulos AS B '+
				'ON(A.codArticulo=B.codArticulo) '+
				'WHERE A.codUsuario=?';
    var values = [peticion.body.codigo];
    //console.log(values);
    
    //console.log(values);
    realizarQuery(sql, values, function(data){
    	//console.log(respuesta);
    	//console.log(data);
         respuesta.send(data);
     });

});

router.post('/obtenerEmpresaFavorita', urlEncodeParser, function(peticion,respuesta){
	
	//console.log("consiguiendo datos");
	var sql = 'SELECT A.codItem, B.nombreEmpresa, C.rubro,B.ubicacion, B.calificacion '+
				'FROM  tblempresafavoritas AS A '+
				'INNER JOIN tblempresas AS B '+
				'ON(A.codEmpresa=B.codEmpresa) '+
				'INNER JOIN tblrubro AS C '+
				'ON(B.codRubro=C.codRubro) '+
				'WHERE A.codUsuario=? ';
    var values = [peticion.body.codigo];
    //console.log(values);
    
    //console.log(values);
    realizarQuery(sql, values, function(data){
    	//console.log(respuesta);
    	//console.log(data);
         respuesta.send(data);
     });

});






module.exports=router;
