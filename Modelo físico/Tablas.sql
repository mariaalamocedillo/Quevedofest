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
--
-- Tabla: CAMERINO_ARTISTA
--
CREATE TABLE camerino_artista (
	id_camerino INT NOT NULL,
	id_artista INT NOT NULL,
	CONSTRAINT camerino_artista_pk PRIMARY KEY (id_camerino, id_artista),
	CONSTRAINT camerino_artista_espacio_id_fk FOREIGN KEY (id_camerino) 
        REFERENCES espacio(id),
	CONSTRAINT camerino_artista_artista_id_fk FOREIGN KEY (id_artista) 
        REFERENCES artista(id)
);
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
--
-- Tabla: PUESTOS_CATERING
--
CREATE TABLE puesto_catering (
	id INT NOT NULL, 
	id_catering INT NOT NULL,
	num_puesto INT NOT NULL,
	lugar_asignado char(2) NOT NULL,
		id_espacio INT NOT NULL,
	servicio varchar(10) NOT NULL,
	CONSTRAINT puesto_catering_pk PRIMARY KEY (id),
	CONSTRAINT puesto_catering_catering_id_fk FOREIGN KEY (id_catering) 
        REFERENCES catering(id),
    CONSTRAINT puesto_catering_lugar_ck CHECK (lugar_asignado IN ('1A', '2A', '1B', '2B')),
	CONSTRAINT espacio_puesto_espacio_id_fk FOREIGN KEY (id_espacio) 
        REFERENCES espacio(id),
	CONSTRAINT puesto_catering_servicio_ck CHECK (servicio IN ('Comida', 'Bebida', 'Mixto'))
);
CREATE SEQUENCE puest
INCREMENT 1
START 1;
