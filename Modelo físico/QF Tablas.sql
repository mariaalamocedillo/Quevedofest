--ÁREA ARTÍSTICA
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
-- Tabla: RRSS_ARTISTA
--
CREATE TABLE rrss_artista (
  	id int NOT NULL,
  	id_artista int NOT NULL,
	plataforma varchar(10) NOT NULL
	nombre_cuenta varchar(30) NOT NULL,
  CONSTRAINT rrss_artista_pk PRIMARY KEY id,
  CONSTRAINT rrss_artista_id_fk FOREIGN KEY (id_artista) 
        REFERENCES artista(id) 
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
	id_artista int NOT NULL,
	nombre varchar(30) NOT NULL,
	num_acompanantes int DEFAULT 0,
	permisos NOT NULL DEFAULT 'Basico',
  CONSTRAINT invitaciones_pk PRIMARY KEY (codigo, id_artista),
  CONSTRAINT invitaciones_artista_id_fk FOREIGN KEY (id_artista) 
    REFERENCES artista(id),
  CONSTRAINT invitaciones_permisos_ck CHECK (permisos IN ('Basico','VIP','Total')),	  
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
-- Tabla: ESCENOGRAFÍA 
--
CREATE TABLE escenografia (
	id int NOT NULL,
  	id_espacio int NOT NULL,
  	cod_actuacion int NOT NULL,
  	CONSTRAINT escenografia_pk PRIMARY KEY id
	CONSTRAINT escenografia_espacio_id_fk FOREIGN KEY (id_espacio) 
    	REFERENCES espacio(id),
	CONSTRAINT escenografia_cod_actuacion_fk FOREIGN KEY (cod_actuacion) 
    	REFERENCES agenda(cod_actuacion),
);
--
-- Tabla: MATERIAL
--
CREATE TABLE material (
	id int NOT NULL,
	tipo varchar(12) NOT NULL DEFAULT 'Otros',
	precio numeric(10,0) DEFAULT 0,
	inicio_disponibilidad TIMESTAMP NOT NULL, --TIMESTAMP '2004-10-19 10:23:54'
	fin_disponibilidad TIMESTAMP NOT NULL,
	proveedor varchar(20) NOT NULL,
	cantidad int NOT NULL DEFAULT 1, --mínimo ordenarán una unidad
	almacenaje char(2) NOT NULL DEFAULT 'EU',
	descripcion varchar(50),
  	CONSTRAINT material_pk PRIMARY KEY id,
    CONSTRAINT material_tipo_ck CHECK (tipo IN ('Iluminacion','Sonido','Atrezo','Imagen','Grabacion','Otros')),
    CONSTRAINT material_almacen_ck CHECK (almacenaje IN ('1B', '2B', 'EU'))--EU indica que está en uso(por ejemplo, material básico de los escenarios, que no se puede almacenar porque debe estar siempre montado)
);

--
-- Tabla: MATERIAL_ESCENOGRAFÍA 
--
CREATE TABLE material_escenografia (
	id_material int NOT NULL,
	id_escenografia int NOT NULL,
	CONSTRAINT material_escenografia_pk PRIMARY KEY (id_material, id_escenografia),
	  CONSTRAINT mat_esc_material_id_fk FOREIGN KEY (id_material) 
    REFERENCES material (id),
	  CONSTRAINT mat_esc_escenografia_id_fk FOREIGN KEY (id_escenografia) 
    REFERENCES escenografia (id)
);
--
-- Tabla: ESPACIO
--
CREATE TABLE espacio (
	id int NOT NULL,
	tipo varchar(12) NOT NULL,
	empleado_encargado varchar(30) NOT NULL, --el nombre del encargado
	localizacion char(2) NOT NULL,
  	CONSTRAINT espacio_pk PRIMARY KEY id,
    CONSTRAINT espacio_tipo_ck CHECK (tipo IN ('Escenario','Backstage','Camerino','Gradas')),
    CONSTRAINT espacio_localizacion_ck CHECK (localizacion IN ('1A', '2A', '1B', '2B'))
);

--
-- Tabla: CATERING
--
CREATE TABLE catering (
	id INT NOT NULL, 
	empresa_encargada varchar(10) NOT NULL,
	presupuesto numeric(10,0) NOT NULL,
	CONSTRAINT puesto_catering_pk PRIMARY KEY id
);
--
-- Tabla: PUESTOS_CATERING
--
CREATE TABLE puesto_catering (
	id INT NOT NULL, 
	id_catering INT NOT NULL,
	num_puesto INT NOT NULL,
	lugar_asignado char(2) NOT NULL,
	servicio varchar(10) NOT NULL,
	servicio_gratuito varchar(20),
	CONSTRAINT puesto_catering_pk PRIMARY KEY id,
	CONSTRAINT puesto_catering_catering_id_fk FOREIGN KEY (id_catering) 
        REFERENCES catering(id),
    CONSTRAINT puesto_catering_lugar_ck CHECK (lugar_asignado IN ('1A', '2A', '1B', '2B')),
	CONSTRAINT puesto_catering_servicio_ck CHECK (localizacion IN ('Comida', 'Bebida', 'Mixto'))
);
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


--OTROS
--
-- EJ SEQUENCIAS
--
CREATE SEQUENCE art
INCREMENT 1
START 0;