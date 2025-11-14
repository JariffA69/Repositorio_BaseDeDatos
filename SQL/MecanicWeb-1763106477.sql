CREATE TABLE IF NOT EXISTS `usuarios` (
	`id_usuario` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_rol` int NOT NULL,
	`nombre` varchar(25) NOT NULL,
	`email` varchar(25) NOT NULL,
	`password` varchar(25) NOT NULL,
	`telefono` int UNIQUE,
	PRIMARY KEY (`id_usuario`)
);

CREATE TABLE IF NOT EXISTS `roles` (
	`id_rol` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nombre` varchar(15) NOT NULL,
	PRIMARY KEY (`id_rol`)
);

CREATE TABLE IF NOT EXISTS `resenias` (
	`id_resenia` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_usuario` int NOT NULL,
	`id_taller` int NOT NULL,
	`puntuacion` int NOT NULL,
	`fecha_resenia` datetime NOT NULL,
	`comentario` text,
	PRIMARY KEY (`id_resenia`)
);

CREATE TABLE IF NOT EXISTS `citas` (
	`id_cita` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_servicio` int NOT NULL,
	`id_mecanico` int NOT NULL,
	`id_taller` int NOT NULL,
	`id_usuario` int NOT NULL,
	`estado` varchar(15) NOT NULL,
	`fecha` datetime NOT NULL,
	`hora` time NOT NULL,
	`descripcion` text,
	PRIMARY KEY (`id_cita`)
);

CREATE TABLE IF NOT EXISTS `registros_mecanicos` (
	`id_mecanico` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_usuario` int NOT NULL,
	`nombre` varchar(50) NOT NULL,
	`email` varchar(25) NOT NULL UNIQUE,
	`password` varchar(25) NOT NULL,
	`telefono` int NOT NULL UNIQUE,
	`calificacion_promedio` int NOT NULL,
	`estado` varchar(15) NOT NULL,
	`anios_experiencia` int NOT NULL,
	PRIMARY KEY (`id_mecanico`)
);

CREATE TABLE IF NOT EXISTS `talleres` (
	`id_taller` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_mecanico` int NOT NULL,
	`id_especialidad` int NOT NULL,
	`nombre_taller` varchar(15) NOT NULL,
	`telefono` int NOT NULL,
	`email` varchar(25) NOT NULL,
	`direccion` varchar(50) NOT NULL,
	`code_postal` int NOT NULL,
	`horario` varchar(15) NOT NULL,
	`descripcion` text NOT NULL,
	PRIMARY KEY (`id_taller`)
);

CREATE TABLE IF NOT EXISTS `especialidades` (
	`id_especialidad` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`id_especialidad`)
);

CREATE TABLE IF NOT EXISTS `servicios` (
	`id_servicio` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_taller` int NOT NULL,
	`id_servicio_ofre` int NOT NULL,
	`precio` int NOT NULL,
	PRIMARY KEY (`id_servicio`)
);

CREATE TABLE IF NOT EXISTS `servicios_ofrecidos` (
	`id_servicio_ofre` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`id_servicio_ofre`)
);

ALTER TABLE `usuarios` ADD CONSTRAINT `usuarios_fk1` FOREIGN KEY (`id_rol`) REFERENCES `roles`(`id_rol`);

ALTER TABLE `resenias` ADD CONSTRAINT `resenias_fk1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id_usuario`);

ALTER TABLE `resenias` ADD CONSTRAINT `resenias_fk2` FOREIGN KEY (`id_taller`) REFERENCES `talleres`(`id_taller`);
ALTER TABLE `citas` ADD CONSTRAINT `citas_fk1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios`(`id_servicio`);

ALTER TABLE `citas` ADD CONSTRAINT `citas_fk2` FOREIGN KEY (`id_mecanico`) REFERENCES `registros_mecanicos`(`id_mecanico`);

ALTER TABLE `citas` ADD CONSTRAINT `citas_fk3` FOREIGN KEY (`id_taller`) REFERENCES `talleres`(`id_taller`);

ALTER TABLE `citas` ADD CONSTRAINT `citas_fk4` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id_usuario`);
ALTER TABLE `registros_mecanicos` ADD CONSTRAINT `registros_mecanicos_fk1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id_usuario`);
ALTER TABLE `talleres` ADD CONSTRAINT `talleres_fk1` FOREIGN KEY (`id_mecanico`) REFERENCES `registros_mecanicos`(`id_mecanico`);

ALTER TABLE `talleres` ADD CONSTRAINT `talleres_fk2` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades`(`id_especialidad`);

ALTER TABLE `servicios` ADD CONSTRAINT `servicios_fk1` FOREIGN KEY (`id_taller`) REFERENCES `talleres`(`id_taller`);

ALTER TABLE `servicios` ADD CONSTRAINT `servicios_fk2` FOREIGN KEY (`id_servicio_ofre`) REFERENCES `servicios_ofrecidos`(`id_servicio_ofre`);
