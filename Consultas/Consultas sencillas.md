# Consultas sencillas
Mostrar un listado con los artistas que no son españoles (que la primera letra del campo dni/pasaporte sea una letra)
```sql
SELECT nombrelegal, dni_pas
FROM artista
WHERE substring(dni_pas FROM 1 for 1) ~ '[^0-9]'; --si el primer caracter NO es un numero
```
Mostrar una lista con los artistas ordenado por sueldo y por edad (sin incluir las bandas)
```sql
SELECT nombrelegal, nombreartistico, extract(year FROM age(fechanac)), sueldo
FROM artista
WHERE campoartistico NOT LIKE 'Banda'
ORDER BY fechanac, sueldo;
```
Mostrar el material que más dinero ha costado (teniendo en cuenta el número de unidades compradas y el precio por unidad)
```sql
SELECT nombre, tipo, precio*cantidad "coste", descripcion
FROM material
WHERE precio*cantidad = (SELECT MAX(precio*cantidad)
        FROM material);
```
Mostrar el material que ha sido proporcionado por patrocinadores (el precio es nulo) con el tiempo que estará disponible
```sql
SELECT nombre, tipo, descripcion, proveedor, (fin_disponibilidad - inicio_disponibilidad) "tiempo disponible"
FROM material
WHERE precio IS NULL;
```
Mostrar el material que no es alquilado (no tiene fecha de devolución)
```sql
SELECT nombre, tipo, descripcion, proveedor, precio*cantidad as coste
FROM material
WHERE fin_disponibilidad IS NULL;
```
Mostrar las empresas de catering cuyo presupuesto esté entre 7000 y 14000 euros y ofrecen un servicio gratuito
```sql
SELECT empresa_encargada, servicio_gratuito
FROM catering
WHERE presupuesto BETWEEN 7000 AND 14000
		AND servicio_gratuito IS NOT NULL;
```
Mostrar las actuaciones que solo utilizan material de patrocinadores, con la empresa patrocinadora
```sql
SELECT eg.cod_actuacion, m.nombre, m.tipo, m.precio, m.proveedor
FROM escenografia eg
	JOIN material_escenografia me ON eg.id = me.id_escenografia
	JOIN material m ON me.id_material = m.id
WHERE m.precio IS NULL;
```
Mostrar los artistas que aparecen en cada cartel y tienen redes sociales
```sql
SELECT DISTINCT(a.nombrelegal), ac.id_cartel
FROM artista a
	RIGHT JOIN artistas_cartel ac ON ac.id_artista = a.id --solo los que están en los carteles
	JOIN rrss_artista rs ON rs.id_artista = a.id
ORDER BY ac.id_cartel;
```
Mostrar el material que será usado por empleados
```sql
SELECT nombre, descripcion, precio, cantidad
FROM material 
WHERE descripcion ILIKE '%técnicos%' OR descripcion ILIKE '%empleados%';
```
