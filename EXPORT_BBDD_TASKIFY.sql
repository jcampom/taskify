-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-06-2025 a las 17:04:51
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `flask_auth`
--
CREATE DATABASE IF NOT EXISTS `flask_auth` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `flask_auth`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

DROP TABLE IF EXISTS `tareas`;
CREATE TABLE IF NOT EXISTS `tareas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `estado` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `tareas`
--

TRUNCATE TABLE `tareas`;
--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `fecha_vencimiento`, `estado`) VALUES(1, 'Sed viverra elit sit amet nunc suscipit,', 'Curabitur tempus ex a cursus bibendum. Vestibulum nec lorem et velit ultrices sagittis. Integer vehicula ipsum eget tincidunt gravida. Ut id tellus ut ante volutpat vulputate. Aenean in neque vulputate, elementum est vitae, hendrerit quam.', '2025-06-08', 'P');
INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `fecha_vencimiento`, `estado`) VALUES(2, 'Cras sodales mi vel felis maximus feugia', 'Suspendisse sit amet ante interdum neque pretium dictum non non nibh. Integer at erat eu urna auctor iaculis. In molestie felis eget vulputate egestas. Phasellus eget neque sed enim dignissim blandit eu quis nulla. Vivamus et purus dapibus, posuere nisl sed, aliquam mi.', '2025-06-03', 'P');
INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `fecha_vencimiento`, `estado`) VALUES(3, 'Duis a lorem dignissim, condimentum quam', 'Donec consequat nisi non imperdiet ullamcorper. Phasellus et lorem nec mauris pharetra feugiat eu eget ligula.', '2025-06-04', 'F');
INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `fecha_vencimiento`, `estado`) VALUES(4, 'Pellentesque ac elit vitae tortor sceler', 'Nunc vitae magna suscipit urna tincidunt dictum. Donec a risus vitae metus venenatis ornare vitae quis tortor. Pellentesque sagittis ante ut tellus tempus pellentesque.', '2025-06-13', 'P');
INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `fecha_vencimiento`, `estado`) VALUES(6, 'In tempus augue eu tortor ultrices commo', 'Ut faucibus augue at turpis finibus dictum. Donec et sem ultrices, aliquet dui ultricies, faucibus nisi. Etiam non risus at neque porta accumsan eget sed lectus. Nunc et felis eu elit iaculis luctus quis et est. Sed in libero eleifend, porta neque quis, vehicula velit.', '2025-06-07', 'P');
INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `fecha_vencimiento`, `estado`) VALUES(7, 'Fusce eget tortor gravida, iaculis nibh', 'Nullam pharetra odio in commodo aliquam. Duis vitae lorem nec tellus vehicula dictum. Suspendisse nec nibh ut magna pharetra gravida quis nec arcu. Vestibulum fringilla urna quis eros congue sodales.', '2025-06-21', 'P');
INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `fecha_vencimiento`, `estado`) VALUES(8, 'Nullam eu nisi facilisis, efficitur lore', 'Quisque dignissim felis vitae urna scelerisque, ac molestie dui mollis. Pellentesque sed sapien sed nibh blandit iaculis. Donec et enim vel ipsum dictum maximus ac et leo. Duis ac magna in dui egestas luctus.', '2025-06-19', 'F');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `user`
--

TRUNCATE TABLE `user`;
--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES(2, 'admin', 'pbkdf2:sha256:1000000$tvkVOJ5DHYUJTgr5$389e8e23e449ad32f4900331480b858ea0cc15e3e1058225478b061078718326');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
