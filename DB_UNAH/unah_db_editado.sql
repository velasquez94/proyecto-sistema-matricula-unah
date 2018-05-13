-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 13-05-2018 a las 04:50:42
-- Versión del servidor: 5.7.19
-- Versión de PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `unah_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_admin`
--

DROP TABLE IF EXISTS `tbl_admin`;
CREATE TABLE IF NOT EXISTS `tbl_admin` (
  `codigo_admin` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) NOT NULL,
  `contrasenia` varchar(45) NOT NULL,
  `codigo_tipo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_admin`),
  KEY `fk_tbl_admin_tbl_tipos_usuarios1_idx` (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_admin`
--

INSERT INTO `tbl_admin` (`codigo_admin`, `usuario`, `contrasenia`, `codigo_tipo_usuario`) VALUES
(1, 'admin1', 'asd12345', 1),
(2, 'admin2', 'asd123456', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_alumnos`
--

DROP TABLE IF EXISTS `tbl_alumnos`;
CREATE TABLE IF NOT EXISTS `tbl_alumnos` (
  `codigo_alumno` int(11) NOT NULL AUTO_INCREMENT,
  `numero_cuenta` varchar(11) NOT NULL,
  `promedio` int(11) DEFAULT NULL,
  `codigo_persona` int(11) NOT NULL,
  `codigo_tipo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_alumno`),
  KEY `fk_tbl_alumnos_tbl_personas1_idx` (`codigo_persona`),
  KEY `fk_tbl_alumnos_tbl_tipos_usuarios1_idx` (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_alumnos`
--

INSERT INTO `tbl_alumnos` (`codigo_alumno`, `numero_cuenta`, `promedio`, `codigo_persona`, `codigo_tipo_usuario`) VALUES
(1, '20121002409', 80, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_areas`
--

DROP TABLE IF EXISTS `tbl_areas`;
CREATE TABLE IF NOT EXISTS `tbl_areas` (
  `codigo_area` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_area` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codigo_area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_area_especializaciones`
--

DROP TABLE IF EXISTS `tbl_area_especializaciones`;
CREATE TABLE IF NOT EXISTS `tbl_area_especializaciones` (
  `codigo_especializacion` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_especializacion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_area_especializaciones`
--

INSERT INTO `tbl_area_especializaciones` (`codigo_especializacion`, `descripcion`) VALUES
(1, 'especialización en programación '),
(2, 'especialización en matemáticas ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asignaturas`
--

DROP TABLE IF EXISTS `tbl_asignaturas`;
CREATE TABLE IF NOT EXISTS `tbl_asignaturas` (
  `codigo_asignatura` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_alterno` varchar(200) NOT NULL,
  `nombre_asignatura` varchar(200) NOT NULL,
  `cantidad_u_v` int(11) NOT NULL,
  `dias` varchar(100) NOT NULL,
  `codigo_carrera` int(11) NOT NULL,
  `codigo_tipo_asignatura` int(11) NOT NULL,
  PRIMARY KEY (`codigo_asignatura`),
  KEY `fk_tbl_asignaturas_tbl_carreras_idx` (`codigo_carrera`),
  KEY `fk_tbl_asignaturas_tbl_tipo_asignatura1_idx` (`codigo_tipo_asignatura`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_asignaturas`
--

INSERT INTO `tbl_asignaturas` (`codigo_asignatura`, `codigo_alterno`, `nombre_asignatura`, `cantidad_u_v`, `dias`, `codigo_carrera`, `codigo_tipo_asignatura`) VALUES
(1, 'IS-410', 'Programación orientada a objetos ', 5, 'lunes, martes, miércoles, jueves y viernes', 0, 0),
(2, 'MM-111', 'Geometría y trigonométrica', 5, 'lunes, martes, miércoles, jueves y viernes', 0, 0),
(3, 'IS-310', 'Algoritmos y estructura de datos ', 4, 'lu, ma, mi, ju', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aulas`
--

DROP TABLE IF EXISTS `tbl_aulas`;
CREATE TABLE IF NOT EXISTS `tbl_aulas` (
  `codigo_aula` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_aula` varchar(100) NOT NULL,
  `codigo_edificio` int(11) NOT NULL,
  `codigo_tipo_aula` int(11) NOT NULL,
  PRIMARY KEY (`codigo_aula`),
  KEY `fk_tbl_aulas_tbl_edificios1_idx` (`codigo_edificio`),
  KEY `fk_tbl_aulas_tbl_tipos_aulas1_idx` (`codigo_tipo_aula`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_aulas`
--

INSERT INTO `tbl_aulas` (`codigo_aula`, `nombre_aula`, `codigo_edificio`, `codigo_tipo_aula`) VALUES
(1, 'Aula 100', 0, 0),
(2, 'Aula 200', 0, 0),
(3, 'Aula 300', 0, 0),
(4, 'Aula 202', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_campus`
--

DROP TABLE IF EXISTS `tbl_campus`;
CREATE TABLE IF NOT EXISTS `tbl_campus` (
  `codigo_campus` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_campus` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_campus`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_campus`
--

INSERT INTO `tbl_campus` (`codigo_campus`, `nombre_campus`) VALUES
(1, 'Ciudad Universitaria'),
(2, 'Ciudad universitaria, Valle de Sula ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cargos`
--

DROP TABLE IF EXISTS `tbl_cargos`;
CREATE TABLE IF NOT EXISTS `tbl_cargos` (
  `codigo_cargo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cargo` varchar(200) DEFAULT NULL,
  `codigo_cargo_superior` int(11) NOT NULL,
  PRIMARY KEY (`codigo_cargo`),
  KEY `fk_tbl_cargos_tbl_cargos1_idx` (`codigo_cargo_superior`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_cargos`
--

INSERT INTO `tbl_cargos` (`codigo_cargo`, `nombre_cargo`, `codigo_cargo_superior`) VALUES
(1, 'Decano', 0),
(2, 'coordinador carrera', 0),
(3, 'jefe de departamento', 0),
(4, 'docente ', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_carreras`
--

DROP TABLE IF EXISTS `tbl_carreras`;
CREATE TABLE IF NOT EXISTS `tbl_carreras` (
  `codigo_carrera` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_auxiliar` varchar(200) NOT NULL,
  `nombre_carrera` varchar(200) NOT NULL,
  `cantidad_asignaturas` int(11) NOT NULL,
  `cantidad_u_v` int(11) NOT NULL,
  `codigo_facultad` int(11) NOT NULL,
  `codigo_grado` int(11) NOT NULL,
  PRIMARY KEY (`codigo_carrera`),
  KEY `fk_tbl_carreras_tbl_facultades1_idx` (`codigo_facultad`),
  KEY `fk_tbl_carreras_tbl_grados1_idx` (`codigo_grado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_carreras`
--

INSERT INTO `tbl_carreras` (`codigo_carrera`, `codigo_auxiliar`, `nombre_carrera`, `cantidad_asignaturas`, `cantidad_u_v`, `codigo_facultad`, `codigo_grado`) VALUES
(1, 'IS', 'Ingeniería en sistemas ', 56, 224, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_carreras_x_alumnos`
--

DROP TABLE IF EXISTS `tbl_carreras_x_alumnos`;
CREATE TABLE IF NOT EXISTS `tbl_carreras_x_alumnos` (
  `fecha_registro_carrera` date NOT NULL,
  `promedio_carrera` int(11) NOT NULL,
  `cantidad_clases_aprobadas` int(11) NOT NULL,
  `codigo_carrera` int(11) NOT NULL,
  `codigo_alumno` int(11) NOT NULL,
  PRIMARY KEY (`codigo_carrera`,`codigo_alumno`),
  KEY `fk_tbl_carreras_x_alumnos_tbl_carreras1_idx` (`codigo_carrera`),
  KEY `fk_tbl_carreras_x_alumnos_tbl_alumnos1_idx` (`codigo_alumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detalle_evaluacion`
--

DROP TABLE IF EXISTS `tbl_detalle_evaluacion`;
CREATE TABLE IF NOT EXISTS `tbl_detalle_evaluacion` (
  `valor_nota` int(11) NOT NULL,
  `codigo_historial` int(11) NOT NULL,
  `codigo_tipo_evaluacion` int(11) NOT NULL,
  KEY `fk_tbl_detalle_evaluacion_tbl_historial1_idx` (`codigo_historial`),
  KEY `fk_tbl_detalle_evaluacion_tbl_tipos_evaluaciones1_idx` (`codigo_tipo_evaluacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_edificios`
--

DROP TABLE IF EXISTS `tbl_edificios`;
CREATE TABLE IF NOT EXISTS `tbl_edificios` (
  `codigo_edificio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_edificio` varchar(200) NOT NULL,
  `alias_edificio` varchar(200) NOT NULL,
  `codigo_campus` int(11) NOT NULL,
  PRIMARY KEY (`codigo_edificio`),
  KEY `fk_tbl_edificios_tbl_campus1_idx` (`codigo_campus`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_edificios`
--

INSERT INTO `tbl_edificios` (`codigo_edificio`, `nombre_edificio`, `alias_edificio`, `codigo_campus`) VALUES
(1, 'B2', 'ingeniería ', 0),
(2, 'C2', 'economia', 0),
(3, 'J1', '', 0),
(4, 'D1', 'gemelo', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_empleados`
--

DROP TABLE IF EXISTS `tbl_empleados`;
CREATE TABLE IF NOT EXISTS `tbl_empleados` (
  `codigo_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `numero_empleado` int(11) NOT NULL,
  `sueldo_base` float NOT NULL,
  `codigo_persona` int(11) NOT NULL,
  `codigo_tipo_empleado` int(11) NOT NULL,
  `codigo_cargo` int(11) NOT NULL,
  `codigo_tipo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_empleado`,`codigo_persona`),
  KEY `fk_tbl_empleados_tbl_personas1_idx` (`codigo_persona`),
  KEY `fk_tbl_empleados_tbl_tipo_empleado1_idx` (`codigo_tipo_empleado`),
  KEY `fk_tbl_empleados_tbl_cargos1_idx` (`codigo_cargo`),
  KEY `fk_tbl_empleados_tbl_tipos_usuarios1_idx` (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_empleados`
--

INSERT INTO `tbl_empleados` (`codigo_empleado`, `numero_empleado`, `sueldo_base`, `codigo_persona`, `codigo_tipo_empleado`, `codigo_cargo`, `codigo_tipo_usuario`) VALUES
(1, 100, 30000, 3, 1, 3, 4),
(2, 101, 25000, 0, 0, 0, 0),
(4, 102, 20000, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_estados_civiles`
--

DROP TABLE IF EXISTS `tbl_estados_civiles`;
CREATE TABLE IF NOT EXISTS `tbl_estados_civiles` (
  `codigo_estado_civil` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado_civil` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_estado_civil`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_estados_civiles`
--

INSERT INTO `tbl_estados_civiles` (`codigo_estado_civil`, `nombre_estado_civil`) VALUES
(1, 'soltero'),
(2, 'casado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_estados_matricula`
--

DROP TABLE IF EXISTS `tbl_estados_matricula`;
CREATE TABLE IF NOT EXISTS `tbl_estados_matricula` (
  `codigo_estado_matricula` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(200) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codigo_estado_matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_estados_matricula`
--

INSERT INTO `tbl_estados_matricula` (`codigo_estado_matricula`, `nombre_estado`, `descripcion`) VALUES
(1, 'matriculada', 'la clase se encuentra matriculada'),
(2, 'en espera', 'la clase se encuentra en espera de un cupo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_facultades`
--

DROP TABLE IF EXISTS `tbl_facultades`;
CREATE TABLE IF NOT EXISTS `tbl_facultades` (
  `codigo_facultad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_facultad` varchar(200) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_facultad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_facultades`
--

INSERT INTO `tbl_facultades` (`codigo_facultad`, `nombre_facultad`, `descripcion`) VALUES
(1, 'Ingeniería ', 'facultad donde se imparten todas las clases de ingeniería '),
(2, 'Ciencias económicas ', 'Facultad donde se imparten todas las clases de ciencias económicas '),
(3, 'Ciencias', 'facultad donde se imparten todas las clases de ciencias ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_generos`
--

DROP TABLE IF EXISTS `tbl_generos`;
CREATE TABLE IF NOT EXISTS `tbl_generos` (
  `codigo_genero` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_genero` varchar(60) NOT NULL,
  `abreviatura` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`codigo_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_generos`
--

INSERT INTO `tbl_generos` (`codigo_genero`, `nombre_genero`, `abreviatura`) VALUES
(1, 'masculino', 'm'),
(2, 'femenino', 'f');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_grados`
--

DROP TABLE IF EXISTS `tbl_grados`;
CREATE TABLE IF NOT EXISTS `tbl_grados` (
  `codigo_grado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_grado` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_grado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_grados`
--

INSERT INTO `tbl_grados` (`codigo_grado`, `nombre_grado`) VALUES
(1, 'pre-grado '),
(2, 'post-grado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_historial`
--

DROP TABLE IF EXISTS `tbl_historial`;
CREATE TABLE IF NOT EXISTS `tbl_historial` (
  `codigo_historial` int(11) NOT NULL AUTO_INCREMENT,
  `promedio_periodo` int(11) NOT NULL,
  `promedio_global` int(11) NOT NULL,
  `codigo_alumno` int(11) NOT NULL,
  `codigo_seccion` int(11) NOT NULL,
  `codigo_periodo` int(11) NOT NULL,
  PRIMARY KEY (`codigo_historial`),
  KEY `fk_tbl_historial_tbl_alumnos1_idx` (`codigo_alumno`),
  KEY `fk_tbl_historial_tbl_seccion1_idx` (`codigo_seccion`),
  KEY `fk_tbl_historial_tbl_periodos1_idx` (`codigo_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_imagenes`
--

DROP TABLE IF EXISTS `tbl_imagenes`;
CREATE TABLE IF NOT EXISTS `tbl_imagenes` (
  `codigo_imagen` int(11) NOT NULL,
  `url_imagen` varchar(200) DEFAULT NULL,
  `codigo_persona` int(11) NOT NULL,
  PRIMARY KEY (`codigo_imagen`),
  KEY `fk_tbl_imagenes_tbl_personas1_idx` (`codigo_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_lugares`
--

DROP TABLE IF EXISTS `tbl_lugares`;
CREATE TABLE IF NOT EXISTS `tbl_lugares` (
  `codigo_lugar` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_lugar` varchar(200) NOT NULL,
  `longitud` int(11) DEFAULT NULL,
  `latitud` int(11) DEFAULT NULL,
  `codigo_lugar_padre` int(11) NOT NULL,
  `codigo_tipo_lugar` int(11) NOT NULL,
  PRIMARY KEY (`codigo_lugar`),
  KEY `fk_tbl_lugares_tbl_lugares1_idx` (`codigo_lugar_padre`),
  KEY `fk_tbl_lugares_tbl_tipo_lugares1_idx` (`codigo_tipo_lugar`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_lugares`
--

INSERT INTO `tbl_lugares` (`codigo_lugar`, `nombre_lugar`, `longitud`, `latitud`, `codigo_lugar_padre`, `codigo_tipo_lugar`) VALUES
(1, 'Francisco Morazan', NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_maestros`
--

DROP TABLE IF EXISTS `tbl_maestros`;
CREATE TABLE IF NOT EXISTS `tbl_maestros` (
  `codigo_maestro` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_empleado` int(11) NOT NULL,
  `codigo_especializacion` int(11) NOT NULL,
  `codigo_titularidad` int(11) NOT NULL,
  `codigo_tipo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_maestro`),
  KEY `fk_tbl_maestros_tbl_empleados1_idx` (`codigo_empleado`),
  KEY `fk_tbl_maestros_tbl_area_especializaciones1_idx` (`codigo_especializacion`),
  KEY `fk_tbl_maestros_tbl_titularidad1_idx` (`codigo_titularidad`),
  KEY `fk_tbl_maestros_tbl_tipos_usuarios1_idx` (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_maestros`
--

INSERT INTO `tbl_maestros` (`codigo_maestro`, `codigo_empleado`, `codigo_especializacion`, `codigo_titularidad`, `codigo_tipo_usuario`) VALUES
(1, 4, 1, 1, 3),
(2, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_matricula`
--

DROP TABLE IF EXISTS `tbl_matricula`;
CREATE TABLE IF NOT EXISTS `tbl_matricula` (
  `fecha_matricula` date NOT NULL,
  `codigo_seccion` int(11) NOT NULL,
  `codigo_alumno` int(11) NOT NULL,
  `codigo_estado_matricula` int(11) NOT NULL,
  KEY `fk_tbl_matricula_tbl_seccion1_idx` (`codigo_seccion`),
  KEY `fk_tbl_matricula_tbl_alumnos1_idx` (`codigo_alumno`),
  KEY `fk_tbl_matricula_tbl_estados_matricula1_idx` (`codigo_estado_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_matricula`
--

INSERT INTO `tbl_matricula` (`fecha_matricula`, `codigo_seccion`, `codigo_alumno`, `codigo_estado_matricula`) VALUES
('2018-02-10', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_periodos`
--

DROP TABLE IF EXISTS `tbl_periodos`;
CREATE TABLE IF NOT EXISTS `tbl_periodos` (
  `codigo_periodo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_periodo` varchar(200) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `codigo_tipo_periodo` int(11) NOT NULL,
  PRIMARY KEY (`codigo_periodo`),
  KEY `fk_tbl_periodos_tbl_tipo_periodos1_idx` (`codigo_tipo_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_periodos`
--

INSERT INTO `tbl_periodos` (`codigo_periodo`, `nombre_periodo`, `fecha_inicio`, `fecha_fin`, `codigo_tipo_periodo`) VALUES
(1, 'primer periodo', '2018-01-22', '2018-05-17', 0),
(2, 'segundo periodo', '2018-06-05', '2018-09-03', 0),
(3, 'tercer periodo', '2018-09-09', '2018-12-20', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_personas`
--

DROP TABLE IF EXISTS `tbl_personas`;
CREATE TABLE IF NOT EXISTS `tbl_personas` (
  `codigo_persona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `apellido` varchar(200) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `identidad` varchar(13) NOT NULL,
  `direccion` varchar(800) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `correo_electronico` varchar(300) NOT NULL,
  `contrasenia` varchar(45) NOT NULL,
  `codigo_genero` int(11) NOT NULL,
  `codigo_tipo_identificacion` int(11) NOT NULL,
  `codigo_estado_civil` int(11) NOT NULL,
  `codigo_lugar_nacimiento` int(11) NOT NULL,
  `codigo_lugar_residencia` int(11) NOT NULL,
  `codigo_campus` int(11) NOT NULL,
  `codigo_tipo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_persona`),
  KEY `fk_tbl_personas_tbl_generos1_idx` (`codigo_genero`),
  KEY `fk_tbl_personas_tbl_tipo_identificacion1_idx` (`codigo_tipo_identificacion`),
  KEY `fk_tbl_personas_tbl_estados_civiles1_idx` (`codigo_estado_civil`),
  KEY `fk_tbl_personas_tbl_lugares1_idx` (`codigo_lugar_nacimiento`),
  KEY `fk_tbl_personas_tbl_lugares2_idx` (`codigo_lugar_residencia`),
  KEY `fk_tbl_personas_tbl_campus1_idx` (`codigo_campus`),
  KEY `fk_tbl_personas_tbl_tipos_usuarios1_idx` (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_personas`
--

INSERT INTO `tbl_personas` (`codigo_persona`, `nombre`, `apellido`, `fecha_nacimiento`, `identidad`, `direccion`, `telefono`, `correo_electronico`, `contrasenia`, `codigo_genero`, `codigo_tipo_identificacion`, `codigo_estado_civil`, `codigo_lugar_nacimiento`, `codigo_lugar_residencia`, `codigo_campus`, `codigo_tipo_usuario`) VALUES
(1, 'Carlos Roberto', 'Vasquez Rodrigez', '1994-05-01', '0801199408244', 'Colonia loarque ', '22268039', 'carlosrodriguez@gmail.com', 'asd4567', 0, 0, 0, 0, 0, 0, 0),
(2, 'Jose Alfredo', 'Gonzales Matute', '1990-10-10', '0801199028475', 'Colonia El pedregal', '98237481', 'josematute@gmail.com', 'asd4567', 0, 0, 0, 0, 0, 0, 0),
(3, 'Claudia Mariela', 'Izaguirre Mendoza', '1988-08-09', '0801198809672', 'Colonia Reynel funez', '98304876', 'claudiamendoza@gmail.com', 'asd1234', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_planes_de_estudios`
--

DROP TABLE IF EXISTS `tbl_planes_de_estudios`;
CREATE TABLE IF NOT EXISTS `tbl_planes_de_estudios` (
  `codigo_plan_de_estudios` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_plan_de_estudios` varchar(45) NOT NULL,
  `codigo_asignatura` int(11) NOT NULL,
  `codigo_carrera` int(11) NOT NULL,
  PRIMARY KEY (`codigo_plan_de_estudios`),
  KEY `fk_tbl_planes_de_estudios_tbl_asignaturas1_idx` (`codigo_asignatura`),
  KEY `fk_tbl_planes_de_estudios_tbl_carreras1_idx` (`codigo_carrera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_requisitos`
--

DROP TABLE IF EXISTS `tbl_requisitos`;
CREATE TABLE IF NOT EXISTS `tbl_requisitos` (
  `codigo_asignatura` int(11) NOT NULL,
  `codigo_asignatura_requisito` int(11) NOT NULL,
  `codigo_carrera` int(11) NOT NULL,
  KEY `fk_tbl_requisitos_tbl_asignaturas1_idx` (`codigo_asignatura`),
  KEY `fk_tbl_requisitos_tbl_carreras1_idx` (`codigo_carrera`),
  KEY `fk_tbl_requisitos_tbl_asignaturas1_idx1` (`codigo_asignatura_requisito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_requisitos`
--

INSERT INTO `tbl_requisitos` (`codigo_asignatura`, `codigo_asignatura_requisito`, `codigo_carrera`) VALUES
(0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_seccion`
--

DROP TABLE IF EXISTS `tbl_seccion`;
CREATE TABLE IF NOT EXISTS `tbl_seccion` (
  `codigo_seccion` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_alterno` varchar(200) NOT NULL,
  `hora_inicio` datetime NOT NULL,
  `hora_final` datetime NOT NULL,
  `dias` varchar(200) NOT NULL,
  `cantidad_cupos` int(11) NOT NULL,
  `codigo_aula` int(11) NOT NULL,
  `codigo_asignatura` int(11) NOT NULL,
  `codigo_maestro` int(11) NOT NULL,
  `codigo_periodo` int(11) NOT NULL,
  PRIMARY KEY (`codigo_seccion`),
  KEY `fk_tbl_seccion_tbl_aulas1_idx` (`codigo_aula`),
  KEY `fk_tbl_seccion_tbl_asignaturas1_idx` (`codigo_asignatura`),
  KEY `fk_tbl_seccion_tbl_maestros1_idx` (`codigo_maestro`),
  KEY `fk_tbl_seccion_tbl_periodos1_idx` (`codigo_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_seccion`
--

INSERT INTO `tbl_seccion` (`codigo_seccion`, `codigo_alterno`, `hora_inicio`, `hora_final`, `dias`, `cantidad_cupos`, `codigo_aula`, `codigo_asignatura`, `codigo_maestro`, `codigo_periodo`) VALUES
(1, '1500', '2018-02-20 15:00:00', '2018-02-20 16:00:00', 'lu, ma, mi, ju, vi', 40, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipos_aulas`
--

DROP TABLE IF EXISTS `tbl_tipos_aulas`;
CREATE TABLE IF NOT EXISTS `tbl_tipos_aulas` (
  `codigo_tipo_aula` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_aula` varchar(200) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codigo_tipo_aula`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipos_aulas`
--

INSERT INTO `tbl_tipos_aulas` (`codigo_tipo_aula`, `tipo_aula`, `descripcion`) VALUES
(1, 'aula normal ', 'en esta aula se imparte clases para ingeniara y tiene capacidad para 40 estudiantes'),
(2, 'aula normal', 'en esta aula se imparte clases para ingeniara y tiene capacidad para 35 estudiantes'),
(3, 'audivisuales', 'en esta aula solamente se utiliza para presentacines'),
(4, 'aula grande', 'en esta aula se imparte clases para estudiantes de clases generales, capacidad de aula 60'),
(5, 'laboratrio', 'en esta aula se imparten laboratorios de física general 1 para ingeniería, capacidad de 20 estudiantes '),
(6, 'aula grande', 'en esta aula se imparte clases generales, capacidad de 70 estudiantes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipos_evaluaciones`
--

DROP TABLE IF EXISTS `tbl_tipos_evaluaciones`;
CREATE TABLE IF NOT EXISTS `tbl_tipos_evaluaciones` (
  `codigo_tipo_evaluacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_evaluacion` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_tipo_evaluacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipos_usuarios`
--

DROP TABLE IF EXISTS `tbl_tipos_usuarios`;
CREATE TABLE IF NOT EXISTS `tbl_tipos_usuarios` (
  `codigo_tipo_usuario` int(11) NOT NULL,
  `tipo_usuario` varchar(25) NOT NULL,
  `id_acceso` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`codigo_tipo_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipos_usuarios`
--

INSERT INTO `tbl_tipos_usuarios` (`codigo_tipo_usuario`, `tipo_usuario`, `id_acceso`) VALUES
(1, 'Administrador', '1'),
(2, 'Estudiante', '2'),
(3, 'Docente', '3'),
(4, 'Empleado', '4');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_asignatura`
--

DROP TABLE IF EXISTS `tbl_tipo_asignatura`;
CREATE TABLE IF NOT EXISTS `tbl_tipo_asignatura` (
  `codigo_tipo_asignatura` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_asignatura` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_tipo_asignatura`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_asignatura`
--

INSERT INTO `tbl_tipo_asignatura` (`codigo_tipo_asignatura`, `tipo_asignatura`) VALUES
(1, 'matemáticas '),
(2, 'General'),
(3, 'Programación '),
(4, 'Finanzas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_empleado`
--

DROP TABLE IF EXISTS `tbl_tipo_empleado`;
CREATE TABLE IF NOT EXISTS `tbl_tipo_empleado` (
  `codigo_tipo_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_empleado` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codigo_tipo_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_empleado`
--

INSERT INTO `tbl_tipo_empleado` (`codigo_tipo_empleado`, `nombre_tipo_empleado`) VALUES
(1, 'empleado por hora'),
(2, 'empleado permanente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_identificacion`
--

DROP TABLE IF EXISTS `tbl_tipo_identificacion`;
CREATE TABLE IF NOT EXISTS `tbl_tipo_identificacion` (
  `codigo_tipo_identificacion` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_identificacion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codigo_tipo_identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_identificacion`
--

INSERT INTO `tbl_tipo_identificacion` (`codigo_tipo_identificacion`, `tipo_identificacion`) VALUES
(1, 'tarjeta de identidad'),
(2, 'pasaporte');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_lugares`
--

DROP TABLE IF EXISTS `tbl_tipo_lugares`;
CREATE TABLE IF NOT EXISTS `tbl_tipo_lugares` (
  `codigo_tipo_lugar` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tpo_lugar` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_tipo_lugar`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_lugares`
--

INSERT INTO `tbl_tipo_lugares` (`codigo_tipo_lugar`, `nombre_tpo_lugar`) VALUES
(1, 'Departamento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_periodos`
--

DROP TABLE IF EXISTS `tbl_tipo_periodos`;
CREATE TABLE IF NOT EXISTS `tbl_tipo_periodos` (
  `codigo_tipo_periodo` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_periodo` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_tipo_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_periodos`
--

INSERT INTO `tbl_tipo_periodos` (`codigo_tipo_periodo`, `tipo_periodo`) VALUES
(1, 'periodo largo'),
(2, 'periodo largo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_titularidad`
--

DROP TABLE IF EXISTS `tbl_titularidad`;
CREATE TABLE IF NOT EXISTS `tbl_titularidad` (
  `codigo_titularidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_titularidad` varchar(200) DEFAULT NULL,
  `salario_minimo` float DEFAULT NULL,
  `salario_maximo` float DEFAULT NULL,
  PRIMARY KEY (`codigo_titularidad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_titularidad`
--

INSERT INTO `tbl_titularidad` (`codigo_titularidad`, `nombre_titularidad`, `salario_minimo`, `salario_maximo`) VALUES
(1, 'Ingeniero en sistemas ', NULL, NULL),
(2, 'Licenciado en matemáticas ', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_titulos`
--

DROP TABLE IF EXISTS `tbl_titulos`;
CREATE TABLE IF NOT EXISTS `tbl_titulos` (
  `codigo_titulo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_titulo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codigo_titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_titulos`
--

INSERT INTO `tbl_titulos` (`codigo_titulo`, `nombre_titulo`) VALUES
(1, 'Ingeniero en sistemas '),
(2, 'Licenciado en matematicas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_titulos_x_empleado`
--

DROP TABLE IF EXISTS `tbl_titulos_x_empleado`;
CREATE TABLE IF NOT EXISTS `tbl_titulos_x_empleado` (
  `fecha` date DEFAULT NULL,
  `numero_registro` varchar(200) DEFAULT NULL,
  `codigo_titulo` int(11) NOT NULL,
  `codigo_empleado` int(11) NOT NULL,
  `codigo_universidad` int(11) NOT NULL,
  PRIMARY KEY (`codigo_titulo`,`codigo_empleado`),
  KEY `fk_tbl_titulos_x_empleado_tbl_titulos1_idx` (`codigo_titulo`),
  KEY `fk_tbl_titulos_x_empleado_tbl_empleados1_idx` (`codigo_empleado`),
  KEY `fk_tbl_titulos_x_empleado_tbl_universidades1_idx` (`codigo_universidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_universidades`
--

DROP TABLE IF EXISTS `tbl_universidades`;
CREATE TABLE IF NOT EXISTS `tbl_universidades` (
  `codigo_universidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_universidad` varchar(200) NOT NULL,
  `direccion` varchar(400) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`codigo_universidad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_universidades`
--

INSERT INTO `tbl_universidades` (`codigo_universidad`, `nombre_universidad`, `direccion`, `telefono`) VALUES
(1, 'UNAH', NULL, NULL),
(2, 'UNICAH', NULL, NULL);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD CONSTRAINT `tbl_admin_tbl_tipos_usuarios1` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tbl_tipos_usuarios` (`codigo_tipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_alumnos`
--
ALTER TABLE `tbl_alumnos`
  ADD CONSTRAINT `tbl_alumnos_tbl_personas1` FOREIGN KEY (`codigo_persona`) REFERENCES `tbl_personas` (`codigo_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_alumnos_tbl_tipos_usuarios1` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tbl_tipos_usuarios` (`codigo_tipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_asignaturas`
--
ALTER TABLE `tbl_asignaturas`
  ADD CONSTRAINT `tbl_asignaturas_tbl_carreras` FOREIGN KEY (`codigo_carrera`) REFERENCES `tbl_carreras` (`codigo_carrera`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_asignaturas_tbl_tipo_asignatura1` FOREIGN KEY (`codigo_tipo_asignatura`) REFERENCES `tbl_tipo_asignatura` (`codigo_tipo_asignatura`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_aulas`
--
ALTER TABLE `tbl_aulas`
  ADD CONSTRAINT `tbl_aulas_tbl_edificios1` FOREIGN KEY (`codigo_edificio`) REFERENCES `tbl_edificios` (`codigo_edificio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_aulas_tbl_tipos_aulas1` FOREIGN KEY (`codigo_tipo_aula`) REFERENCES `tbl_tipos_aulas` (`codigo_tipo_aula`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_cargos`
--
ALTER TABLE `tbl_cargos`
  ADD CONSTRAINT `tbl_cargos_tbl_cargos1` FOREIGN KEY (`codigo_cargo_superior`) REFERENCES `tbl_cargos` (`codigo_cargo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_carreras`
--
ALTER TABLE `tbl_carreras`
  ADD CONSTRAINT `tbl_carreras_tbl_facultades1` FOREIGN KEY (`codigo_facultad`) REFERENCES `tbl_facultades` (`codigo_facultad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_carreras_tbl_grados1` FOREIGN KEY (`codigo_grado`) REFERENCES `tbl_grados` (`codigo_grado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_carreras_x_alumnos`
--
ALTER TABLE `tbl_carreras_x_alumnos`
  ADD CONSTRAINT `tbl_carreras_x_alumnos_tbl_alumnos1` FOREIGN KEY (`codigo_alumno`) REFERENCES `tbl_alumnos` (`codigo_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_carreras_x_alumnos_tbl_carreras1` FOREIGN KEY (`codigo_carrera`) REFERENCES `tbl_carreras` (`codigo_carrera`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_detalle_evaluacion`
--
ALTER TABLE `tbl_detalle_evaluacion`
  ADD CONSTRAINT `tbl_detalle_evaluacion_tbl_historial1` FOREIGN KEY (`codigo_historial`) REFERENCES `tbl_historial` (`codigo_historial`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_detalle_evaluacion_tbl_tipos_evaluaciones1` FOREIGN KEY (`codigo_tipo_evaluacion`) REFERENCES `tbl_tipos_evaluaciones` (`codigo_tipo_evaluacion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_edificios`
--
ALTER TABLE `tbl_edificios`
  ADD CONSTRAINT `tbl_edificios_tbl_campus1` FOREIGN KEY (`codigo_campus`) REFERENCES `tbl_campus` (`codigo_campus`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_empleados`
--
ALTER TABLE `tbl_empleados`
  ADD CONSTRAINT `tbl_empleados_tbl_cargos1` FOREIGN KEY (`codigo_cargo`) REFERENCES `tbl_cargos` (`codigo_cargo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_empleados_tbl_personas1` FOREIGN KEY (`codigo_persona`) REFERENCES `tbl_personas` (`codigo_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_empleados_tbl_tipo_empleado1` FOREIGN KEY (`codigo_tipo_empleado`) REFERENCES `tbl_tipo_empleado` (`codigo_tipo_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_empleados_tbl_tipos_usuarios1` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tbl_tipos_usuarios` (`codigo_tipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_historial`
--
ALTER TABLE `tbl_historial`
  ADD CONSTRAINT `tbl_historial_tbl_alumnos1` FOREIGN KEY (`codigo_alumno`) REFERENCES `tbl_alumnos` (`codigo_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_historial_tbl_periodos1` FOREIGN KEY (`codigo_periodo`) REFERENCES `tbl_periodos` (`codigo_periodo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_historial_tbl_seccion1` FOREIGN KEY (`codigo_seccion`) REFERENCES `tbl_seccion` (`codigo_seccion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_imagenes`
--
ALTER TABLE `tbl_imagenes`
  ADD CONSTRAINT `tbl_imagenes_tbl_personas1` FOREIGN KEY (`codigo_persona`) REFERENCES `tbl_personas` (`codigo_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_lugares`
--
ALTER TABLE `tbl_lugares`
  ADD CONSTRAINT `tbl_lugares_tbl_lugares1` FOREIGN KEY (`codigo_lugar_padre`) REFERENCES `tbl_lugares` (`codigo_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_lugares_tbl_tipo_lugares1` FOREIGN KEY (`codigo_tipo_lugar`) REFERENCES `tbl_tipo_lugares` (`codigo_tipo_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_maestros`
--
ALTER TABLE `tbl_maestros`
  ADD CONSTRAINT `tbl_maestros_tbl_area_especializaciones1` FOREIGN KEY (`codigo_especializacion`) REFERENCES `tbl_area_especializaciones` (`codigo_especializacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_maestros_tbl_empleados1` FOREIGN KEY (`codigo_empleado`) REFERENCES `tbl_empleados` (`codigo_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_maestros_tbl_tipos_usuarios1` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tbl_tipos_usuarios` (`codigo_tipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_maestros_tbl_titularidad1` FOREIGN KEY (`codigo_titularidad`) REFERENCES `tbl_titularidad` (`codigo_titularidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_matricula`
--
ALTER TABLE `tbl_matricula`
  ADD CONSTRAINT `tbl_matricula_tbl_alumnos1` FOREIGN KEY (`codigo_alumno`) REFERENCES `tbl_alumnos` (`codigo_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_matricula_tbl_estados_matricula1` FOREIGN KEY (`codigo_estado_matricula`) REFERENCES `tbl_estados_matricula` (`codigo_estado_matricula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_matricula_tbl_seccion1` FOREIGN KEY (`codigo_seccion`) REFERENCES `tbl_seccion` (`codigo_seccion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_periodos`
--
ALTER TABLE `tbl_periodos`
  ADD CONSTRAINT `tbl_periodos_tbl_tipo_periodos1` FOREIGN KEY (`codigo_tipo_periodo`) REFERENCES `tbl_tipo_periodos` (`codigo_tipo_periodo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_personas`
--
ALTER TABLE `tbl_personas`
  ADD CONSTRAINT `tbl_personas_tbl_campus1` FOREIGN KEY (`codigo_campus`) REFERENCES `tbl_campus` (`codigo_campus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_personas_tbl_estados_civiles1` FOREIGN KEY (`codigo_estado_civil`) REFERENCES `tbl_estados_civiles` (`codigo_estado_civil`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_personas_tbl_generos1` FOREIGN KEY (`codigo_genero`) REFERENCES `tbl_generos` (`codigo_genero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_personas_tbl_lugares1` FOREIGN KEY (`codigo_lugar_nacimiento`) REFERENCES `tbl_lugares` (`codigo_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_personas_tbl_lugares2` FOREIGN KEY (`codigo_lugar_residencia`) REFERENCES `tbl_lugares` (`codigo_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_personas_tbl_tipo_identificacion1` FOREIGN KEY (`codigo_tipo_identificacion`) REFERENCES `tbl_tipo_identificacion` (`codigo_tipo_identificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_personas_tbl_tipos_usuarios1` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tbl_tipos_usuarios` (`codigo_tipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_planes_de_estudios`
--
ALTER TABLE `tbl_planes_de_estudios`
  ADD CONSTRAINT `fk_tbl_planes_de_estudios_tbl_asignaturas1` FOREIGN KEY (`codigo_asignatura`) REFERENCES `tbl_asignaturas` (`codigo_asignatura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_planes_de_estudios_tbl_carreras1` FOREIGN KEY (`codigo_carrera`) REFERENCES `tbl_carreras` (`codigo_carrera`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_requisitos`
--
ALTER TABLE `tbl_requisitos`
  ADD CONSTRAINT `fk_tbl_requisitos_tbl_asignaturas1` FOREIGN KEY (`codigo_asignatura_requisito`) REFERENCES `tbl_asignaturas` (`codigo_asignatura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_requisitos_tbl_asignaturas1` FOREIGN KEY (`codigo_asignatura`) REFERENCES `tbl_asignaturas` (`codigo_asignatura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_requisitos_tbl_carreras1` FOREIGN KEY (`codigo_carrera`) REFERENCES `tbl_carreras` (`codigo_carrera`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_seccion`
--
ALTER TABLE `tbl_seccion`
  ADD CONSTRAINT `tbl_seccion_tbl_asignaturas1` FOREIGN KEY (`codigo_asignatura`) REFERENCES `tbl_asignaturas` (`codigo_asignatura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_seccion_tbl_aulas1` FOREIGN KEY (`codigo_aula`) REFERENCES `tbl_aulas` (`codigo_aula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_seccion_tbl_maestros1` FOREIGN KEY (`codigo_maestro`) REFERENCES `tbl_maestros` (`codigo_maestro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_seccion_tbl_periodos1` FOREIGN KEY (`codigo_periodo`) REFERENCES `tbl_periodos` (`codigo_periodo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_titulos_x_empleado`
--
ALTER TABLE `tbl_titulos_x_empleado`
  ADD CONSTRAINT `tbl_titulos_x_empleado_tbl_empleados1` FOREIGN KEY (`codigo_empleado`) REFERENCES `tbl_empleados` (`codigo_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_titulos_x_empleado_tbl_titulos1` FOREIGN KEY (`codigo_titulo`) REFERENCES `tbl_titulos` (`codigo_titulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tbl_titulos_x_empleado_tbl_universidades1` FOREIGN KEY (`codigo_universidad`) REFERENCES `tbl_universidades` (`codigo_universidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
