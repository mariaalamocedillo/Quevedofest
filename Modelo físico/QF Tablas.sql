--USAR CHEEEEEEEEEEEEEEEEEEEEEEEEEEEEEECK
--USAR CHEEEEEEEEEEEEEEEEEEEEEEEEEEEEEECK
--USAR CHEEEEEEEEEEEEEEEEEEEEEEEEEEEEEECK
--USAR CHEEEEEEEEEEEEEEEEEEEEEEEEEEEEEECK


--SEQUENCIAS
CREATE SEQUENCE escg1
INCREMENT 1
START 0;

--
-- Tabla: ARTISTA
--
CREATE TABLE artista (
  	id int NOT NULL,
  	DNI/PAS char(9) NOT NULL DEFAULT '',
	nombreLegal varchar(30) NOT NULL,
	nombreArtistico varchar(15) NOT NULL, 
	fechaNac date NOT NULL,
	campoArtistico varchar(15),
	telefono bigint DEFAULT NULL,
	sueldo numeric(10,0),
  CONSTRAINT artista_pk PRIMARY KEY id,
  CONSTRAINT artista_dni_ux UNIQUE (dni) 
);
--
-- Tabla: CARTEL 	
-- 
CREATE TABLE cartel (
  	id int NOT NULL,
  	web varchar(60),
	precio_entrada int,
	fecha_festival date NOT NULL,
  CONSTRAINT artista_pk PRIMARY KEY id
);

--
-- Tabla: ESCENOGRAFÍA 
--
CREATE TABLE escenografia (
	id int NOT NULL,
  	id_espacio int NOT NULL,
  	cod_actuacion int NOT NULL,
  	CONSTRAINT id PRIMARY KEY escenografia_pk
	CONSTRAINT escenografia_espacio_id_fk FOREIGN KEY (id_espacio) 
    	REFERENCES espacio(id),
	CONSTRAINT escenografia_cod_actuacion_fk FOREIGN KEY (cod_actuacion) 
    	REFERENCES agenda(cod_actuacion),
);
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
--
-- Tabla: INVITACIONES
--
CREATE TABLE invitaciones (
  	codigo int NOT NULL,
	nombre varchar(30) NOT NULL,
	num_acompanantes int DEFAULT 0,
	permisos NOT NULL DEFAULT 'Basico'
  CONSTRAINT invitaciones_pk PRIMARY KEY codigo
    CONSTRAINT invitaciones_permisos_ck CHECK (permisos IN ('Basico','VIP','Total')),
);
--
-- Tabla: INVITACIONES_ARTISTA
--
CREATE TABLE invitaciones_artista (
	cod_invitacion int NOT NULL,
	id_artista int NOT NULL,
	  CONSTRAINT invit_artist_invitacion_cod_fk FOREIGN KEY (cod_invitacion) 
    REFERENCES invitaciones(codigo),
	  CONSTRAINT invit_artist_artista_id_fk FOREIGN KEY (id_artista) 
    REFERENCES artista(id)
);
--
-- Tabla: AGENDA
--
CREATE TABLE agenda (
  	cod_actuacion int NOT NULL,
	id_artista int NOT NULL,
	fecha date NOT NULL,
	horario time,
  CONSTRAINT agenda_pk PRIMARY KEY cod_actuacion,
	CONSTRAINT agenda_telonero_id_fk FOREIGN KEY (id_artista) 
    REFERENCES artista(id)
);
--
-- Tabla: AGENDA_CARTEL
--
CREATE TABLE artistas_cartel (
	id_cartel INT NOT NULL,
	cod_actuacion INT NOT NULL,
	CONSTRAINT agenda_cartel_pk PRIMARY KEY (id_cartel, cod_actuacion),
	CONSTRAINT age_cart_cartel_id_fk FOREIGN KEY (id_cartel) 
        REFERENCES cartel(id),
	CONSTRAINT age_cart_agenda_id_fk FOREIGN KEY (cod_actuacion) 
        REFERENCES agenda(cod_actuacion) 
);

--
-- Tabla: MATERIAL_ESCENOGRAFÍA 
--
CREATE TABLE material_escenografia (
	id_material int NOT NULL,
	id_escenografia NOT NULL,
	  CONSTRAINT mat_esc_material_id_fk FOREIGN KEY (id_material) 
    REFERENCES material (id),
	  CONSTRAINT mat_esc_escenografia_id_fk FOREIGN KEY (id_escenografia) 
    REFERENCES escenografia (id)
);