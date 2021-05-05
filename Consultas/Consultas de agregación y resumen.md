# Consultas de agregación y resumen
Mostrar el precio que tiene el material utilizado en la actuación con el codigo 14
```sql
SELECT eg.cod_actuacion, SUM(m.precio*me.unidades) as "coste del material"
from escenografia eg
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON me.id_material = m.id
GROUP BY eg.cod_actuacion
HAVING eg.cod_actuacion = 14
ORDER BY eg.cod_actuacion;
```
Mostrar las tres actuaciones más caras (teniendo en cuenta el precio del material y el sueldo del artista)
```sql
SELECT eg.cod_actuacion, SUM(m.precio*me.unidades) as "coste del material"
from escenografia eg
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON me.id_material = m.id
GROUP BY eg.cod_actuacion
HAVING SUM(m.precio*me.unidades) IS NOT NULL
ORDER BY "coste del material" DESC
LIMIT 3;
```
Mostrar los preparativos necesarios para cada actuación el día 20; artista(nombre legal y tlf contacto), material, escenario (con su empleado encargado)...
NO ESTÁ TERMINADAAAAAAAAAAAAAAAAA
```sql
SELECT ar.nombrelegal artista, ar.telefono, ep.id as "id escenario", ep.empleado_encargado encargado, ag.horario, m.nombre material
from escenografia eg
	JOIN agenda ag ON ag.cod_actuacion = eg.cod_actuacion
	JOIN artista ar ON ar.id = ag.id_artista
	JOIN espacio ep ON eg.id_espacio = ep.id
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON m.id = me.id_material
where extract(day from ag.fecha) = 20
GROUP BY GROUPING SETS (ar.nombrelegal, ar.telefono, ag.horario, ep.id, ep.empleado_encargado),  (m.nombre);
```
