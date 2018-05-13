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
	var sql = "SELECT codigo_persona as codigo, nombre, apellido, fecha_nacimiento, identidad, direccion, telefono, correo_electronico, contrasenia, codigo_genero, codigo_estado_civil, codigo_campus, codigo_tipo_usuario FROM tbl_personas WHERE codigo_persona=?";
    var values = [peticion.body.codigo];
    //console.log(values);

    realizarQuery(sql, values, function(data){
         respuesta.send(data);
     });

});

router.post("/registrarAlumno", urlEncodeParser, function(request, response) {

	var hash = sha512(request.body.txtPassword);
	var contrasena = hash.toString('hex');
	var codTipoUsuario = 1;
	var sql = 'INSERT INTO tbl_personas(nombre, apellido, identidad, correo_electronico, telefono, direccion, '+
	'fecha, cuenta, contrasenia, campus, codigo_genero, codigo_estado_civil, codigo_tipo_usuario) VALUES(?,?,?,?,?,?,sysdate(),?,?,?,?)';
	var values = [request.body.nombre,
	  request.body.apellido,
	  request.body.identidad,
	  request.body.correo,
	  request.body.direccion,
	  request.body.cuenta,
	  contrasena,
	  request.body.campus,
	  codGenero,
	  codEstadoCivil,
	  codTipoUsuario
	];
	realizarQuery(sql,values, function(res){
	  response.send(res);
	});
  });

router.post("/", urlEncodeParser, function(request, response) {
var tipoEmpleado = request.body.selectOfertaLaboral;
var codTipoAspirante;
if(tipoAspirante == 'Agente carry permanente'){codTipoAspirante=1;}
if(tipoAspirante == 'Agente carry recurrente'){codTipoAspirante=2;}
console.log(request.body.txtNames);
var sql = 'INSERT INTO tblaspirantes(codAspirante, nombre, apellido, identificacion, nacimiento, '+
'telefono, correo, domicilio, codTipoAspirante_fk) VALUES (NULL,?,?,?,STR_TO_DATE(?, "%Y-%m-%d"),?,?,?,?)';
var values = [
  request.body.txtNames,
  request.body.txtLastname,
  request.body.txtId,
  request.body.fechaPicker,
  request.body.txtPhone,
  request.body.txtMail,
  request.body.txtDomicilio,
  codTipoAspirante
];
realizarQuery(sql,values, function(res){
  response.send(res);
});

});

router.post('/actualizarInfo', urlEncodeParser, function(peticion,respuesta){
	var hash = sha512(peticion.body.contrasena);
  	var contrasena = hash.toString('hex');
	//console.log("consiguiendo datos");
	var sql = "UPDATE tbl_personas SET nombre=?, apellido=?, identidad=? telefono=?, correo_electronico=?, contrasenia=? WHERE codigo_persona=?";
    var values = [peticion.body.nombre,
				  peticion.body.apellido,
				  peticion.body.identidad,
				  peticion.body.telefono,
				  peticion.body.email,
				  contrasena,
				  peticion.body.codigo];
    //console.log(values);
    realizarQuery(sql, values, function(data){
         respuesta.send(data);
     });

});

router.post('/obtenerEstudiantes', urlEncodeParser, function(peticion,respuesta){
	
	//console.log("consiguiendo datos");
	var sql = 'SELECT b.numero_cuenta a.identidad, a.nombre, a.apellido, a.correo_electronico, a.telefono, fecha_nacimiento, a.campus, '+
			   'FROM  tbl_personas as a '+
			   'INNER JOIN tbl_alumnos as b '+
			   'ON (a.codigo_persona = b.codigo_persona) '+
			   'WHERE codigo_persona= ? ';
    var values = [peticion.body.codigo];
    
    //console.log(values);
    realizarQuery(sql, values, function(data){
    	//console.log(respuesta);
         respuesta.send(data);
     });

});

router.post('/obtenerDocentes', urlEncodeParser, function(peticion,respuesta){
	
	//console.log("consiguiendo datos");
	var sql = 'SELECT b.numero_empleado a.identidad, a.nombre, a.apellido, a.correo_electronico, a.telefono, fecha_nacimiento, a.campus, c.cogigo_titularidad, '+
			   'FROM  tbl_personas as a '+
			   'INNER JOIN tbl_empleados as b '+
			   'ON (a.codigo_persona = b.codigo_persona) '+
			   'INNER JOIN tbl_maestros as c '+
			   'ON (b.codigo_empleado = c.codigo_empleado) '+
			   'WHERE codigo_empleado= ? '
			   'WHERE codigo_persona= ? ';
	var values = [peticion.body.codigoEmp,
		peticion.body.codigoPer];
    
    //console.log(values);
    realizarQuery(sql, values, function(data){
    	//console.log(respuesta);
         respuesta.send(data);
     });

});

/*

router.post('/obtenerSecciones', urlEncodeParser, function(peticion,respuesta){
	
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

*/




module.exports=router;
