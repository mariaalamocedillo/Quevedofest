--SECUENCIAS
--ARTISTA
CREATE SEQUENCE art
INCREMENT 1
START 1;
--RRSS_ARTISTA
CREATE SEQUENCE rrss
INCREMENT 1
START 1;
--INVITACIONES
CREATE SEQUENCE cod_inv
INCREMENT 1
START 1;
--CARTELES
CREATE SEQUENCE cart
INCREMENT 1
START 1;
--AGENDA
CREATE SEQUENCE age
INCREMENT 1
START 1;
--ESPACIOS
CREATE SEQUENCE esp
INCREMENT 1
START 1;
--ESCENOGRAFIA
CREATE SEQUENCE escg
INCREMENT 1
START 1;
--MATERIAL
CREATE SEQUENCE mat
INCREMENT 1
START 1;
--CATERING
CREATE SEQUENCE cat
INCREMENT 1
START 1;
--PUESTOS_CATERING
CREATE SEQUENCE puest
INCREMENT 1
START 1;

--ÍNDICES
--
--ÁREA ARTÍSTICA
--
--RRSS_ARTISTA; FK tabla artista
CREATE INDEX rrss_artistas_artista_id_ix
ON rrss_artista(id_artista);
--INVITACIONES; FK tabla artista
CREATE INDEX invitaciones_artista_id_ix
ON invitaciones(id_artista);
--ARTISTA_CARTEL
--FK tabla artista
CREATE INDEX cartel_artistas_artista_id_ix
ON artistas_cartel(id_artista);
--FK tabla cartel
CREATE INDEX cartel_artista_cartel_id_ix
ON artistas_cartel(id_cartel);
--AGENDA; FK tabla artista
CREATE INDEX agenda_artista_id_ix
ON agenda(id_artista);
--AGENDA_CARTEL
--FK tabla artista
CREATE INDEX agenda_cartel_actuacion_cod_ix
ON agenda_cartel(cod_actuacion);
--FK tabla cartel
CREATE INDEX agenda_cartel_cartel_id_ix
ON agenda_cartel(id_cartel);
--
--ÁREA PRODUCCIÓN
--
--CAMERINO_ARTISTA
--FK tabla artista
CREATE INDEX camerino_artista_artista_id_ix
ON camerino_artista(id_artista);
--FK tabla cartel
CREATE INDEX camerino_artista_espacio_id_ix
ON camerino_artista(id_espacio);
--ESCENOGRAFÍA
--FK tabla artista
CREATE INDEX escenografia_espacio_id_ix
ON escenografia(id_espacio);
--FK tabla agenda
CREATE INDEX escenografia_actuacion_cod_ix
ON escenografia(cod_actuacion);
--MATERIAL_ESCENOGRAFÍA
--FK tabla material
CREATE INDEX material_escenografia_material_id_ix
ON material_escenografia(id_material);
--FK tabla escenografia
CREATE INDEX material_escenografia_escenografia_id_ix
ON material_escenografia(id_escenografia);
--PUESTOS_CATERING
--FK tabla catering
CREATE INDEX puesto_catering_catering_id_ix
ON puesto_catering(id_catering);
--FK table espacio
CREATE INDEX puesto_catering_espacio_id_ix
ON puesto_catering(id_espacio);