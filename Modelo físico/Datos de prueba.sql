--ÁREA ARTÍSTICA
--
-- Tabla: ARTISTA
--
INSERT into artista values (nextval('art'), 'ZAB211485', 'Austin Richard', 'Post Malone', '1995-05-09', 'cantante', 'Rap', 015555552, 15000),
		(nextval('art'), '45653252K', 'Rosalia Vila', 'Rosalia', '1996-02-28', 'cantante', 'Flamenco', 665241522, 10000),
		(nextval('art'), 'E62777698', 'Ara Malikian', 'Ara Malikian', '1968-09-21', 'violinista', 'Clasico-Pop', 628015023, 3000),  
		(nextval('art'), '57547437L','Estrella de la Aurora Morente', 'Morente',  '1980-08-15', 'cantante', 'Flamenco', 634416100, 2000), 
		(nextval('art'), '75698752K','Ernesto sanchez', 'Elver Galarga',  '1991-09-05', 'telonero', 'Rock', 689378341, 1000),
		(nextval('art'), '34887653H','Juan Aparicio Gomez', 'El Juanpar',  '1995-09-07', 'bateria', 'Punk', 611494529, 700),
		(nextval('art'), '07643288L','Paula Buk', 'Buki',  '1997-11-12', 'telonero', 'Trap', 615229832, 1500),
		(nextval('art'), '23456865N','Tristán Tuner', 'Tis-T',  '1996-07-07', 'cantante', 'Trap', 675056603, 2600),
		(nextval('art'), 'L23456866','Oyuki Castillo', 'Yu-k',  '1987-01-15', 'telonero', 'Rap', 693720603, 1700),
		(nextval('art'), '48348395F','Agatha Christina Moya', 'Ccat',  '1993-08-04', 'cantante', 'Drill', 668169535, 1100),
		(nextval('art'), '23455433P','Julio Alberto Ramírez', 'Alberto Juan',  '2001-04-09', 'telonero', 'Cumbia', 698508949, 1200),
		(nextval('art'), 'K56788990','Mario Jampier', 'Costrosos',  '2014-04-30', 'Banda', 'Punk', 019978671, 6000),
		(nextval('art'), 'G33456799','Lydia Table', 'The regrettes',  '2012-07-17', 'Banda', 'Rock-Punk', 019090882, 15000),
		(nextval('art'), 'N57849034','Maria Rabelo', 'Chinchikats',  '1980-08-15', 'Banda', 'Rock-Punk', 689392817, 6500),
		(nextval('art'), 'Y42546785','Taylor Moon', 'Moony',  '1998-12-12', 'telonero', 'Pop', 674623883, 1000),
		(nextval('art'), '96849395D','Joana Palma', 'CarNoon',  '2000-04-08', 'telonero', 'Rap', 698494857, 700),
		(nextval('art'), '99489495K','Jhonatan Alfonso', 'JHoNy',  '1998-03-22', 'telonero', 'Pop', 678656543, 900),
		(nextval('art'), '86849485H','David Coaguallelo', 'DaVId',  '2000-03-12', 'telonero', 'Trap', 674665765, 1000),
		(nextval('art'), 'E45858490','Daniel Alcaide', 'DanAl',  '1996-06-12', 'cantante', 'Trap', 698457428, 1200),
		(nextval('art'), 'F45455542','Maria Estela', 'EsTla',  '1994-09-22', 'cantante', 'Pop', 673568447, 1800);

--
-- Tabla: RRSS_ARTISTA
--
INSERT into rrss_artista values (nextval('rrss'), 1, 'instagram','@PostMalone'),
(nextval('rrss'), 1, 'twitter','@PostMalone'),
(nextval('rrss'), 2, 'instagram','@rosalia'),
(nextval('rrss'), 2, 'twitter','@rosalia'),
(nextval('rrss'), 2, 'tiktok','@rosalia'),
(nextval('rrss'), 3, 'facebook', '@aramalikian'), 
(nextval('rrss'), 3, 'twitter', '@aramalikian'), 
(nextval('rrss'), 3, 'instagram', '@aramalikian'), 
(nextval('rrss'), 4, 'instagram', '@morente.estrella'), 
(nextval('rrss'), 4, 'twitter', '@EstrellaMorente'),
(nextval('rrss'), 4, 'instagram', '@morente.estrella'), 
(nextval('rrss'), 5, 'instagram', '@elverg'), 
(nextval('rrss'), 5, 'tiktok', '@elverg'), 
(nextval('rrss'), 6, 'instagram', '@eljuanpar'), 
(nextval('rrss'), 6, 'twitter', '@eljuanpar'), 
(nextval('rrss'), 6, 'tiktok', '@eljuanpar'), 
(nextval('rrss'), 7, 'instagram', '@bukita'), 
(nextval('rrss'), 7, 'tiktok', '@labuki'), 
(nextval('rrss'), 9, 'twitter', '@yuktela'), 
(nextval('rrss'), 8, 'instagram', '@eltrisT'), 
(nextval('rrss'), 8, 'tiktok', '@eltrisT'), 
(nextval('rrss'), 11, 'facebook', '@julioal'), 
(nextval('rrss'), 13, 'instagram', '@theregrettes'), 
(nextval('rrss'), 13, 'tiktok', '@theregrettes'), 
(nextval('rrss'), 14, 'instagram', '@chinchikats');
--
-- Tabla: INVITACIONES
--
INSERT into invitaciones values (nextval('cod_inv'), 1, 'Andrea Joe', 1, 'VIP'), 
(nextval('cod_inv'), 1, 'Joana Wells', 3, 'Basico'), 
(nextval('cod_inv'), 1, 'John Travis', 1, 'Total'),
(nextval('cod_inv'), 4, 'Ana Moreno', 1, 'Basico'),
(nextval('cod_inv'), 2, 'Esther Carrillo', 0, 'VIP'),
(nextval('cod_inv'), 3, 'Erendira Santillana', 2, 'Total'),
(nextval('cod_inv'), 3, 'Roger Andreano', 1, 'Basico'),
(nextval('cod_inv'), 6, 'Juan Antonio Perez', 0, 'Basico'),
(nextval('cod_inv'), 7, 'Antonio Jesus Moreno', 1, 'Total'),
(nextval('cod_inv'), 7, 'Epifanía del Señor Tavarez', 2, 'Total'),
(nextval('cod_inv'), 9, 'Estefanía Torres', 3, 'Basico'),
(nextval('cod_inv'), 11, 'Sergio Gonzalez', 1, 'Basico'),
(nextval('cod_inv'), 13, 'Mario Molina', 4, 'Total'),
(nextval('cod_inv'), 13, 'Sinesio Delgado', 0, 'VIP');

--
-- Tabla: CARTEL 	
-- 
INSERT into cartel values (nextval('cart'), 'https://www.quevedofest.com', 35, '21-05-2021'),
	(nextval('cart'), 'https://www.quevedofest.com', 70, '20-05-2021'),
	(nextval('cart'), 'https://www.quevedofest.com', 35, '22-05-2021');
--
-- Tabla: ARTISTA_CARTEL
--
INSERT into artistas_cartel values (1, 1), (1, 2), (1, 4), (1, 7), 
	(2, 1), (2, 5), (2, 6), (2, 8), (2, 9), (2, 11), (2, 3), (2, 16), 
	(2, 15), (2, 10), (3, 1), (3, 3), (3, 10), (3, 7), (3, 4), (3, 9);

--
-- Tabla: AGENDA
--
INSERT into agenda values (nextval('age'), 5, '20-05-2021', '19:45:00'), 
(nextval('age'), 3, '20-05-2021', '20:00:00'), 
(nextval('age'), 9, '20-05-2021', '21:00:00'), 
(nextval('age'), 8, '20-05-2021', '21:15:00'), 
(nextval('age'), 16, '20-05-2021', '22:15:00'), 
(nextval('age'), 6, '20-05-2021', '22:30:00'), 
(nextval('age'), 7, '20-05-2021', '23:30:00'), 
(nextval('age'), 1, '20-05-2021', '23:45:00'), 
(nextval('age'), 15, '21-05-2021', '00:45:00'), 
(nextval('age'), 12, '21-05-2021', '01:00:00'), 
(nextval('age'), 7, '20-05-2021', '19:45:00'), 
(nextval('age'), 20, '20-05-2021', '20:00:00'), 
(nextval('age'), 15, '20-05-2021', '21:00:00'), 
(nextval('age'), 4, '20-05-2021', '21:15:00'), 
(nextval('age'), 5, '20-05-2021', '22:15:00'), 
(nextval('age'), 13, '20-05-2021', '22:30:00'), 
(nextval('age'), 11, '20-05-2021', '23:30:00'), 
(nextval('age'), 10, '20-05-2021', '23:45:00'), 
(nextval('age'), 18, '21-05-2021', '00:45:00'), 
(nextval('age'), 1, '21-05-2021', '01:00:00');

--
-- Tabla: AGENDA_CARTEL
--
INSERT into agenda_cartel values (1, 8), (1, 20), (1, 14), (1, 7), (1, 11), (2, 8), 
(2, 20), (2, 1), (2, 6), (2, 4), (2, 3), (2, 17),
(2, 2), (2, 5), (2, 9), (2, 13), (2, 18), (3, 20), 
(3, 2), (3, 7), (3, 14), (3, 3);

--ÁREA DE PRODUCCIÓN
--
-- Tabla: ESPACIO
--
INSERT into espacio values (nextval('esp'), 'Escenario', 'Ana Rodriguez', '1A'),
( nextval('esp'), 'Escenario', 'Gustavo Alfarjo', '2A'),
( nextval('esp'), 'Gradas', 'Ana Rodriguez', '1A'),
( nextval('esp'), 'Gradas', 'Gustavo Alfarjo', '2A'),
( nextval('esp'), 'Backstage', 'Africa Martínez', '1A'),
( nextval('esp'), 'Backstage', 'Iñaki Perez', '2A'),
( nextval('esp'), 'Almacen', 'Marco Pozuelo', '1B'),
( nextval('esp'), 'Almacen', 'Ignacio Alarcón', '2B'),
( nextval('esp'), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval('esp'), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval('esp'), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval('esp'), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval('esp'), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval('esp'), 'Camerino', 'Joaquin Ignacio', '1B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B'),
( nextval('esp'), 'Camerino', 'Pedro Gonalvo', '2B');
--
-- Tabla: CAMERINO_ARTISTA
--
INSERT into camerino_artista values (9, 4), (10, 2), (11, 8), (13, 13), (14, 1), (15, 10), 
(17, 6), (18, 14), (19, 3), (20, 12);

--
-- Tabla: ESCENOGRAFÍA 
--
INSERT into escenografia values (nextval('escg'), 1, 1),
(nextval('escg'), 1, 2),
(nextval('escg'), 1, 3),
(nextval('escg'), 1, 4),
(nextval('escg'), 1, 5),
(nextval('escg'), 1, 6),
(nextval('escg'), 1, 7),
(nextval('escg'), 1, 8),
(nextval('escg'), 1, 9),
(nextval('escg'), 1, 10),
(nextval('escg'), 2, 11),
(nextval('escg'), 2, 12),
(nextval('escg'), 2, 13),
(nextval('escg'), 2, 14),
(nextval('escg'), 2, 15),
(nextval('escg'), 2, 16),
(nextval('escg'), 2, 17),
(nextval('escg'), 2, 18),
(nextval('escg'), 2, 19),
(nextval('escg'), 2, 20);

--
-- Tabla: MATERIAL
--
INSERT into material values (nextval('mat'), 'Platformas escenario', 'Otros', 50, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Espectaculos Romero SA', 500, 'EU', 'Plataformas para los escenarios'),
(nextval('mat'), 'Focos blancos escenario', 'Iluminacion', 20, '2021-05-19 17:00:00', '2021-05-23 12:00:00', 'Espectaculos Romero SA', 90, 'EU', 'Focos blancos para alumbrar los escenarios'),
(nextval('mat'), 'Antorchas LED', 'Iluminacion', 50, '2021-05-19 20:00:00', '2021-05-23 12:00:00', 'Espectaculos Romero SA', 15, 'EU', 'Iluminación para las gradas tras los conciertos'),
(nextval('mat'), 'Focos colores escenario', 'Iluminacion', 45, '2021-05-19 17:00:00', '2021-05-23 12:00:00', 'Ilusion SA', 50, 'EU', 'Luces de colores'),
(nextval('mat'), 'Pantalla escenario 500"', 'Imagen', 1000, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Samsung', 4, 'EU', 'Pantalla para mejorar visualización del escenario'),
(nextval('mat'), 'Pantalla gradas 250"', 'Imagen', 0, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Samsung', 4, 'EU', 'Pantalla para mejorar visualización, en las gradas'),
(nextval('mat'), 'Fuegos frios', 'Atrezo', 20, '2021-05-19 12:00:00', NULL, 'Estalella SA', 1300, '1B', 'Fuegos no superan 10m altura'),
(nextval('mat'), 'Rotulos pirotecnicos', 'Atrezo', 150, '2021-05-19 12:00:00', NULL, 'Estalella SA', 10, '2B', 'Rótulos con fuegos'),
(nextval('mat'), 'Beh­ringer X32', 'Sonido', 700, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Thomann', 10, 'EU', 'Preamplificadores de micrófono'),
(nextval('mat'), 'Confeti', 'Atrezo', 10, '2021-05-19 12:00:00', NULL, 'Estalella SA', 150, '1B', '150 bolsas de confeti de 10 kg'),
(nextval('mat'), 'STEADYCAM', 'Grabacion', 1500, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Canon', 20, 'EU', 'Cámaras de grabación del escenario'),
(nextval('mat'), 'Behringer ULM302MIC', 'Sonido', 90, '2021-05-19 12:00:00', '2021-05-23 07:00:00', 'Ultralink SA', 20, 'EU', 'Micrófonos inalámbricos'),
(nextval('mat'), 'Startone Star Drum', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Startone', 3, 'EU', 'Batería completa'),
(nextval('mat'), 'Amplificadores', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Marshall SA', 20, 'EU', 'Amplificadores de sonido'),
(nextval('mat'), 'Altavoces ', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Marshall SA', 40, 'EU', 'Altavoces'),
(nextval('mat'), 'Alto Stealth Wireless', 'Sonido', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Marshall SA', 20, 'EU', 'Sistema inalámbrico estéreo para altavoces'),
(nextval('mat'), 'Kenwood Protalk TK-3501', 'Otros', NULL, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'KenWood', 200, 'EU', 'WalkieTalkie para los técnicos'),
(nextval('mat'), 'Slider MD-500', 'Grabacion', 300, '2021-05-19 12:00:00', '2021-05-23 12:00:00', 'Canon', 4, 'EU', 'Carril motorizado para cámara de video'),
(nextval('mat'), 'Maquina humo', 'Atrezo', 300, '2021-05-19 20:00:00', '2021-05-23 06:00:00', 'Estatella SA', 5, '1B', 'Máquina de humo para escenario'),
(nextval('mat'), 'LEDS', 'Atrezo', 5, '2021-05-19 20:00:00', NULL, 'Estatella SA', 150, '1B', 'LEDS de colores para escenario; baras de 2 metros');
--
-- Tabla: MATERIAL_ESCENOGRAFÍA 
--
INSERT into material_escenografia values (7, 250, 2), (8, 2, 6), 
(8, 2, 14), (11, 4, 8), 
(10, 25, 14), (10, 25, 8), 
(10, 25, 20), (13, 1, 9),
(10, 30, 12), (13, 1, 14),
(8, 4, 20), (11, 4, 16), 
(19, 2, 12), (19, 1, 14),
(19, 1, 20), (20, 30, 16), 
(20, 40, 4), (20, 20, 8), 
(20, 25, 14), (20, 60, 10), 
(8, 4, 10), (7, 250, 10);
--
-- Tabla: CATERING
--
INSERT into catering values (nextval('cat'), 'Ismar Group SI', 9500, '1 botella vino por camerino'),
( nextval('cat'), 'Dosjumar SI', 9500, 'Desayuno camerinos'),
( nextval('cat'), 'Serunion SI', 5000, NULL),
( nextval('cat'), 'OnlyYou SI', 11000, 'Desayuno camerinos'),
( nextval('cat'), 'Sayca Catering SI', 10000, NULL),
( nextval('cat'), 'Oscar Mayer', 20000, '1 perrito por espectador'),
( nextval('cat'), 'The CocaCola Company', 16000, '2 latas por espectador'),
( nextval('cat'), 'Monster Beverage Corporation', 12000, '1 muestra por espectador'),
( nextval('cat'), 'PinkiBurguer', 21000, '1 hamburguesa por espectador');

--
-- Tabla: PUESTOS_CATERING
--
INSERT into puesto_catering values (nextval('puest'), 1, 1, '1B', 9, 'Mixto'),
(nextval('puest'), 1, 1, '1B', 10, 'Mixto'),
(nextval('puest'), 1, 1, '1B', 13, 'Mixto'),
(nextval('puest'), 2, 1, '1B', 11, 'Comida'),
(nextval('puest'), 2, 1, '1B', 14, 'Comida'),
(nextval('puest'), 2, 1, '1B', 12, 'Mixto'),
(nextval('puest'), 1, 1, '2B', 21, 'Mixto'),
(nextval('puest'), 1, 1, '2B', 19, 'Mixto'),
(nextval('puest'), 2, 2, '2B', 20, 'Comida'),
(nextval('puest'), 2, 2, '2B', 18, 'Comida'),
(nextval('puest'), 2, 2, '2B', 16, 'Comida'),
(nextval('puest'), 5, 1, '2B', 17, 'Mixto'),
(nextval('puest'), 5, 1, '2B', 15, 'Mixto'),
(nextval('puest'), 6, 1, '1A', 3, 'Comida'),
(nextval('puest'), 6, 2, '1A', 3, 'Comida'),
(nextval('puest'), 6, 3, '1A', 3, 'Comida'),
(nextval('puest'), 6, 4, '1A', 3, 'Comida'),
(nextval('puest'), 6, 5, '1A', 5, 'Comida'),
(nextval('puest'), 6, 6, '2A', 4, 'Comida'),
(nextval('puest'), 6, 7, '2A', 4, 'Comida'),
(nextval('puest'), 6, 8, '2A', 4, 'Comida'),
(nextval('puest'), 6, 9, '2A', 4, 'Comida'),
(nextval('puest'), 6, 10, '2A', 6, 'Comida'),
(nextval('puest'), 7, 1, '1A', 3, 'Bebida'),
(nextval('puest'), 7, 2, '1A', 3, 'Bebida'),
(nextval('puest'), 7, 3, '1A', 3, 'Bebida'),
(nextval('puest'), 7, 4, '1A', 3, 'Bebida'),
(nextval('puest'), 7, 5, '1A', 5, 'Bebida'),
(nextval('puest'), 7, 6, '2A', 4, 'Bebida'),
(nextval('puest'), 7, 7, '2A', 4, 'Bebida'),
(nextval('puest'), 7, 8, '2A', 4, 'Bebida'),
(nextval('puest'), 7, 9, '2A', 5, 'Bebida'),
(nextval('puest'), 7, 10, '2A', 6, 'Bebida'),
(nextval('puest'), 8, 1, '1A', 3, 'Bebida'),
(nextval('puest'), 8, 2, '1A', 5, 'Bebida'),
(nextval('puest'), 8, 3, '2A', 4, 'Bebida'),
(nextval('puest'), 8, 4, '2A', 6, 'Bebida'),
(nextval('puest'), 9, 1, '1A', 3, 'Comida'),
(nextval('puest'), 9, 2, '1A', 3, 'Comida'),
(nextval('puest'), 9, 3, '1A', 3, 'Comida'),
(nextval('puest'), 9, 4, '2A', 4, 'Comida'),
(nextval('puest'), 9, 5, '2A', 4, 'Comida');
