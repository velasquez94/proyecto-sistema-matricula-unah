/*
 * En este archivo utilizamos sha512 que nos servira para encriptar las
 * contraseñas antes de almacenarlas.
 */
var express = require('express');
var bodyParser = require("body-parser");
var sha512 = require('sha512');

var realizarQuery = require('../modulos/conexion').realizarQuery;
var realizarQrCB = require('../modulos/conexion').realizarQrCB;


//var async = require('async');
/*
 * Importamos la funcion realizarQuery para facilitar la insercion de informacion
 * en la base de datos
 */
/*
 * Creamos una funcion router que exportaremos luego que nos permitira importarla
 * en otros archivos.
 */
var router = express.Router();
var urlEncodeParser = bodyParser.urlencoded({
  extended: false
});

router.use(bodyParser.json());

router.post("/user", urlEncodeParser, function(request, response) {

  /* AQUI SE COMIENZA A REGISTRAR LA EMPRESA EN LA BASE DE DATOS
   * NO ESTOY SEGURO SI SE PUEDEN HACER VARIAS CONSULTAS EN UN MISMO METODO POST
   * NO HE PODIDO PROBAR PORQUE LAS VALIDACIONES DE LOS FORMULARIOS NO ME DEJAN
   * SI PUEDEN PROBARLO SERIA BUENO
   */
  var hash = sha512(request.body.txtPassword);
  var contrasena = hash.toString('hex');
  var codTipoUsuario = 3;
  var rubro = request.body.selectRubro;
  var idRubro;
  var sql = "INSERT INTO tblusuarios(nombres,apellidos,telefono,correo,contrasena,codTipoUsuario) VALUES(?,?,?,?,?,?)";
  var values = [request.body.txtNames,
    request.body.txtLastname,
    request.body.txtPhoneUser,
    request.body.txtEmail,
    contrasena,
    codTipoUsuario
  ];

  switch (rubro) {
    case 'Agricultura y ganadería':
      idRubro = 1;
      break;
    case 'Alimentos y bebidas':
      idRubro = 2;
      break;
    case 'Alquileres':
      idRubro = 3;
      break;
    case 'Art. limpieza e higiene':
      idRubro = 4;
      break;
    case 'Artículos del hogar':
      idRubro = 5;
      break;
    case 'Audiovisuales':
      idRubro = 6;
      break;
    case 'Automotores':
      idRubro = 7;
      break;
    case 'Combustibles y lubricantes':
      idRubro = 8;
      break;
    case 'Deporte y recreación':
      idRubro = 9;
      break;
    case 'Equipo médico y laboratorio':
      idRubro = 10;
      break;
    case 'Construcción y edificación':
      idRubro = 11;
      break;
    case 'Suministros de oficina':
      idRubro = 12;
      break;
    case 'Equipos de seguridad':
      idRubro = 13;
      break;
    case 'Herramientas':
      idRubro = 14;
      break;
    case 'Equipos e insumos de Informática':
      idRubro = 15;
      break;
    case 'Joyería y orfebrería':
      idRubro = 16;
      break;
    case 'Maquinarias':
      idRubro = 17;
      break;
    case 'Publicidad':
      idRubro = 18;
      break;
    case 'Servicio de salud':
      idRubro = 19;
      break
    case 'Vigilancia y seguridad':
      idRubro = 20;
      break;
    case 'Textil e indumentaria':
      idRubro = 21;
      break;
    case 'Telefonía y comunicaciones':
      idRubro = 22;
      break;
    case 'Compra y venta':
      idRubro = 23;
      break;
    case 'Panadería':
      idRubro = 24;
      break;
    case 'Articulos de belleza':
      idRubro = 25;
      break;
    default:
      idRubro = 1;
  }

  var sql2 = "INSERT INTO tblempresas(codEmpresa, rtn, nombreEmpresa, ubicacion, actividad, sitioweb, telefono, informacion, calificacion, activa, codRubro, mapslatitud, mapslongitud, mapsregion, mapsciudad, mapsdeparamento, mapspais, codUsuario) VALUES (NULL,?,?,?,?,?,?,?,NULL,NULL,?,?,?,?,?,?,?,?)";

  var values2 = [request.body.txtRTN,
    request.body.txtEmpresa,
    request.body.txtDomicilio,
    request.body.selectRubro,
    request.body.txtWebsite,
    request.body.txtPhone,
    request.body.txtDescripcion,
    idRubro,
    request.body.latitud,
    request.body.longitud,
    request.body.region,
    request.body.ciudad,
    request.body.departamento,
    request.body.pais
  ];

  realizarQrCB(sql, values, sql2, values2, function(res) {
    response.send(res);
  });

  //realizarQrCB(sql, values);
  //Utilizamos la funcion realizarQuery que importamos, recibe como parametros
  //una sentencia sql y un arreglo con los parametros ? de la sentencia misma.
  //var result = realizarQuery(sql, values);
  //console.log(JSON.stringify(result));
  //  response.send(result);
  //var sql2 = "SELECT codUsuario FROM tblusuarios WHERE correo=?";
  //var values2 = [request.body.txtEmail];
  //funcion de callback
  //mas abajo se envia esta funcion como parametro a la funcion realizarQrCB
  //Para saber mas de su funcionamiento ver en ./modulos/conexion.js
  //var handleResult = function (err, result) {
  //  if (err) {
  //    console.error(err.stack || err.message);
  //return;
  //}
  //En esta seccion se manipulan los datos obtenidos de la consulta
  //y se envian con el response
  //};
  //realizarQrCB(sql2, values2, handleResult);
});

//router.post("/empresa", urlEncodeParser, function(resquest, response) {

/*
  //Utilizamos esta funcion "obtenerDatos" para que la funcion "realizarQrCB"
//nos pueda retornar el resultado de la query
var obtenerDatos = function(query, val, callback){
    realizarQrCB(query, val, function(data){
        callback(data);
    });
  };

var sql2 = "SELECT codUsuario FROM tblusuarios WHERE correo=?";
var values2 = [request.body.txtEmail];
var respuesta2;
obtenerDatos(sql2, values2, function(data){
    respuesta2=data;
});

var consulta = JSON.stringify(respuesta2);
  console.log("consulta= "+consulta);
var codigo;
for(var i=0;i<consulta.length;i++){
    if(consulta.affectedRows == 1){
      codigo = consulta[i].codUsuario;
    }else{
          console.log("falla");
    }
}

var rubro = request.body.selectRubro;
var codRubro;
if(rubro == 'Compra y venta'){codRubro=1;}
if(rubro == 'Panadería'){codRubro=2;}
if(rubro == 'Articulos de belleza'){codRubro=3;}
var sql3 = "INSERT INTO tblempresas(codEmpresa, rtn, nombreEmpresa, ubicacion, actividad, sitioweb, telefono, informacion, calificacion, activa, codUsuario, codRubro, mapslatitud, mapslongitud, mapsregion, mapsciudad, mapsdeparamento, mapspais) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
var values3 = ['',
    request.body.txtRTN,
    request.body.txtEmpresa,
    request.body.txtDomicilio,
    rubro,
    request.body.txtWebsite,
    request.body.txtPhone,
    request.body.txtDescripcion,
    5,
    1,
    codigo,
    codRubro,
    14.077739,
    -87.200250,
    'Callejon Galeras',
    'Tegucigalpa',
    'Francisco Morazan',
    'Honduras'
  ];

var respuesta3;
obtenerDatos(sql3, values3, function(data){
    respuesta3=data;
});

response.send(JSON.stringify(respuesta3));
 */
//});

module.exports = router;


/*
 *
 *var getOffers = function (email, callback) {
 *    var branchObj = require('./file2.js');
 *    branchObj.getUserBranch(email, function(data){
 *        This data stack 2
 *        callback(data);
 *    });
 *           };
 *
 *       var respuesta = function(callback){
 *      realizarQuery(sql, values, function(data){
 *          callback(data);
 *      });
 *    }
 *  response.send(JSON.stringify(respuesta));
 */
