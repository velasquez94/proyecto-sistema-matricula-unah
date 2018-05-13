/*
function validar(){
	validarCampoVacio("form-firtsname");
	validarCampoVacio("form-lastname");
	validarCampoVacio("form-email");
}


var validarCampoVacio = function(id){
	if (document.getElementById(id).value == ""){
		document.getElementById(id).classList.remove("is-valid");
		document.getElementById(id).classList.add("is-invalid");
	}
	else{
		document.getElementById(id).classList.remove("is-invalid");
		document.getElementById(id).classList.add("is-valid");
	}
}

function validarContrasena(etiqueta){
	if (etiqueta.value.length <6){
		etiqueta.classList.remove("is-valid");
		etiqueta.classList.add("is-invalid");
	}
	else{
		etiqueta.classList.remove("is-invalid");
		etiqueta.classList.add("is-valid");
	}
}


function validarCorreo(etiquetaEmail) {
    var patron = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if(patron.test(String(etiquetaEmail.value).toLowerCase())){
		etiquetaEmail.classList.remove("is-invalid");
    	etiquetaEmail.classList.add("is-valid");
    }else{
    	etiquetaEmail.classList.remove("is-valid");
    	etiquetaEmail.classList.add("is-invalid");
    }
}


$("#btn-acceder").click(function(){
    $.ajax({
        url:"/login",
        data:"correo_electronico="+$("#email").val()+"&contrasenia="+$("#txtPass").val(),
        method:"POST",
        dataType:"json",
        success:function(respuesta){
            if (respuesta.estatus ==0 )
                window.location.href ="home.html";
            else
                alert("Credenciales incorrectas");
            console.log(respuesta);
        }
    });
});
$("#acceder_docente").click(function(){
	if ($('#codigo').val()!= "" && $('#password').val() != "") {
		login();
	}else
		alert("Ingrese nombre de usuario y contraseña");
		});
function login(){
var parametros ="numero="+$('#codigo').val()
	+"&contrasena="+$('#password').val(); 
    $.ajax({
        url:"/login_empleado",
        data:parametros,
        method:"POST",
        dataType:"json",
        success:function(respuesta){
            if (respuesta.estatus ==0 )
                window.location.href ="home.html";
            else
                alert("Credenciales incorrectas");
            console.log(respuesta);
        }
    });

}


$("#btn-acceder").click(function(){
	if ($('#usuario').val()!= "" && $('#txtPass').val() != "") {
		login();
	}else
		alert("Ingrese nombre de usuario y contraseña");
		});
function login(){
var parametros ="usuario="+$('#usuario').val()
	+"&contrasenia="+$('#txtPass').val(); 
    $.ajax({
        url:"/login_admin",
        data:parametros,
        method:"POST",
        dataType:"json",
        success:function(respuesta){
            if (respuesta.estatus ==0 )
                window.location.href ="home.html";
            else
                alert("Credenciales incorrectas");
            console.log(respuesta);
        }
    });

}
*/

$("#btn-acceder").click(function(){
    $.ajax({
        url:"/login-admin",
        data:"usuario="+$("#usuario").val()+"&contrasenia="+$("#txtPass").val(),
        method:"POST",
        dataType:"json",
        success:function(respuesta){
            if (respuesta.estatus ==0 )
                window.location.href ="home.html";
            else
                alert("Credenciales incorrectas");
            console.log(respuesta);
        }
    });
});

$.ajax({
    url:"/datos-alumno",
    data:"cuenta="+$("#cuenta").val()+"&contrasenia="+$("#Pass").val(),
    method:"POST",
    dataType:"json",
    success:function(respuesta){
   
    }
});