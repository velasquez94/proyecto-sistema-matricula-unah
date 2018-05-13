var express = require("express");
var session = require("express-session");
var bodyParser = require("body-parser");
var mysql = require("mysql");
var app = express();
var credenciales ={
  user:"root",
  password:"",
  database:"unah_db",
  host:"localhost",
  port:"3306"  
};

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

app.use(express.static("public"));
app.use(session({secret:"ASDFE$%#%",resave:true, saveUninitialized:true}));

//Verificar si existe una variable de sesion para poner publica la carpeta public admin
var publicAdmin = express.static("public-admin");
var publicEstudiante = express.static("public-estudiante");
var publicDocente = express.static("public-docente");
var publicEmpleado = express.static("public-empleado");
app.use(
    function(peticion,respuesta,next){
        if (peticion.session.numero){
            if (peticion.session.codigo_tipo_usuario == 1)
            publicAdmin(peticion,respuesta,next);  
            else if (peticion.session.codigo_tipo_usuario == 2)
            publicEstudiante(peticion,respuesta,next);
            else if (peticion.session.codigo_tipo_usuario == 3)
            publicDocente(peticion,respuesta,next);
            else if (peticion.session.codigo_tipo_usuario == 4)
            publicEmpleado(peticion,respuesta,next);
        }
        else
            return next();
    }
);

///Para agregar seguridad a una ruta especifica:
function verificarAutenticacion(peticion, respuesta, next){
	if(peticion.session.usuario)
		return next();
	else
		respuesta.send("ERROR, ACCESO NO AUTORIZADO");
}

function verificarAutenticacion(peticion, respuesta, next){
	if(peticion.session.numero)
		return next();
	else
		respuesta.send("ERROR, ACCESO NO AUTORIZADO");
}

function verificarAutenticacion(peticion, respuesta, next){
	if(peticion.session.cuenta)
		return next();
	else
		respuesta.send("ERROR, ACCESO NO AUTORIZADO");
}
app.post("/login-admin", function(peticion, respuesta){
    var conexion = mysql.createConnection(credenciales);
    conexion.query('SELECT codigo_admin, usuario, contrasenia, '+
    'codigo_tipo_usuario FROM tbl_admin  WHERE usuario=? and contrasenia=sha1(?)',
        [peticion.body.usuario, peticion.body.contrasenia],
        function(err, data, fields){
            if(err) throw err;
                if (data.length>0){
                    peticion.session.usuario = data[0].usuario;
                    peticion.session.codigo_tipo_usuario = data[0].codigo_tipo_usuario;
                    data[0].estatus = 0;
                    respuesta.send(data[0]); 
                }else{
                    respuesta.send({estatus:1, mensaje: "Login fallido"}); 
                }
            	
         }
    ); 
});

app.post("/login-empleado", function(peticion, respuesta){
    var conexion = mysql.createConnection(credenciales);
    conexion.query('SELECT codigo_empleado, numero_empleado, codigo_tipo_usuario, '+  
    'contrasenia, FROM tbl_empleados  WHERE numero_empleado=? and contrasenia=sha1(?)',
        [peticion.body.numero, peticion.body.contrasena],
        function(err, data, fields){
                if (data.length>0){
                    peticion.session.numero = data[0].numero_empleado;
                    peticion.session.codigo_tipo_usuario = data[0].codigo_tipo_usuario;
                    data[0].estatus = 0;
                    respuesta.send(data[0]); 
                }else{
                    respuesta.send({estatus:1, mensaje: "Login fallido"}); 
                }
            	
         }
    ); 
});
app.post("/login-alumno", function(peticion, respuesta){
    var conexion = mysql.createConnection(credenciales);
    conexion.query('SELECT codigo_estudiante, numero_cuenta, '+
    'codigo_tipo_usuario,  contrasenia, '+
    'FROM tbl_alumnos  WHERE numero_cuenta=? and contrasenia=sha1(?)',
        [peticion.body.cuenta, peticion.body.contrasenia],
        function(err, data, fields){
                if (data.length>0){
                    peticion.session.cuenta = data[0].cuenta;
                    peticion.session.codigo_usaurio = data[0].codigo_tipo_usuario;
                    data[0].estatus = 0;
                    respuesta.send(data[0]); 
                }else{
                    respuesta.send({estatus:1, mensaje: "Login fallido"}); 
                }
            	
         }
    ); 
});



app.get("/obtener-sesion", function(peticion, respuesta){
   respuesta.send("Valor de la variable de sesion almacenado: " + peticion.session.usuario);
});
/*


router.get("/logout", function(peticion, respuesta){
    respuesta.clearCookie("codigo");
    respuesta.clearCookie("tipo_acceso");
    peticion.session.destroy();
    respuesta.send({status:1,mensaje:"Sesion eliminada"});
    
});
*/
app.get("/ruta-restringida",verificarAutenticacion,  function(peticion, respuesta){
    respuesta.send("Bienvenido a la ruta restringida");
});


app.post('/obtenerEstudiantes', function(peticion,respuesta){
	
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

app.post('/obtenerDocentes', function(peticion,respuesta){
	
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

app.post("/registrarAlumno", function(peticion,respuesta){

	var hash = sha512(peticion.body.txtPassword);
	var contrasena = hash.toString('hex');
	var codTipoUsuario = 1;
	var sql = 'INSERT INTO tbl_personas(nombre, apellido, identidad, correo_electronico, telefono, direccion, '+
	'fecha, cuenta, contrasenia, campus, codigo_genero, codigo_estado_civil, codigo_tipo_usuario) VALUES(?,?,?,?,?,?,sysdate(),?,?,?,?)';
	var values = [request.body.nombre,
	  peticion.body.apellido,
	  peticion.body.identidad,
	  peticion.body.correo,
	  peticion.body.direccion,
	  peticion.body.cuenta,
	  contrasena,
	  peticion.body.campus,
	  codGenero,
	  codEstadoCivil,
	  codTipoUsuario
	];
	realizarQuery(sql,values, function(res){
	  respuesta.send(res);
	});
  });
  
app.get("/datos-alumnos",function(peticion,respuesta){
    var conexion=mysql.createConnection(servidor);
    conexion.query(
        'SELECT b.nombre,b.apellido,a.numero_cuenta,a.promedio,c.nombre_carrera,e.nombre_campus,YEAR(sysdate()) as año '+
        'FROM tbl_alumnos a '+
        'INNER JOIN tbl_personas b ON a.codigo_persona=c.codigo_alumno '+
        'INNER JOIN tbl_carreras_x_alumno d ON a.codigo_alumno=d.codigo_alumno '+
        'INNER JOIN tbl_carreras car ON c.codigo_carrera=d.codigo_carrera '+
        'INNER JOIN tbl_campus e ON c.codigo_campus=e.codigo_campus '+
        'WHERE b.codigo_persona=?',[2],
        function(errorSelect,informacion){
            if (errorSelect) throw errorSelect;
            conexion.end();
            respuesta.send(informacion);
        }
    );
});



app.get("/historial-academico",function(peticion,respuesta){
    var conexion=mysql.createConnection(servidor);
    conexion.query(
        'SELECT a.codigo_alterno,a.nombre_asignatura,a.cantidad_unidades_valorativas, b.codigo_alterno as seccion,YEAR(p.fecha_inicio), c.nombre_periodo, f.valor_nota,'+
        'd.nombre_tipo_evaluacion,e.codigo_alumno '+
        'FROM tbl_historial e '+
        'INNER JOIN tbl_detalle_evaluacion f ON f.codigo_historial=e.codigo_historial '+
        'INNER JOIN tbl_tipos_evaluaciones g ON g.codigo_tipo_evaluacion=f.codigo_tipo_evaluacion '+
        'INNER JOIN tbl_seccion b ON b.codigo_seccion=b.codigo_seccion '+
        'INNER JOIN tbl_periodos c ON c.codigo_periodo=b.codigo_periodo '+
        'INNER JOIN tbl_asignaturas a ON a.codigo_asignatura=s.codigo_asignatura '+
        'WHERE e.codigo_alumno=?',[2],
        function(error,data){
            if(error) throw error;
			conexion.end();
			respuesta.send(data);
        }
    );
});

app.get("/requisito-asignaturas",function(peticion,respuesta){
    var conexion=mysql.createConnection(servidor);
    var conexion2=mysql.createConnection(servidor);
    var asignaturas=[];
    var sql='SELECT a.codigo_asignatura,a.nombre_asignatura,a.codigo_alterno,a.dias, a.cantidad_unidades_valorativas,b.nombre_carrera,c.tipo_asignatura,b.codigo_carrera '+
            'FROM  tbl_planes_de_estudios d '+
            'INNER JOIN tbl_asignaturas a ON a.codigo_asignatura=d.codigo_asignatura '+
            'INNER JOIN tbl_carreras b ON b.codigo_carrera=d.codigo_carrera '+
            'INNER JOIN tbl_tipo_asignatura c ON c.codigo_tipo_asignatura=a.codigo_tipo_asignatura '+
            "WHERE d.codigo_carrera=?";
    conexion.query(sql,[1]).on('result',function(peticion,respuesta){
    asignatura.requisitos=[];
    asignaturas.push(asignatura);
    conexion.pause();
    conexion2.query(
        'SELECT a.nombre_asignatura,a.codigo_alterno,a.cantidad_unidades_valorativas,a.dias,e.codigo_carrera '+
        'FROM tbl_requisitos e '+
        'INNER JOIN tbl_planes_de_estudios d ON d.codigo_asignatura=e.codigo_asignatura '+
        'INNER JOIN tbl_asignaturas a ON a.codigo_asignatura=e.codigo_asignatura_requisito '+
        'WHERE d.codigo_carrera=? AND e.codigo_carrera=? AND e.codigo_asignatura=?',[1,1,asignatura.codigo_asignatura]).on('result',function(requisito){ asignatura.requisitos.push(requisito);
                    })
                .on('end',function(){
                    conexion.resume();
                });
            })
            .on('end',function(){
                conexion.end();
                conexion2.end();
                respuesta.send(asignaturas);
            });
});

app.post("/secciones",function(peticion,respuesta){
    var conexion=mysql.createConnection(servidor);
    conexion.query(
        'SELECT a.codigo_alterno, a.codigo_seccion, a.dias, a.cantidad_cupos, b.codigo_asignatura, b.nombre_asignatura,c.fecha_inicio, c.fecha_fin '+
        'FROM tbl_seccion a '+
        'INNER JOIN tbl_asignaturas b ON b.codigo_asignatura=c.codigo_asignatura '+
        'INNER JOIN tbl_periodos c ON c.codigo_periodo=a.codigo_periodo '+
        'WHERE (sysdate() BETWEEN c.fecha_inicio AND c.fecha_fin) '+
        'AND b.codigo_asignatura=?',
        [peticion.body.codigo],
        function(error,data){
            if(error) throw error;
			conexion.end();
			respuesta.send(data);
        });
});

app.post("/adicionar-asignatura",function(peticion,respuesta){
    var conexion=mysql.createConnection(servidor);
    var estado=0;
    conexion.query(
        'SELECT a.codigo_alterno, a.codigo_seccion, a.dias, a.cantidad_cupos, b.codigo_asignatura, b.nombre_asignatura '+
        'FROM tbl_seccion a '+
        'INNER JOIN tbl_asignaturas b ON b.codigo_asignatura=b.codigo_asignatura '+
        "WHERE b.codigo_seccion=?",
        [peticion.body.codigo],function(error,data){
            if(data[0].cantidad_cupos>0){
                estado=1;
            }else{
                estado=2;
            }
    conexion.query(
    'INSERT INTO tbl_matricula(fecha_matricula, codigo_alumno, codigo_estado_matricula, codigo_seccion, codigo_matricula) '+
    'VALUES (sysdate(),?,?,?,NULL)',
        [2,estado,peticion.body.codigo,],
        function(errorInsert,info){
            if(info.affectedRows==1){conexion.query(
    'UPDATE tbl_seccion '+
    'SET cantidad_cupos = cantidad_cupos-1 '+
    'WHERE tbl_seccion.codigo_seccion = ?',
    [peticion.body.codigo], function(errorUpdate,datos){
    conexion.query(
    'SELECT c.codigo_matricula, c.codigo_estado_matricula, c.codigo_alumno, a.codigo_seccion, a.codigo_alterno, a.hora_inicio, a.hora_fin,'+
    'a.dias, b.nombre_asignatura, b.codigo_alterno, b.cantidad_unidades_valorativas, b.codigo_asignatura, c.nombre_periodo, d.nombre_aula, e.nombre_edificio '+
    'FROM tbl_matricula c '+
    'INNER JOIN tbl_seccion a ON a.codigo_seccion=c.codigo_seccion '+
    'INNER JOIN tbl_asignaturas b ON b.codigo_asignatura=a.codigo_asignatura '+
    'INNER JOIN tbl_periodos c ON c.codigo_periodo=a.codigo_periodo '+
    'INNER JOIN tbl_aulas e ON e.codigo_aula=d.codigo_aula '+
    'INNER JOIN tbl_edificios e ON e.codigo_edificio=d.codigo_edificio '+
    'WHERE c.codigo_matricula=?'
    ,[info.insertId],
    function(errorSelect,informacion){
    if (errorSelect) throw errorSelect;
    conexion.end();
    respuesta.send(informacion);
    });
 });
}
});
});
    
});

app.post("/cancelar-clase",function(peticion,respuesta){
    var conexion=mysql.createConnection(servidor);
    conexion.query(
    'DELETE FROM tbl_matricula '+
    'WHERE tbl_matricula.codigo_matricula = ?',
    [peticion.body.codigo],
    function(error,data){
    if(data.affectedRows==1){
    conexion.query(
    'UPDATE tbl_seccion '+
    'SET cantidad_cupos = cantidad_cupos+1 '+
    'WHERE tbl_seccion.codigo_seccion = ?',
    [peticion.body.seccion],
    function(errorUpdate,datos){
    conexion.query(
    'SELECT a.codigo_matricula, a.codigo_estado_matricula, a.codigo_alumno, b.codigo_alterno, b.hora_inicio, b.hora_fin,'+
    'b.dias, c.nombre_asignatura, c.codigo_alterno, c.cantidad_unidades_valorativas, b.codigo_seccion, d.nombre_periodo, e.nombre_aula, d.nombre_edificio '+
    'FROM tbl_matricula a '+
    'INNER JOIN tbl_seccion b ON b.codigo_seccion=b.codigo_seccion '+
    'INNER JOIN tbl_asignaturas c ON c.codigo_asignatura=b.codigo_asignatura '+
    'NNER JOIN tbl_periodos d ON d.codigo_periodo=b.codigo_periodo '+
    'INNER JOIN tbl_aulas e ON e.codigo_aula=b.codigo_aula '+
    'INNER JOIN tbl_edificios d ON d.codigo_edificio=e.codigo_edificio '+
    'WHERE a.codigo_alumno=?',[2],
    function(errorSelect,informacion){
    if (errorSelect) throw errorSelect;
    conexion.end();
    respuesta.send(informacion);
    });
});
}
});
});

app.listen(3000);
console.log("Conexion exitosa");