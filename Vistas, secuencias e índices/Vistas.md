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