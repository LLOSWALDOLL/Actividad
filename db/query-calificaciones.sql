CREATE DATABASE dwi_meza;

CREATE TABLE dwi_meza.alumnos(
	Matricula 	VARCHAR(11) NOT NULL, 
    Nombre 			VARCHAR(45) NOT NULL,
    Paterno 		VARCHAR(45) NOT NULL,
    Materno   		VARCHAR(45) NOT NULL,
    Sexo			CHAR(1) 	NOT NULL,
    FechaNac		DATE 		NOT NULL,
    Telefono		VARCHAR(10) NOT NULL,
    Direccion 		VARCHAR(45) NOT NULL,
    Correo			VARCHAR(45) NOT NULL,
	PRIMARY KEY(Matricula)
)ENGINE=InnoDB;

CREATE TABLE dwi_meza.materias(
	ClaveMateria 	VARCHAR(6) NOT NULL, 
    Nombre 			VARCHAR(45) NOT NULL,
    Cuatrimestre	VARCHAR(45) NOT NULL,
	PRIMARY KEY(ClaveMateria)
)ENGINE=InnoDB;

CREATE TABLE dwi_meza.accesos(
	ClaveAccesos 	INT AUTO_INCREMENT,
    Correo 			VARCHAR(255) NOT NULL,
    Contrasena 		VARCHAR(255) NOT NULL,
    PRIMARY KEY(ClaveAccesos)
)ENGINE=InnoDB;

CREATE TABLE dwi_meza.calificaciones (
    MatriculaAlumno VARCHAR(11) NOT NULL,
    ClaveMateria    VARCHAR(6) NOT NULL,
    Parcial1        FLOAT, 
    Parcial2        FLOAT, 
    Parcial3        FLOAT,
    Extraordinario  FLOAT,
    CONSTRAINT fk_calificaciones_alumnos   FOREIGN KEY (MatriculaAlumno) 	REFERENCES alumnos (Matricula) 		ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_calificaciones_materias  FOREIGN KEY (ClaveMateria)     	REFERENCES materias (ClaveMateria)  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

INSERT INTO dwi_meza.alumnos 
(Matricula, 	Nombre, 				Paterno, 		Materno, 		Sexo, 	FechaNac, 		Telefono, 		Direccion, 			Correo)
VALUES
('57221900129', 'Oswaldo', 	'Meza', 		'Moreno',  	'M',    '2001-04-06',	'7561138765' ,	'San Juan',    		'olivermeza111@gmail.com'),
('57221900131', 'Salus ',        	 	'Loreto',     	'Hernandez',      'F',    '2001-02-22',	'7561427628' ,	'20 norte', 		'salus@gmail.com'), 
('57221900130', 'Tomas',    	 	'Ramirez',  	'Patricio',     'M',    '1998-02-21',	'7561553552' ,	'17 norte',         'tomasz@gmail.com'), 
('57221900132', 'Arturo',  	'Diaz', 	'Chino',  'M',    '2001-07-22',	'7561938112' ,	'San Jose',    'arturi@gmail.com'),
('57221900133', 'Geraldine',  				'Mendez', 		'Moreno',  		'F',    '2001-09-10',	'7561146892' ,	' San fancisco',  'geraldinedelao@gmail.com');

-- Registros para la tabla "materias"
INSERT INTO dwi_meza.materias (ClaveMateria, Nombre, Cuatrimestre)
VALUES
('DWP023', 'Desarrollo Web Profesional', '8vo'),
('ABD023', 'Administración de Bases de Datos', '8vo'),
('DWI023', 'Desarrollo WEB Integral', '9no'),
('DDI023', 'Desarrollo para Dispositivos Inteligentes', '9no');

-- Registros para la tabla "accesos"
INSERT INTO dwi_meza.accesos (Correo, Contrasena)
VALUES
('olivermeza111@gmail.com', 	'3896'),
('admin@gmail.com', 	'3896'),
('root@gmail.com', 				    '12345');

-- Registros para la tabla "calificaciones"
INSERT INTO dwi_meza.calificaciones 
(MatriculaAlumno,  ClaveMateria, Parcial1, Parcial2, Parcial3, Extraordinario)
VALUES
('57221900133', 'DWP023', 8.5, 8.9, 8.8, NULL),
('57221900133', 'ABD023', 9.1, 8.7, 8.2, NULL),
('57221900133', 'DWI023', 8.1, 8.7, 8.2, NULL),
('57221900133', 'DDI023', 9.1, 8.7, 8.2, NULL),
('57221900132', 'DWP023', 8.8, 8.5, 8.0, NULL),
('57221900132', 'ABD023', 8.8, 8.5, 8.0, NULL),
('57221900132', 'DWI023', 8.8, 8.5, 8.0, NULL),
('57221900132', 'DDI023', 8.9, 7.5, 6.8, 8.0),
('57221900131', 'DWP023', 6.5, 8.0, 7.2, 8.0),
('57221900131', 'ABD023', 8.5, 8.0, 8.2, NULL),
('57221900131', 'DWI023', 8.5, 9.0, 8.2, NULL),
('57221900131', 'DDI023', 9.0, 7.3, 5.8, 8.0),
('57221900130', 'DWP023', 8.2, 7.0, 7.0, 8.0),
('57221900130', 'ABD023', 8.0, 8.8, 9.5, NULL),
('57221900130', 'DWI023', 8.2, 7.0, 7.0, 8.0),
('57221900130', 'DDI023', 8.0, 8.0, 10,  NULL),
('57221900129', 'DWP023', 9.0, 9.0, 9.0, NULL),
('57221900129', 'ABD023', 8.0, 7.2, 8.0, 8.0),
('57221900129', 'DWI023', 8.0, 9.2, 9.3, NULL),
('57221900129', 'DDI023', 10, 10, 9.5,   NULL);