# Consultas de agregación y resumen
Mostrar el precio que tiene el material utilizado en la actuación con el codigo 14
```sql
SELECT eg.cod_actuacion, SUM(m.precio*me.unidades) as "coste del material"
FROM escenografia eg
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON me.id_material = m.id
GROUP BY eg.cod_actuacion
HAVING eg.cod_actuacion = 14
ORDER BY eg.cod_actuacion;
```
Mostrar el número total de invitados de artistas que habrá
```sql
SELECT SUM(num_acompanantes) + COUNT(*) as "Total de invitados"
FROM invitaciones;
```
Mostrar las tres actuaciones más caras (teniendo en cuenta el precio del material y el sueldo del artista)
```sql
SELECT eg.cod_actuacion, COALESCE(SUM(m.precio*me.unidades)::text, 'Sin material') as "coste del material",
		a.sueldo as "sueldo artista", COALESCE(SUM(m.precio*me.unidades) + a.sueldo, a.sueldo) as "total"
FROM escenografia eg
	FULL OUTER JOIN material_escenografia me ON eg.id = me.id_escenografia
	FULL OUTER JOIN material m ON me.id_material = m.id
	JOIN agenda ag ON eg.cod_actuacion = ag.cod_actuacion
	JOIN artista a ON ag.id_artista = a.id
GROUP BY eg.cod_actuacion, a.sueldo
ORDER BY "total" DESC
LIMIT 3;
```
Mostrar el artista principal, el telonero y la banda  que más va a cobrar (teniendo en cuenta el numero de actuaciones y su sueldo por actuacion)
```sql
--Principal que más cobra
SELECT nombrelegal, nombreartistico, sueldo
FROM artista
WHERE sueldo = (SELECT max(sueldo) FROM artista) AND campoartistico LIKE 'Banda';
--Banda que más cobra
SELECT nombrelegal, nombreartistico, sueldo
FROM artista
WHERE sueldo = (SELECT max(sueldo) FROM artista) AND campoartistico NOT LIKE 'Banda';
--Telonero que más cobra
SELECT nombrelegal, nombreartistico, sueldo
FROM artista
WHERE sueldo = (SELECT max(sueldo) FROM artistaWHEREcampoartistico ILIKE 'telonero');
```
Mostrar la media del coste del material y la suma total
```sql
SELECT TRUNC(AVG(precio*cantidad), 2) as "media coste", SUM(precio*cantidad) as "total"
FROM material;
```
Mostrar el coste medio de sueldo de los artistas redondeado a la alza
```sql
SELECT CONCAT(CEIL(AVG(sueldo)), '€') as "Sueldo medio"
FROM artista;
```
Mostrar el coste total de los materiales agrupados por tipo que no proveen patrocinadores
```sql
SELECT tipo, SUM(precio*cantidad) coste
FROM material
WHERE precio IS NOT NULL
GROUP BY tipo
order by tipo;
```
Mostrar los patrocinadores que proporcionan más de un material
```sql
SELECT proveedor 
FROM material 
where precio is null
group by proveedor
having count(*) > 1;
```
Mostar la edad media de los artistas contratados
```sql
SELECT AVG(EXTRACT(year FROM AGE(fechanac)))
FROM artista;
```
Hacer un resumen de los costes de materiales ordenados por tipos, con un balance del coste total de dicho tipo de material
```sql
SELECT tipo, nombre, SUM(precio*cantidad) coste
FROM material
WHERE precio IS NOT NULL
GROUP BY rollup ((tipo),(nombre))
order by tipo, nombre, "coste";
```
Realizar un balance del coste que supondrán los artistas teniendo en cuenta el género y la cantidad de actuaciones
```sql
SELECT genero, nombreartistico, SUM(a.sueldo)*COUNT(ag.*) sueldo
FROM artista a
	JOIN agenda ag ON a.id = ag.id_artista
GROUP BY rollup ((genero),(nombreartistico))
order by genero;
```