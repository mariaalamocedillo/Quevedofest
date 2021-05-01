--ÁREA ARTÍSTICA
--
-- Tabla: ARTISTA
--
CREATE TABLE artista (
  	id int NOT NULL,
  	DNI_PAS char(9) NOT NULL DEFAULT '',
	nombreLegal varchar(30) NOT NULL,
	nombreArtistico varchar(15) NOT NULL, 
	fechaNac date NOT NULL,
	campoArtistico varchar(15),
	genero varchar(15),
	telefono bigint DEFAULT NULL,
	sueldo numeric(10,0),
  CONSTRAINT artista_pk PRIMARY KEY (id),
  CONSTRAINT artista_dni_ux UNIQUE (DNI_PAS) 
);
CREATE SEQUENCE art
INCREMENT 1
START 1;
INSERT into artista values (nextval(art), 'ZAB211485', 'Austin Richard', 'Post Malone', '1995-05-09', 'cantante', 015555552, 15000),
		(nextval(art), '45653252K', 'Rosalia Vila', 'Rosalia', '1996-02-28', 'cantante', 665241522, 10000),
		(nextval(art), 'E62777698', 'Ara Malikian', 'Ara Malikian', '1968-09-21', 'violinista', 628015023, 3000),  
		(nextval(art), '57547437L','Estrella de la Aurora Morente', 'Estrella Morente',  '1980-08-15', 'cantante', 'Pop', 634416100, 2000), 
		(nextval(art), '75698752K','Ernesto sanchez', 'Elver Galarga',  '1991-09-05', 'telonero', 'Rock', 689378341, 1000),
		(nextval(art), '34887653H','Juan Aparicio Gomez', 'El Juanpar',  '1995-09-07', 'bateria', 'Punk', 611494529, 700),
		(nextval(art), '07643288L','Paula Buk', 'Buki',  '1997-11-12', 'telonero', 'Trap', 615229832, 1500),
		(nextval(art), '23456865N','Tristán Tuner', 'Tis-T',  '1996-07-07', 'cantante', 'Trap', 675056603, 2600),
		(nextval(art), 'L23456866','Oyuki Castillo', 'Yu-k',  '1987-01-15', 'telonero', 'Rap', 693720603, 1700),
		(nextval(art), '48348395F','Agatha Christina Moya', 'Ccat',  '1993-08-04', 'cantante', 'Drill', 668169535, 1100),
		(nextval(art), '23455433P','Julio Alberto Ramírez', 'Alberto Juan',  '2001-04-09', 'telonero', 'Cumbia', 698508949, 1200),
		(nextval(art), 'K56788990','Mario Jampier', 'Costrosos',  '2014-04-30', 'Banda', 'Punk', 019978671, 6000),
		(nextval(art), 'G33456799','Lydia Table', 'The regrettes',  '2012-07-17', 'Banda', 'Rock-Punk', 019090882, 15000),
		(nextval(art), 'N57849034','Maria Rabelo', 'Chinchikats',  '1980-08-15', 'Banda', 689392817, 6500),
		(nextval(art), 'Y42546785','Taylor Moon', 'Moony',  '1998-12-12', 'telonero', 'Pop', 674623883, 1000),
		(nextval(art), '96849395D','Joana Palma', 'CarNoon',  '2000-04-08', 'telonero', 'Rap', 698494857, 700),
		(nextval(art), '99489495K','Jhonatan Alfonso', 'JHoNy',  '1998-03-22', 'telonero', 'Pop', 678656543, 900),
		(nextval(art), '86849485H','David Coaguallelo', 'DaVId',  '2000-03-12', 'telonero', 'Trap', 674665765, 1000),
		(nextval(art), 'E45858490','Daniel Alcaide', 'DanAl',  '1996-06-12', 'cantante', 'Trap', 698457428, 1200),
		(nextval(art), 'F45455542','Maria Estela', 'EsTla',  '1994-09-22', 'cantante', 'Pop', 673568447, 1800)



--
-- Tabla: RRSS_ARTISTA
--
CREATE TABLE rrss_artista (
  	id int NOT NULL,
  	id_artista int NOT NULL,
	plataforma varchar(10) NOT NULL,
	nombre_cuenta varchar(30) NOT NULL,
  CONSTRAINT rrss_artista_pk PRIMARY KEY (id),
  CONSTRAINT rrss_artista_id_fk FOREIGN KEY (id_artista) 
        REFERENCES artista(id) 
);
CREATE SEQUENCE rrss
INCREMENT 1
START 1;
INSERT into rrss_artista values (nextval(rrss), 1, 'instagram','@PostMalone'),
(nextval(rrss), 1, 'twitter','@PostMalone'),
(nextval(rrss), 2, 'instagram','@rosalia'),
(nextval(rrss), 2, 'twitter','@rosalia'),
(nextval(rrss), 2, 'tiktok','@rosalia'),
(nextval(rrss), 3, 'facebook', '@aramalikian'), 
(nextval(rrss), 3, 'twitter', '@aramalikian'), 
(nextval(rrss), 3, 'instagram', '@aramalikian'), 
(nextval(rrss), 4, 'instagram', '@morente.estrella'), 
(nextval(rrss), 4, 'twitter', '@EstrellaMorente')
(nextval(rrss), 4, 'instagram', '@morente.estrella'), 
(nextval(rrss), 5, 'instagram', '@elverg'), 
(nextval(rrss), 5, 'tiktok', '@elverg'), 
(nextval(rrss), 6, 'instagram', '@eljuanpar'), 
(nextval(rrss), 6, 'twitter', '@eljuanpar'), 
(nextval(rrss), 6, 'tiktok', '@eljuanpar'), 
(nextval(rrss), 7, 'instagram', '@bukita'), 
(nextval(rrss), 7, 'tiktok', '@labuki'), 
(nextval(rrss), 9, 'twitter', '@yuktela'), 
(nextval(rrss), 8, 'instagram', '@eltrisT'), 
(nextval(rrss), 8, 'tiktok', '@eltrisT'), 
(nextval(rrss), 11, 'facebook', '@julioal'), 
(nextval(rrss), 13, 'instagram', '@theregrettes'), 
(nextval(rrss), 13, 'tiktok', '@theregrettes'), 
(nextval(rrss), 14, 'instagram', '@chinchikats'), 
--
-- Tabla: CARTEL 	
-- 
CREATE TABLE cartel (
  	id int NOT NULL,
  	web varchar(60),
	precio_entrada int,
	fecha_festival date NOT NULL,
  CONSTRAINT cartel_pk PRIMARY KEY (id)
);
CREATE SEQUENCE cart
INCREMENT 1
START 1;
INSERT into cartel values (nextval(cart), 'https://www.quevedofest.com', 35, 21-05-2021),
	(nextval(cart), 'https://www.quevedofest.com', 70, 20-05-2021),
	(nextval(cart), 'https://www.quevedofest.com', 35, 22-05-2021)
--
-- Tabla: ARTISTA_CARTEL
--
CREATE TABLE artistas_cartel (
	id_cartel INT NOT NULL,
	id_artista INT NOT NULL,
	CONSTRAINT artista_cartel_pk PRIMARY KEY (id_cartel, id_artista),
	CONSTRAINT art_cart_cartel_id_fk FOREIGN KEY (id_cartel) 
        REFERENCES cartel(id),
	CONSTRAINT art_cart_artista_id_fk FOREIGN KEY (id_artista) 
        REFERENCES artista(id) 
);
INSERT into artistas_cartel values (1, 1), (1, 2), (1, 4), (1, 7), 
	(2, 1), (2, 5), (2, 6), (2, 8), (2, 9), (2, 11), (2, 3), (2, 16), 
	(2, 15), (2, 10), (3, 1), (3, 3), (3, 10), (3, 7), (3, 4), (3, 9)
--
-- Tabla: INVITACIONES
--
CREATE TABLE invitaciones (
	codigo int NOT NULL,
	id_artista int NOT NULL,
	nombre varchar(30) NOT NULL,
	num_acompanantes int DEFAULT 0,
	permisos varchar(8) NOT NULL DEFAULT 'Basico',
  CONSTRAINT invitaciones_pk PRIMARY KEY (codigo, id_artista),
  CONSTRAINT invitaciones_artista_id_fk FOREIGN KEY (id_artista) 
    REFERENCES artista(id),
  CONSTRAINT invitaciones_permisos_ck CHECK (permisos IN ('Basico','VIP','Total'))  
);
CREATE SEQUENCE cod_inv
INCREMENT 1
START 1;
INSERT into invitaciones values (nextval(cod_inv), 1, 'Andrea Joe', 1, 'VIP'), 
								(nextval(cod_inv), 1, 'Joana Wells', 3, 'Basico'), 
								(nextval(cod_inv), 1, 'John Travis', 1, 'Total'),
								(nextval(cod_inv), 4, 'Ana Moreno', 1, 'Basico'),
								(nextval(cod_inv), 2, 'Esther Carrillo', 0, 'VIP'),
								(nextval(cod_inv), 3, 'Erendira Santillana', 2, 'Total'),
								(nextval(cod_inv), 3, 'Roger Andreano', 1, 'Basico'),
								(nextval(cod_inv), 6, 'Juan Antonio Perez', 0, 'Basico'),
								(nextval(cod_inv), 7, 'Antonio Jesus Moreno', 1, 'Total'),
								(nextval(cod_inv), 7, 'Epifanía del Señor Tavarez', 2, 'Total'),
								(nextval(cod_inv), 9, 'Estefanía Torres', 3, 'Basico'),
								(nextval(cod_inv), 11, 'Sergio Gonzalez', 1, 'Basico'),
								(nextval(cod_inv), 13, 'Mario Molina', 4, 'Total'),
								(nextval(cod_inv), 13, 'Sinesio Delgado', 0, 'VIP'),


--
-- Tabla: AGENDA
--
CREATE TABLE agenda (
  	cod_actuacion int NOT NULL,
	id_artista int NOT NULL,
	fecha date NOT NULL,
	horario time,
  CONSTRAINT agenda_pk PRIMARY KEY (cod_actuacion),
	CONSTRAINT agenda_telonero_id_fk FOREIGN KEY (id_artista) 
    REFERENCES artista(id)
);
CREATE SEQUENCE age
INCREMENT 1
START 1;

INSERT into agenda values (nextval(age), 5, '20-05-2021', '19:45:00'), 
(nextval(age), 3, '20-05-2021', '20:00:00'), 
(nextval(age), 9, '20-05-2021', '21:00:00'), 
(nextval(age), 8, '20-05-2021', '21:15:00'), 
(nextval(age), 16, '20-05-2021', '22:15:00'), 
(nextval(age), 6, '20-05-2021', '22:30:00'), 
(nextval(age), 7, '20-05-2021', '23:30:00'), 
(nextval(age), 1, '20-05-2021', '23:45:00'), 
(nextval(age), 15, '20-05-2021', '00:45:00'), 
(nextval(age), 12, '20-05-2021', '01:00:00'), 
(nextval(age), 7, '20-05-2021', '19:45:00'), 
(nextval(age), 20, '20-05-2021', '20:00:00'), 
(nextval(age), 15, '20-05-2021', '21:00:00'), 
(nextval(age), 4, '20-05-2021', '21:15:00'), 
(nextval(age), 5, '20-05-2021', '22:15:00'), 
(nextval(age), 13, '20-05-2021', '22:30:00'), 
(nextval(age), 11, '20-05-2021', '23:30:00'), 
(nextval(age), 10, '20-05-2021', '23:45:00'), 
(nextval(age), 18, '20-05-2021', '00:45:00'), 
(nextval(age), 1, '20-05-2021', '01:00:00')

--
-- Tabla: AGENDA_CARTEL
--
CREATE TABLE agenda_cartel (
	id_cartel INT NOT NULL,
	cod_actuacion INT NOT NULL,
	CONSTRAINT agenda_cartel_pk PRIMARY KEY (id_cartel, cod_actuacion),
	CONSTRAINT age_cart_cartel_id_fk FOREIGN KEY (id_cartel) 
        REFERENCES cartel(id),
	CONSTRAINT age_cart_agenda_id_fk FOREIGN KEY (cod_actuacion) 
        REFERENCES agenda(cod_actuacion) 
);
INSERT into agenda values (1, 8), (1, 20), (1, 14), (1, 7), (1, 11), (2, 8), 
(2, 20), (2, 1), (2, 6), (2, 4), (2, 3), (2, 17),
(2, 2), (2, 5), (2, 9), (2, 13), (2, 18), (3, 20), 
(3, 2), (3, 7), (3, 14), (3, 3)

--ÁREA DE PRODUCCIÓN
--
-- Tabla: ESPACIO
--
CREATE TABLE espacio (
	id int NOT NULL,
	tipo varchar(12) NOT NULL,
	empleado_encargado varchar(30) NOT NULL, --el nombre del encargado
	localizacion char(2) NOT NULL,
  	CONSTRAINT espacio_pk PRIMARY KEY (id),
    CONSTRAINT espacio_tipo_ck CHECK (tipo IN ('Escenario','Backstage','Camerino','Gradas', 'Almacen')),
    CONSTRAINT espacio_localizacion_ck CHECK (localizacion IN ('1A', '2A', '1B', '2B'))
);
CREATE SEQUENCE esp
INCREMENT 1
START 1;

INSERT into espacio values ( nextval(esp), 'Escenario', 'Ana Rodriguez', '1A'),
( nextval(esp), 'Escenario', 'Gustavo Alfarjo', '2A'),
( nextval(esp), 'Gradas', 'Ana Rodriguez', '1A'),
( nextval(esp), 'Gradas', 'Gustavo Alfarjo', '2A'),
( nextval(esp), 'Backstage', 'Africa Martínez', '1A'),
( nextval(esp), 'Backstage', 'Iñaki Perez', '2A'),
( nextval(esp), 'Almacen', 'Marco Pozuelo', '1B'),
( nextval(esp), 'Almacen', 'Ignacio Alarcón', '2B'),
( nextval(esp), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval(esp), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval(esp), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval(esp), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval(esp), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval(esp), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval(esp), 'Camerino', 'Pedro Gonalvo', '2B')

--
-- Tabla: ESCENOGRAFÍA 
--
CREATE TABLE escenografia (
	id int NOT NULL,
  	id_espacio int NOT NULL,
  	cod_actuacion int NOT NULL,
  	CONSTRAINT escenografia_pk PRIMARY KEY (id),
	CONSTRAINT escenografia_espacio_id_fk FOREIGN KEY (id_espacio) 
    	REFERENCES espacio(id),
	CONSTRAINT escenografia_cod_actuacion_fk FOREIGN KEY (cod_actuacion) 
    	REFERENCES agenda(cod_actuacion)
);
CREATE SEQUENCE escg
INCREMENT 1
START 1;

INSERT into espacio values (nextval(escg), 1, 1),
(nextval(escg), 1, 2),
(nextval(escg), 1, 3),
(nextval(escg), 1, 4),
(nextval(escg), 1, 5),
(nextval(escg), 1, 6),
(nextval(escg), 1, 7),
(nextval(escg), 1, 8),
(nextval(escg), 1, 9),
(nextval(escg), 1, 10),
(nextval(escg), 2, 11),
(nextval(escg), 2, 12),
(nextval(escg), 2, 13),
(nextval(escg), 2, 14),
(nextval(escg), 2, 15),
(nextval(escg), 2, 16),
(nextval(escg), 2, 17),
(nextval(escg), 2, 18),
(nextval(escg), 2, 19),
(nextval(escg), 2, 20)

--
-- Tabla: MATERIAL
--
CREATE TABLE material (
	id int NOT NULL,
	nombre varchar(20) NOT NULL,
	tipo varchar(12) NOT NULL DEFAULT 'Otros',
	precio numeric(10,0) DEFAULT 0,		--por unidad
	inicio_disponibilidad TIMESTAMP NOT NULL, --TIMESTAMP '2004-10-19 10:23:54'
	fin_disponibilidad TIMESTAMP,
	proveedor varchar(20) NOT NULL,
	cantidad int NOT NULL DEFAULT 1, --mínimo ordenarán una unidad
	almacenaje char(2) NOT NULL DEFAULT 'EU',
	descripcion varchar(50),
  	CONSTRAINT material_pk PRIMARY KEY (id),
    CONSTRAINT material_tipo_ck CHECK (tipo IN ('Iluminacion','Sonido','Atrezo','Imagen','Grabacion','Otros')),
    CONSTRAINT material_almacen_ck CHECK (almacenaje IN ('1B', '2B', 'EU'))--EU indica que está en uso(por ejemplo, material básico de los escenarios, que no se puede almacenar porque debe estar siempre montado)
);
CREATE SEQUENCE mat
INCREMENT 1
START 1;

INSERT into material values (nextval(mat), 'Platformas escenario', 'Otros', 50, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Espectaculos Romero SA', 500, 'EU', 'Plataformas para los escenarios')
(nextval(mat), 'Focos blancos escenario', 'Iluminacion', 20, '2021-05-19 17:00:00', '2021-05-23 12:00:00', 'Espectaculos Romero SA', 90, 'EU', 'Focos blancos para alumbrar los escenarios'),
(nextval(mat), 'Antorchas LED', 'Iluminacion', 50, '2021-05-19 20:00:00', '2021-05-23 12:00:00', 'Espectaculos Romero SA', 15, 'EU', 'Iluminación para las gradas tras los conciertos'),
(nextval(mat), 'Focos colores escenario', 'Iluminacion', 45, '2021-05-19 17:00:00', '2021-05-23 12:00:00', 'Ilusion SA', 50, 'EU', 'Luces de colores'),
(nextval(mat), 'Pantalla escenario 500"', 'Imagen', 1000, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Samsung', 4, 'EU', 'Pantalla para mejorar visualización del escenario'),
(nextval(mat), 'Pantalla gradas 250"', 'Imagen', 0, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Samsung', 4, 'EU', 'Pantalla para mejorar visualización, en las gradas'),
(nextval(mat), 'Fuegos frios', 'Atrezo', 20, '2021-05-19 12:00:00', NULL, 'Estalella SA', 1300, '1B', 'Fuegos no superan 10m altura'),
(nextval(mat), 'Rotulos pirotecnicos', 'Atrezo', 150, '2021-05-19 12:00:00', NULL, 'Estalella SA', 10, '2B', 'Rótulos con fuegos'),
(nextval(mat), 'Beh­ringer X32', 'Sonido', 700, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Thomann', 10, 'EU', 'Preamplificadores de micrófono'),
(nextval(mat), 'Confeti', 'Atrezo', 10, '2021-05-19 12:00:00', NULL, 'Estalella SA', 150, '1B', '150 bolsas de confeti de 10 kg'),
(nextval(mat), 'STEADYCAM', 'Grabacion', 1500, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Canon', 20, 'EU', 'Cámaras de grabación del escenario'),
(nextval(mat), 'Behringer ULM302MIC', 'Sonido', 90, '2021-05-19 12:00:00', '2021-05-23 07:00:00', 'Ultralink SA', 20, 'EU', 'Micrófonos inalámbricos'),
(nextval(mat), 'Startone Star Drum', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Startone', 3, 'EU', 'Batería completa'),
(nextval(mat), 'Amplificadores', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Marshall SA', 20, 'EU', 'Amplificadores de sonido'),
(nextval(mat), 'Altavoces ', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Marshall SA', 40, 'EU', 'Altavoces'),
(nextval(mat), 'Alto Stealth Wireless', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Marshall SA', 20, 'EU', 'Sistema inalámbrico estéreo para altavoces'),
(nextval(mat), 'Kenwood Protalk TK-3501', 'Otros', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'KenWood', 200, 'EU', 'WalkieTalkie para los técnicos'),
(nextval(mat), 'Slider MD-500', 'Grabacion', 300, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Canon', 4, 'EU', 'Carril motorizado para cámara de video'),
(nextval(mat), 'Maquina humo', 'Atrezo', 300, '2021-05-19 20:00:00', '2021-05-23 06:00:00', 'Estatella SA', 5, '1B', 'Máquina de humo para escenario'),
(nextval(mat), 'LEDS', 'Atrezo', 5, '2021-05-19 20:00:00', NULL, 'Estatella SA', 150, '1B', 'LEDS de colores para escenario; baras de 2 metros'),


--
-- Tabla: MATERIAL_ESCENOGRAFÍA 
--
CREATE TABLE material_escenografia (
	id_material int NOT NULL,
	unidades int NOT NULL,
	id_escenografia int NOT NULL,
	CONSTRAINT material_escenografia_pk PRIMARY KEY (id_material, id_escenografia),
	  CONSTRAINT mat_esc_material_id_fk FOREIGN KEY (id_material) 
    REFERENCES material (id),
	  CONSTRAINT mat_esc_escenografia_id_fk FOREIGN KEY (id_escenografia) 
    REFERENCES escenografia (id)
);
INSERT into material_escenografia values (7, 250, 2), (8, 2, 6), 
(8, 2, 14), (11, 4, 8), 
(10, 25, 14), (10, 25, 8), 
(10, 25, 20), (13, 1, 9),
(10, 30, 12), (13, 1, 14)
(8, 4, 20), (11, 4, 16), 
(19, 2, 12), (19, 1, 14)
(19, 1, 20), (20, 30, 16), 
(20, 40, 4), (20, 20, 8), 
(20, 25, 14), (20, 60, 10), 
(8, 4, 10), (7, 250, 10)
--
-- Tabla: CATERING
--
CREATE TABLE catering (
	id INT NOT NULL, 
	empresa_encargada varchar(10) NOT NULL,
	presupuesto numeric(10,0) NOT NULL,
	servicio_gratuito varchar(20),
	CONSTRAINT catering_pk PRIMARY KEY (id)
);
CREATE SEQUENCE cat
INCREMENT 1
START 1;

INSERT into catering values ( nextval(cat), 'Ismar Group SI', 9500, '1 botella vino por camerino'),
( nextval(cat), 'Dosjumar SI', 9500, 'Desayuno camerinos'),
( nextval(cat), 'Serunion SI', 5000, NULL),
( nextval(cat), 'OnlyYou SI', 11000, 'Desayuno camerinos'),
( nextval(cat), 'Sayca Catering SI', 10000, NULL),
( nextval(cat), 'Oscar Mayer', 20000, '1 perrito por espectador'),
( nextval(cat), 'The CocaCola Company', 16000, '2 latas por espectador'),
( nextval(cat), 'Monster Beverage Corporation', 12000, '1 muestra por espectador'),
( nextval(cat), 'PinkiBurguer', 21000, '1 hamburguesa por espectador')

--
-- Tabla: PUESTOS_CATERING
--
CREATE TABLE puesto_catering (
	id INT NOT NULL, 
	id_catering INT NOT NULL,
	num_puesto INT NOT NULL,
	lugar_asignado char(2) NOT NULL,
	servicio varchar(10) NOT NULL,
	CONSTRAINT puesto_catering_pk PRIMARY KEY (id),
	CONSTRAINT puesto_catering_catering_id_fk FOREIGN KEY (id_catering) 
        REFERENCES catering(id),
    CONSTRAINT puesto_catering_lugar_ck CHECK (lugar_asignado IN ('1A', '2A', '1B', '2B')),
	CONSTRAINT puesto_catering_servicio_ck CHECK (servicio IN ('Comida', 'Bebida', 'Mixto'))
);
CREATE SEQUENCE puest
INCREMENT 1
START 1;

INSERT into puesto_catering values (nextval(puest), 1, 1, '1B', 'Mixto'),
(nextval(puest), 2, 1, '1B', 'Comida'),
(nextval(puest), 2, 2, '2B', 'Comida'),
(nextval(puest), 5, 1, '2B', 'Mixto'),
(nextval(puest), 6, 1, '1A', 'Comida'),
(nextval(puest), 6, 2, '1A', 'Comida'),
(nextval(puest), 6, 3, '1A', 'Comida'),
(nextval(puest), 6, 4, '1A', 'Comida'),
(nextval(puest), 6, 5, '1A', 'Comida'),
(nextval(puest), 6, 6, '2A', 'Comida'),
(nextval(puest), 6, 7, '2A', 'Comida'),
(nextval(puest), 6, 8, '2A', 'Comida'),
(nextval(puest), 6, 9, '2A', 'Comida'),
(nextval(puest), 6, 10, '2A', 'Comida'),
(nextval(puest), 7, 1, '1A', 'Bebida'),
(nextval(puest), 7, 2, '1A', 'Bebida'),
(nextval(puest), 7, 3, '1A', 'Bebida'),
(nextval(puest), 7, 4, '1A', 'Bebida'),
(nextval(puest), 7, 5, '1A', 'Bebida'),
(nextval(puest), 7, 6, '2A', 'Bebida'),
(nextval(puest), 7, 7, '2A', 'Bebida'),
(nextval(puest), 7, 8, '2A', 'Bebida'),
(nextval(puest), 7, 9, '2A', 'Bebida'),
(nextval(puest), 7, 10, '2A', 'Bebida'),
(nextval(puest), 8, 1, '1A', 'Bebida'),
(nextval(puest), 8, 2, '1A', 'Bebida'),
(nextval(puest), 8, 3, '2A', 'Bebida'),
(nextval(puest), 8, 4, '2A', 'Bebida'),
(nextval(puest), 9, 1, '1A', 'Comida'),
(nextval(puest), 9, 2, '1A', 'Comida'),
(nextval(puest), 9, 3, '1A', 'Comida'),
(nextval(puest), 9, 4, '2A', 'Comida'),
(nextval(puest), 9, 5, '2A', 'Comida')
--
-- Tabla: ESPACIO_PUESTO
--
CREATE TABLE espacio_puesto (
	id_puesto INT NOT NULL,
	id_espacio INT NOT NULL,
	CONSTRAINT espacio_puesto_pk PRIMARY KEY (id_puesto, id_espacio),
	CONSTRAINT espacio_puesto_catering_id_fk FOREIGN KEY (id_puesto) 
        REFERENCES puesto_catering(id),
	CONSTRAINT espacio_puesto_espacio_id_fk FOREIGN KEY (id_espacio) 
        REFERENCES espacio(id)
);

