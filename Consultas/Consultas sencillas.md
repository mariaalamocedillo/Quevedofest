# Consultas sencillas
Mostrar un listado con los artistas que no son españoles (que la primera letra del campo dni/pasaporte sea una letra)
```sql
SELECT nombrelegal, dni_pas
FROM artista
WHERE substring(dni_pas from 1 for 1) ~ '[^0-9]';
```
Mostrar una lista con los artistas ordenado por sueldo y por edad (no incluir las bandas)
```sql
SELECT nombrelegal, nombreartistico, extract(year from age(fechanac)), sueldo
from artista
where campoartistico not like 'Banda'
ORDER BY fechanac, sueldo;
```
Mostrar el material que más dinero ha costado (teniendo en cuenta el número de unidades compradas y el precio por unidad)
```sql
SELECT nombre, tipo, precio*cantidad "coste", descripcion
from material
where precio*cantidad = (SELECT MAX(precio*cantidad)
        from material);
```
Mostrar el material que ha sido proporcionado por patrocinadores (el precio es nulo) con el tiempo que estará disponible
```sql
SELECT nombre, tipo, descripcion, proveedor, (fin_disponibilidad - inicio_disponibilidad) "tiempo disponible"
from material
where precio IS NULL;
```
Mostrar el material que no es alquilado (no tiene fecha de devolución)
```sql
SELECT nombre, tipo, descripcion, proveedor, precio*cantidad as coste
from material
where fin_disponibilidad IS NULL;
```
Mostrar las actuaciones que solo utilizan material de patrocinadores, con la empresa que patrocina
```sql
SELECT eg.cod_actuacion, m.nombre, m.tipo, m.precio, m.proveedor
from escenografia eg
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON me.id_material = m.id
WHERE m.precio IS NULL;
```
Mostrar los artistas que aparecen en cada cartel y tienen redes sociales
```sql
SELECT DISTINCT(a.nombrelegal), ac.id_cartel
FROM artista a
RIGHT JOIN artistas_cartel ac ON ac.id_artista = a.id
JOIN rrss_artista rs ON rs.id_artista = a.id
order by ac.id_cartel;
```
Mostrar el material que será usado por empleados
```sql
SELECT *
FROM material 
WHERE descripcion ILIKE '%técnicos%' OR descripcion ILIKE '%empleados%';
```
