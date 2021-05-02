# Consultas sencillas
Mostrar un listado con los artistas que no son españoles
```sql

```
Mostar el artista más jóven (que no sea una banda) y el más mayor
```sql
SELECT nombrelegal, nombreartistico, fechanac
from artista
where fechanac IN ((SELECT min(fechanac)
                from artista
                where campoartistico not like 'Banda'),
                (SELECT max(fechanac)
                from artista
                where campoartistico not like 'Banda'));
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

```sql
```