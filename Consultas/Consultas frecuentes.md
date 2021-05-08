# Consultas frecuentes
Mostrar los artistas con los invitados que pueden acceder a los camerinos (VIP), con el número de acompañantes y el camerino de dicho artista
```sql
SELECT ar.nombrelegal artista, i.nombre invitado, i.num_acompanantes acompañantes, ca.id_camerino
FROM artista ar 
	JOIN invitaciones i ON ar.id = i.id_artista
	JOIN camerino_artista ca ON ar.id = ca.id_artista
WHERE i.permisos = 'VIP';
```
Mostrar los teloneros que no aparecen en carteles
```sql
SELECT ar.nombrelegal, ac.id_cartel
FROM artista ar
 LEFT JOIN artistas_cartel ac ON ar.id = ac.id_artista
WHERE campoartistico ilike 'telonero' AND ac.id_artista IS NULL;
```
Mostrar los teloneros que actuarán el día 20 según escenario, con horarios y sueldo
```sql
SELECT ar.nombrelegal, ar.sueldo, ag.fecha, ag.horario
FROM artista ar
	JOIN agenda ag ON ar.id = ag.id_artista
WHERE ar.campoartistico ilike 'telonero' AND ag.fecha = '2021-05-20';
```
Mostrar el material que ha sido almacenado, con su ubicación, que sea alquilado
```sql
SELECT nombre, tipo, proveedor, almacenaje, fin_disponibilidad
FROM material
WHERE almacenaje != 'EU' AND fin_disponibilidad IS NOT NULL;
```
Mostar la lista empresas de catering y empleados encargados por sector
```sql
SELECT pc.lugar_asignado sector, c.empresa_encargada, e.empleado_encargado
FROM catering c
	JOIN puesto_catering pc ON c.id = pc.id_catering
	JOIN espacio e ON e.id = pc.id_espacio
GROUP BY e.empleado_encargado, c.empresa_encargada, pc.lugar_asignado
ORDER BY pc.lugar_asignado;
```
Mostrar los servicios gratuitos por sector, con la empresa encargada y su presupuesto
```sql
SELECT pc.lugar_asignado, c.servicio_gratuito, c.presupuesto
FROM catering c
	JOIN puesto_catering pc ON c.id = pc.id_catering
GROUP BY pc.lugar_asignado, c.servicio_gratuito, c.presupuesto;
```
Mostar cada artista con su camerino asignado, así como los camerinos no asignados y los artistas sin camerinos
```sql
SELECT COALESCE(a.nombrelegal, 'Sin asignar') artista, COALESCE(e.id::text, 'Sin camerino') id_camerino
FROM camerino_artista c
	FULL OUTER JOIN artista a  ON c.id_artista = a.id
	FULL OUTER JOIN espacio e ON e.id = c.id_camerino AND e.tipo = 'Camerino';
```
Mostrar los preparativos necesarios para cada actuación el día 20; artista(nombre legal y tlf contacto), material, escenario (con su empleado encargado)...
```sql
SELECT ar.nombrelegal artista, ar.telefono, ep.id as "id escenario", ep.empleado_encargado encargado, ag.horario, m.nombre material
from escenografia eg
	JOIN agenda ag ON ag.cod_actuacion = eg.cod_actuacion
	JOIN artista ar ON ar.id = ag.id_artista
	JOIN espacio ep ON eg.id_espacio = ep.id
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON m.id = me.id_material
where extract(day from ag.fecha) = 20;
```