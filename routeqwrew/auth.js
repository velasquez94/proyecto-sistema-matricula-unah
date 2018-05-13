var express = require('express');
var bodyParser = require("body-parser");
var sha512 = require('sha512');


var session = require("express-session");
var cookieParser = require("cookie-parser");

var realizarQuery = require('../modulos/conexion').realizarQuery;

var router = express.Router();

var urlEncodeParser = bodyParser.urlencoded({
  extended: false
});


router.use(bodyParser.json());
router.use(cookieParser());
router.use(session({secret:"ASDFE$%#%",resave:true, saveUninitialized:true}));


function verificarAutenticacion(peticion, respuesta, next){
	if(peticion.session.codigo)
		return next();
	else
		respuesta.send("ERROR, ACCESO NO AUTORIZADO");
}

//var listas = express.static(__dirname+"/public/listas/");
var user = express.static(__dirname+"/public/user/");
var student = express.static(__dirname+"/public/student/");
var teacher = express.static(__dirname+"/public/teacher/");
//var empleado = express.static(__dirname+"/public/empleado/");

/*function verificarListas(peticion,respuesta,next){
if (peticion.session.codigo)
		listas(peticion,respuesta,next);
	else
		return next();
}
*/

function verificarUser(peticion,respuesta,next){
if (peticion.session.codigo)
		user(peticion,respuesta,next);
	else
		return next();
}

function verificarStudent(peticion,respuesta,next){
if (peticion.session.codigo)
		user(peticion,respuesta,next);
	else
		return next();
}

function verificarTeacher(peticion,respuesta,next){
	if (peticion.session.codigo)
		user(peticion,respuesta,next);
		else
			return next();
}
		

router.post('/signin', urlEncodeParser, function(request, response) {
    var hash = sha512(request.body.contrasena);
    var pass = hash.toString('hex');
	var sql = `SELECT codigo_persona as codigo, nombre, apellido,
	fecha_nacimiento, identidad, direccion, telefono, correo_electronico, contrasenia,
	codigo_genero, codigo_estado_civil, codigo_campus,
	codigo_tipo_usuario as tipo FROM tbl_personas WHERE correo_electronico=? and contrasenia=?`;
    var values = [request.body.correo, pass];
    var valores;
    realizarQuery(sql,values, function(res){
        response.send(JSON.stringify(res));
    });
});

router.post("/login", urlEncodeParser, function(peticion, respuesta){

		if(peticion.body.codigo && peticion.body.tipo){
			peticion.session.codigo = peticion.body.codigo;
			peticion.session.tipo = peticion.body.tipo;
            respuesta.cookie("codigo",peticion.body.codigo);
            respuesta.cookie("tipo_acceso",peticion.body.tipo);
			respuesta.send({status:1,mensaje:"Accedio correctamente"});
		}else{
			peticion.session.destroy();
			respuesta.send({status:0,mensaje:"Login fallido"});
		}
		
});

router.get("/logout", function(peticion, respuesta){
        respuesta.clearCookie("codigo");
		respuesta.clearCookie("tipo_acceso");
		peticion.session.destroy();
        respuesta.send({status:1,mensaje:"Sesion eliminada"});
        
});

router.get("/get-session", verificarAutenticacion, function(peticion, respuesta){
	respuesta.send(JSON.stringify(peticion.session));
});

/*
router.get("/rutaSeguraListas",verificarAutenticacion,function(peticion, respuesta, next){
    verificarCatalogo(peticion,respuesta,next);
	respuesta.send({status:1,mensaje:"Bienvenido a la ruta restringida"});
});
*/
router.get("/rutaSeguraUser",verificarAutenticacion,function(peticion, respuesta, next){
    verificarUser(peticion,respuesta,next);
	respuesta.send({status:1,mensaje:"Bienvenido a la ruta restringida"});
});

router.get("/rutaSeguraStudent",verificarAutenticacion,function(peticion, respuesta, next){
    verificarUser(peticion,respuesta,next);
	respuesta.send({status:1,mensaje:"Bienvenido a la ruta restringida"});
});

router.get("/rutaSeguraTeacher",verificarAutenticacion,function(peticion, respuesta, next){
    verificarUser(peticion,respuesta,next);
	respuesta.send({status:1,mensaje:"Bienvenido a la ruta restringida"});
});
/*
router.get("/rutaSeguraEmpleado",verificarAutenticacion,function(peticion, respuesta, next){
    verificarUser(peticion,respuesta,next);
	respuesta.send({status:1,mensaje:"Bienvenido a la ruta restringida"});
});
*/

module.exports = router;