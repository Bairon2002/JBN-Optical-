-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-12-2019 a las 20:59:13
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `opticaljbn`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actulizar_cita_asignadaa_asistida` (IN `inidcita` TINYINT)  begin 
    UPDATE cita set Estado='Asistida' WHERE idcita = inidcita;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `chao` ()  BEGIN
    delete from formula;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `citas` (`innomusuario` VARCHAR(15))  begin 
SELECT cita.fechCita, cita.Estado, cita.idcita FROM persona AS per INNER JOIN cita AS cita WHERE per.idpersona = cita.Persona AND per.nomPersona = innomusuario AND cita.Estado = 'Asignada';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `citasdisponibles` ()  begin 
    SELECT * FROM cita WHERE Estado = 'Disponible';
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `citaspersonales` (IN `innombreusuario` VARCHAR(50))  begin 
    SELECT cita.fechCita,cita.Estado FROM persona AS per INNER JOIN cita AS cit WHERE per.idPersona=cita.idcita AND per.nomPersona= innombreusuario AND cita.Estado='Asistida';
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `citas_Disponible_a_Asignada` (IN `inidcita` TINYINT, IN `inidcliente` TINYINT)  begin 
    UPDATE cita set Estado='Asignada',cliente = inidcliente where idcita = inidcita;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `correo` (`idcita` TINYINT)  begin
select fechCita,persona,hora FROM cita WHERE idcita;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `detalle` (IN `medicamento` TINYINT, IN `descripsion` TEXT)  begin 
    insert into detallemedicamento(	medicamento,	descripcion)VALUES(medicamento,descripsion);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `historia_y_formula` (IN `idcliente` TINYINT(50))  BEGIN
SELECT per.nomPersona, cit.fechCita, cit.hora, cit.Persona FROM cita AS cit INNER JOIN persona AS per ON per.idPersona = cit.cliente WHERE cliente =idcliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `historicocitas` (IN `innombreusuario` VARCHAR(50))  begin 
 SELECT cita.fechCita,cita.Persona FROM persona AS per INNER JOIN cita AS cita WHERE per.idPersona=cita.idcita AND per.nomPersona= innombreusuario AND cita.Estado='Asignada';
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listaasignadas` ()  begin
select * from cita WHERE estado='Asignada';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listaasistidas` ()  BEGIN
select * FROM cita WHERE Estado = 'Asistida';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listacliente` ()  SELECT * from persona where tarProfesional =0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listadocumento` ()  begin
select idtipdoc,nomtipdoc from tipodocumento;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listamedi` ()  BEGIN
select idPersona, nomPersona from persona WHERE tarProfesional!=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listamedicamentos` ()  BEGIN
select * from medicamento ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listamedicos` ()  begin
select * from persona WHERE tarProfesional <>0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listatipomedicamento` ()  begin 
SELECT * FROM `tipomedicamento` ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (`innomusuario` VARCHAR(50), `inpassusuario` VARCHAR(20))  begin
    SELECT * FROM usuario WHERE nomusuario=innomusuario and passusuario=inpassusuario;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `medicamentos` (IN `inidMedicamento` TINYINT)  begin 
SELECT * from medicamento where idMedicamento=inidMedicamento;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nombremedicamentos` ()  begin
SELECT  idmedicamento, nomMedicamento from medicamento;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pruba` (IN `innombreusuario` VARCHAR(50))  begin 
    SELECT cita.fechCita,cita.Estado FROM persona AS per INNER JOIN cita AS cita WHERE per.idPersona=cita.idcita AND per.nomPersona= innombreusuario AND cita.Estado='Disponible';
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrocita` (IN `fechCita` DATE, IN `persona` TINYINT, IN `hora` TIME, IN `Estado` ENUM('Disponible','Asignada','Asistida','Cancelada'), IN `cliente` TINYINT)  begin 
    insert into cita  (	fechCita,Persona,hora,Estado,cliente)VALUES (fechCita,Persona,hora,Estado,cliente);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registroformula` (IN `inpaciente` VARCHAR(20), IN `infecha` TINYINT, IN `estado` DATE)  begin 
    insert into formula(Cliente,Medico,FechaFormula) VALUES (inpaciente,infecha,estado);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registroMedicamento` (IN `innomMedicamento` VARCHAR(20), IN `intipmedicamento` VARCHAR(20), IN `inviaconsumo` VARCHAR(10), IN `invalor` FLOAT, IN `incantidad` INT, IN `inlaboratorio` VARCHAR(20))  begin 
    insert into medicamento (nomMedicamento,tipmedicamento,viaconsumo,valor,cantidad,laboratorio) VALUES (innomMedicamento,intipmedicamento,inviaconsumo,invalor,incantidad,inlaboratorio);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registropersonascliente` (IN `innomPersona` VARCHAR(15), IN `inapePersona` VARCHAR(15), IN `intipdoc` TINYINT, IN `innumDocumento` BIGINT, IN `infechaNacmiento` DATE, IN `intelPersona` INT, IN `incorPersona` VARCHAR(50), IN `inestado` ENUM('Activo','Inactivo'))  begin 
    insert into persona (nomPersona,apePersona,tipdoc,numDocumento,	fechaNacimineto,telPersona,corPersona,estado) VALUES (innomPersona,inapePersona,intipdoc,innumDocumento,infechaNacmiento,intelPersona,incorPersona,inestado='Activo');
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registropersonasMedico` (IN `innomPersona` VARCHAR(15), IN `inapePersona` VARCHAR(15), IN `intipdoc` TINYINT, IN `innumDocumento` BIGINT, IN `infechaNacmiento` DATE, IN `intelPersona` INT, IN `incorPersona` VARCHAR(50), IN `intarProfesional` BIGINT, IN `inestado` ENUM('Activo','Inactivo'))  begin 
    insert into persona(nomPersona,apePersona,tipdoc,numDocumento,fechaNacimineto	,telPersona,corPersona,tarProfesional,estado) VALUES (innomPersona,inapePersona,intipdoc,innumDocumento,infechaNacmiento,intelPersona,incorPersona,intarProfesional,inestado);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrousuario` (IN `innomusuario` VARCHAR(50), IN `inpassusuario` VARCHAR(20), IN `inpersona` TINYINT, IN `inrol` TINYINT, IN `inestado` ENUM('Activo','Inactivo'))  begin 
    insert into usuario (nomusuario,passusuario,persona,rol,estado)VALUES (innomusuario,inpassusuario,inpersona,inrol,inestado);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selecmedicoscitas` ()  begin 
select idPersona,nomPersona from persona WHERE tarProfesional <>0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_idpersona` (IN `innombreUsuario` VARCHAR(50))  begin 
    SELECT idPersona FROM persona WHERE corPersona = innombreUsuario;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_nombre_medico` (`inidpersona` TINYINT)  begin 
    SELECT nompersona FROM persona WHERE idpersona = inidpersona;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `trear_nombre` (`innombreUsuario` VARCHAR(50))  begin 
    SELECT nomPersona FROM persona WHERE corPersona = innombreUsuario;
    end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `idcita` tinyint(4) NOT NULL,
  `fechCita` date DEFAULT NULL,
  `Persona` tinyint(4) DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `Estado` enum('Disponible','Asignada','Asistida','Cancelada') NOT NULL,
  `cliente` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`idcita`, `fechCita`, `Persona`, `hora`, `Estado`, `cliente`) VALUES
(20, '2019-12-12', 79, '15:09:00', 'Asistida', NULL),
(21, '2019-12-12', 77, '10:24:00', 'Asistida', NULL),
(22, '2019-12-12', 80, '15:20:00', 'Asistida', 76),
(26, '2019-12-13', 79, '15:08:00', 'Asistida', 76),
(27, '2019-12-13', 79, '07:30:00', 'Asistida', NULL),
(28, '2019-12-16', 77, '07:12:00', 'Disponible', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallemedicamento`
--

CREATE TABLE `detallemedicamento` (
  `iddetamed` tinyint(4) NOT NULL,
  `medicamento` tinyint(4) DEFAULT NULL,
  `descripcion` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detallemedicamento`
--

INSERT INTO `detallemedicamento` (`iddetamed`, `medicamento`, `descripcion`) VALUES
(1, 1, NULL),
(2, 1, NULL),
(3, 1, NULL),
(4, 3, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formula`
--

CREATE TABLE `formula` (
  `idformula` tinyint(4) NOT NULL,
  `Cliente` varchar(20) NOT NULL,
  `Medico` tinyint(4) NOT NULL,
  `FechaFormula` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `formula`
--

INSERT INTO `formula` (`idformula`, `Cliente`, `Medico`, `FechaFormula`) VALUES
(2, 'nicolas silva', 79, '2019-12-12'),
(3, 'nicolas silva', 79, '2019-12-17'),
(4, 'nicolas silva', 79, '2019-12-17'),
(5, 'nicolas silva', 77, '2019-12-18'),
(6, 'nicolas silva', 77, '2019-12-12'),
(7, 'brandon', 77, '2019-12-12'),
(8, 'nicolas', 77, '2019-12-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamento`
--

CREATE TABLE `medicamento` (
  `idmedicamento` tinyint(4) NOT NULL,
  `nomMedicamento` varchar(20) DEFAULT NULL,
  `tipmedicamento` tinyint(4) DEFAULT NULL,
  `viaconsumo` varchar(10) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `laboratorio` varchar(20) DEFAULT NULL,
  `Estado` enum('Disponible','Agotado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `medicamento`
--

INSERT INTO `medicamento` (`idmedicamento`, `nomMedicamento`, `tipmedicamento`, `viaconsumo`, `valor`, `cantidad`, `laboratorio`, `Estado`) VALUES
(1, 'Cloranfenicol', 6, 'oral', 2000, 1223, 'Tetraciclina', 'Disponible'),
(2, 'Bacitracina', 5, 'topico', 15000, 1222, 'Pfzer', 'Disponible'),
(3, 'Sulfonamidas', 4, 'ocular', 10000, 123, 'SANOFI', 'Disponible'),
(5, 'cloroformo', 4, 'anlaa', 0, 0, '', 'Disponible'),
(10, 'acetaminofem', 6, 'oral', 1000, 1250, 'genfarkids', 'Disponible'),
(11, ' acetaminofen', 5, 'oral', 12000, 10, 'genfarkids', 'Disponible'),
(12, 'hibupofreno', 6, 'oral', 1500, 123, 'genfarkids', 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idPersona` tinyint(4) NOT NULL,
  `nomPersona` varchar(15) DEFAULT NULL,
  `apePersona` varchar(15) DEFAULT NULL,
  `tipdoc` tinyint(4) DEFAULT NULL,
  `numDocumento` bigint(15) DEFAULT NULL,
  `fechaNacimineto` date DEFAULT NULL,
  `telPersona` int(11) NOT NULL,
  `corPersona` varchar(50) DEFAULT NULL,
  `tarProfesional` bigint(20) NOT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `nomPersona`, `apePersona`, `tipdoc`, `numDocumento`, `fechaNacimineto`, `telPersona`, `corPersona`, `tarProfesional`, `estado`) VALUES
(76, 'Rolando Nicolas', 'silva morerno', 3, 1000220946, '1999-07-14', 8114645, 'rnsilva6@misena.edu.co', 0, 'Activo'),
(77, 'Jean Carlo', 'Gomez Reyes', 4, 100123643, '2002-04-10', 3224563, 'jcgomez63@gmail.com', 107634, 'Activo'),
(78, 'Bairon Esteban', 'Alfonso Amado', 3, 100293832, '1998-04-05', 8334576, 'bealfonso23@gmail.com', 0, 'Activo'),
(79, 'Brayan ', 'Garzon', 3, 1000292323, '1968-12-07', 32227267, 'braayangomez12@gmail.com', 12425, 'Activo'),
(80, 'marlon', 'gutierrez', 3, 79462897, '1978-01-01', 3452345, 'marlongutierrez@gmai.com', 31245435, 'Activo'),
(81, 'bairon esteban', 'alfonso amado', 4, 1000469678, '2002-04-05', 8284432, 'bealfonso@misena.edu.co', 0, NULL),
(85, 'axel david', 'silva moreno', 3, 1000220945, '2000-07-24', 8114645, 'axelmoreno@gmail.com', 0, NULL),
(88, 'angie lorena', 'rivera rico', 3, 1000861748, '2001-06-09', 6552223, 'angieriver@gmail.com', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` tinyint(4) NOT NULL,
  `nomrol` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nomrol`) VALUES
(7, 'Medico'),
(8, 'Cliente'),
(9, 'Asistente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `idtipdoc` tinyint(4) NOT NULL,
  `nomtipdoc` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`idtipdoc`, `nomtipdoc`) VALUES
(3, 'C.C'),
(4, 'T.I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomedicamento`
--

CREATE TABLE `tipomedicamento` (
  `idtipo` tinyint(4) NOT NULL,
  `nomtipo` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipomedicamento`
--

INSERT INTO `tipomedicamento` (`idtipo`, `nomtipo`) VALUES
(4, 'Gotas'),
(5, 'Crema'),
(6, 'Pastillas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` tinyint(4) NOT NULL,
  `nomusuario` varchar(50) DEFAULT NULL,
  `passusuario` varchar(20) DEFAULT NULL,
  `persona` tinyint(4) DEFAULT NULL,
  `rol` tinyint(4) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nomusuario`, `passusuario`, `persona`, `rol`, `estado`) VALUES
(14, 'rnsilva6@misena.edu.co', 'N1colasl0l012', 76, 8, 'Activo'),
(15, 'jcgomez63@gmail.com', 'jeancarlo', 77, 7, 'Activo'),
(16, 'bealfonso23@gmail.com', 'bairon1234', 78, 9, 'Activo'),
(17, 'braayangomez12@gmail.com', 'N1colasl0l0', 79, 7, 'Activo'),
(18, 'marlongutierrez@gmai.com', 'Marlon0098', 80, 7, 'Activo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`idcita`),
  ADD UNIQUE KEY `hora` (`hora`),
  ADD KEY `Persona` (`Persona`),
  ADD KEY `cliente` (`cliente`);

--
-- Indices de la tabla `detallemedicamento`
--
ALTER TABLE `detallemedicamento`
  ADD PRIMARY KEY (`iddetamed`),
  ADD KEY `medicamento` (`medicamento`);

--
-- Indices de la tabla `formula`
--
ALTER TABLE `formula`
  ADD PRIMARY KEY (`idformula`),
  ADD KEY `Medico` (`Medico`);

--
-- Indices de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD PRIMARY KEY (`idmedicamento`),
  ADD KEY `tipmedicamento` (`tipmedicamento`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`),
  ADD UNIQUE KEY `numDocumento` (`numDocumento`),
  ADD UNIQUE KEY `corPersona` (`corPersona`),
  ADD KEY `tipdoc` (`tipdoc`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`idtipdoc`);

--
-- Indices de la tabla `tipomedicamento`
--
ALTER TABLE `tipomedicamento`
  ADD PRIMARY KEY (`idtipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `nomusuario` (`nomusuario`),
  ADD UNIQUE KEY `nomusuario_2` (`nomusuario`),
  ADD KEY `persona` (`persona`),
  ADD KEY `rol` (`rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `idcita` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `detallemedicamento`
--
ALTER TABLE `detallemedicamento`
  MODIFY `iddetamed` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `formula`
--
ALTER TABLE `formula`
  MODIFY `idformula` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  MODIFY `idmedicamento` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idrol` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `idtipdoc` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipomedicamento`
--
ALTER TABLE `tipomedicamento`
  MODIFY `idtipo` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`Persona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`cliente`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `detallemedicamento`
--
ALTER TABLE `detallemedicamento`
  ADD CONSTRAINT `detallemedicamento_ibfk_1` FOREIGN KEY (`medicamento`) REFERENCES `medicamento` (`idmedicamento`);

--
-- Filtros para la tabla `formula`
--
ALTER TABLE `formula`
  ADD CONSTRAINT `formula_ibfk_2` FOREIGN KEY (`Medico`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD CONSTRAINT `medicamento_ibfk_1` FOREIGN KEY (`tipmedicamento`) REFERENCES `tipomedicamento` (`idtipo`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`tipdoc`) REFERENCES `tipodocumento` (`idtipdoc`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`persona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`rol`) REFERENCES `rol` (`idrol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
