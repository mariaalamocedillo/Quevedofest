# Secuencias
## Área artística
ARTISTA
```sql
CREATE SEQUENCE art
INCREMENT 1
START 1;
```
RRSS_ARTISTA
```sql
CREATE SEQUENCE rrss
INCREMENT 1
START 1;
```
INVITACIONES
```sql
CREATE SEQUENCE cod_inv
INCREMENT 1
START 1;
CARTELES
CREATE SEQUENCE cart
INCREMENT 1
START 1;
```
AGENDA
```sql
CREATE SEQUENCE age
INCREMENT 1
START 1;
```
## Área de producción
ESPACIOS
```sql
CREATE SEQUENCE esp
INCREMENT 1
START 1;
```
ESCENOGRAFIA
```sql
CREATE SEQUENCE escg
INCREMENT 1
START 1;
```
MATERIAL
```sql
CREATE SEQUENCE mat
INCREMENT 1
START 1;
```
CATERING
```sql
CREATE SEQUENCE cat
INCREMENT 1
START 1;
```
PUESTOS_CATERING
```sql
CREATE SEQUENCE puest
INCREMENT 1
START 1;
```
# Índices
## Área artística
RRSS_ARTISTA
```sql
--FK tabla artista
CREATE INDEX rrss_artistas_artista_id_ix
ON rrss_artista(id_artista);
```
INVITACIONES
```sql
--FK tabla artista
CREATE INDEX invitaciones_artista_id_ix
ON invitaciones(id_artista);
```
ARTISTA_CARTEL
```sql
--FK tabla artista
CREATE INDEX cartel_artistas_artista_id_ix
ON artistas_cartel(id_artista);
--FK tabla cartel
CREATE INDEX cartel_artista_cartel_id_ix
ON artistas_cartel(id_cartel);
```
AGENDA
```sql
--FK tabla artista
CREATE INDEX agenda_artista_id_ix
ON agenda(id_artista);
```
AGENDA_CARTEL
```sql
--FK tabla artista
CREATE INDEX agenda_cartel_actuacion_cod_ix
ON agenda_cartel(cod_actuacion);
--FK tabla cartel
CREATE INDEX agenda_cartel_cartel_id_ix
ON agenda_cartel(id_cartel);
```
## Área de producción
CAMERINO_ARTISTA
```sql
--FK tabla artista
CREATE INDEX camerino_artista_artista_id_ix
ON camerino_artista(id_artista);
--FK tabla cartel
CREATE INDEX camerino_artista_espacio_id_ix
ON camerino_artista(id_espacio);
```
ESCENOGRAFÍA
```sql
--FK tabla artista
CREATE INDEX escenografia_espacio_id_ix
ON escenografia(id_espacio);
--FK tabla agenda
CREATE INDEX escenografia_actuacion_cod_ix
ON escenografia(cod_actuacion);
```
MATERIAL_ESCENOGRAFÍA
```sql
--FK tabla material
CREATE INDEX material_escenografia_material_id_ix
ON material_escenografia(id_material);
--FK tabla escenografia
CREATE INDEX material_escenografia_escenografia_id_ix
ON material_escenografia(id_escenografia);
```
PUESTOS_CATERING
```sql
--FK tabla catering
CREATE INDEX puesto_catering_catering_id_ix
ON puesto_catering(id_catering);
--FK table espacio
CREATE INDEX puesto_catering_espacio_id_ix
ON puesto_catering(id_espacio);
```
# Vistas
Mostar toda la información sobre los preparativos de las actuaciones
```sql
CREATE OR REPLACE VIEW preparativos_actuaciones AS
SELECT ar.nombrelegal artista, ar.telefono as "tlf. artista", ep.id as "id escenario", ag.fecha, ag.horario hora, ep.empleado_encargado as "encargado de zona", m.nombre material, me.unidades 
FROM escenografia eg
	JOIN agenda ag ON ag.cod_actuacion = eg.cod_actuacion
	JOIN artista ar ON ar.id = ag.id_artista
	JOIN espacio ep ON eg.id_espacio = ep.id
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON m.id = me.id_material
ORDER BY ep.id, ag.fecha, ag.horario;
```
Informacion sobre los materiales, incluido las cantidades usadas y las disponibles, y material no asignado
```sql
SELECT m.*, COALESCE(SUM(me.unidades), 0) as "cantidad asignada", m.cantidad - SUM(me.unidades) as "cantidad disponible"
FROM material m
	left outer JOIN material_escenografia me ON me.id_material = m.id
GROUP BY m.id
ORDER BY "cantidad asignada" DESC;
```
Información de contacto y sueldo de los artistas para los pagos
```sql
CREATE OR REPLACE VIEW artistas_cobrar AS
SELECT a.nombrelegal, a.dni_pas, a.telefono, SUM(a.sueldo) * COUNT(ag.id_artista) AS "A pagar"
FROM artista a
	JOIN agenda ag ON ag.id_artista = a.id
GROUP BY a.nombrelegal, a.dni_pas, a.telefono;
```
Información sobre los camerinos (datos de encargado, lugar, si está ocupado, catering....)
```sql
CREATE OR REPLACE VIEW informacion_camerinos AS
SELECT e.id id_camerino, e.localizacion, e.empleado_encargado, COALESCE(a.nombrelegal, 'Sin asignar') artista, a.telefono as "tlf artista", pc.servicio, c.servicio_gratuito
FROM camerino_artista ca
	 JOIN artista a  ON ca.id_artista = a.id
	FULL OUTER JOIN espacio e ON e.id = ca.id_camerino AND e.tipo = 'Camerino'
	JOIN puesto_catering pc ON e.id = pc.id_espacio
	JOIN catering c ON c.id = pc.id_catering;
```
Informacion sobre los puestos de catering con sus empresas
```sql
CREATE OR REPLACE VIEW informacion_catering AS
SELECT c.empresa_encargada, c.servicio_gratuito, c.presupuesto, pc.num_puesto, pc.servicio, e.tipo, e.empleado_encargado
FROM catering c
	JOIN puesto_catering pc ON pc.id_catering = c.id
	JOIN espacio e ON pc.id_espacio = e.id;
```
