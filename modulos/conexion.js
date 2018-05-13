var mysql = require('mysql');

var conexion = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "unah_db"
});

conexion.connect(function(err) {
  if (err) throw err;
  console.log("Conexion exitosa");
});

exports.conexion;
/*
 La funcion realizarQuery recibe como parametros una sentencia SQL y un arreglo de argumentos
 Con esta funcion pueden hacerse INSERTS, SELECTS, DELETS, ETC.
 */
exports.realizarQuery = function(sql, arreglo, callback) {
  conexion.query(sql, arreglo, (err, result) => {
    if (err) throw err;
    callback(result);
  });
}


/*
 A esta funcion se le agrego un callback, para poder
 retornar el result (lo que se obtuvo de la consulta)
 con el fin de hacer el JSON stringify
 para enviar la informacion cuando hay un success
 al hacer la peticion AJAX
 */


exports.realizarQrCB = function(sql, arreglo, sql2, arreglo2, callback) {

  conexion.query(sql, arreglo, (err, result) => {
    if (err) {
      throw err;
    } else {
      conexion.query('select codigo_persona from tbl_personas order by codigo_persona desc limit 1', (err, result) => {
        if (err) {
          throw err;
        } else {
          arreglo2.push(result[0].coddigo_persona);
          conexion.query(sql2, arreglo2, (err, result) => {
            callback(result);
          });
        }
      })
    }
  });
}
