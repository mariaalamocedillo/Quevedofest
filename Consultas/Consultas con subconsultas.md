# Consultas con subconsultas
Mostar los artistas que no actúan el día 20 y sí tienen un camerino asignado
```sql
SELECT nombrelegal
FROM artista
WHERE id IN (SELECT id_artista FROM camerino_artista)
	AND id NOT IN (SELECT id_artista FROM agenda WHERE fecha = '2021-05-20');
```
Mostar el artista más jóven (que no sea una banda) y el más mayor
```sql
SELECT nombrelegal, nombreartistico, age(fechanac)
from artista
where fechanac IN ((SELECT min(fechanac)
                from artista
                where campoartistico not like 'Banda'),
                (SELECT max(fechanac)
                from artista
                where campoartistico not like 'Banda'));
```
Mostrar los puestos de catering que hay en el backstage
```sql
SELECT *
FROM puesto_catering
WHERE id_espacio IN (SELECT id FROM espacio WHERE tipo ilike 'backstage');
```
Mostrar el presupuesto y la empresa de los cátering que ofrecen servicios a camerinos
```sql
SELECT presupuesto, empresa_encargada
FROM catering
WHERE id IN (
    SELECT id_catering 
    FROM puesto_catering 
    WHERE id_espacio IN (
        SELECT id 
        FROM espacio 
        WHERE tipo LIKE 'Camerino'));
```
Mostrar los puestos de catering cuya empresa no ofrece servicios gratuitos
```sql
SELECT *
FROM puesto_catering
WHERE id_catering IN (SELECT id 
    FROM catering 
    WHERE servicio_gratuito IS NULL);
```
Mostar los distintos géneros musicales que tocarán los teloneros el dia 20
```sql
SELECT DISTINCT(genero)
FROM artista
WHERE campoartistico like 'telonero'
	AND id IN (SELECT id_artista FROM agenda WHERE fecha = '2021-05-20');
```
Mostrar las actuaciones del segundo escenario (id) que necesitarán rótulos pirotécnicos o fuegos fríos
```sql
SELECT cod_actuacion FROM escenografia
WHERE id_espacio = 2 
AND id IN (SELECT id_escenografia FROM material_escenografia
			 WHERE id_material IN 
             (SELECT id FROM material 
             WHERE nombre like 'Fuegos frios' 
					OR nombre like 'Rotulos pirotecnicos'));
```
