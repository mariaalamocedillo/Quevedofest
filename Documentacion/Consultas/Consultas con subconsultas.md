# Consultas con subconsultas
Mostar los artistas que no actúan el día 20 y sí tienen un camerino asignado
```sql
SELECT nombrelegal
FROM artista
WHERE id IN (SELECT id_artista FROM camerino_artista)
	AND id NOT IN (SELECT id_artista FROM agenda WHERE fecha = '2021-05-20');
```
Mostrar los carteles donde no se ha añadido ninguna actuación
```sql
SELECT *
FROM cartel c
WHERE NOT EXISTS (SELECT DISTINCT(id_cartel) 
        FROM agenda_cartel a 
        WHERE c.id = a.id_cartel);
```
Mostrar los artistas que ganan más que cualquier banda
```sql
SELECT *
FROM artista
WHERE sueldo > ALL (SELECT sueldo FROM artista
        WHERE campoArtistico = 'Banda') 
    AND campoArtistico != 'Banda';
```
Mostar el artista más jóven (que no sea una banda) y el más mayor
```sql
SELECT nombrelegal, nombreartistico, age(fechanac)
FROM artista
where fechanac IN ((SELECT min(fechanac)    --cuya fecha de nacimiento coincide con la más antigua o la más reciente
                    FROM artista
                    WHERE campoartistico NOT LIKE'Banda'),
                (SELECT max(fechanac)
                    FROM artista
                    WHERE campoartistico NOT LIKE'Banda'));
```
Mostrar los puestos de catering que hay en el backstage
```sql
SELECT *
FROM puesto_catering
WHERE id_espacio IN (SELECT id FROM espacio 
                WHERE tipo ILIKE 'backstage');
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
WHERE id_catering IN (SELECT id FROM catering 
            WHERE servicio_gratuito IS NULL);
```
Mostrar el material de sonido que cuesta más que cualquiera de grabación
```sql
SELECT *
FROM material
WHERE precio > ANY (SELECT precio FROM material 
                WHERE tipo = 'Grabacion') 
    AND tipo = 'Sonido';
```
Mostar los distintos géneros musicales que tocarán los teloneros el dia 20
```sql
SELECT DISTINCT(genero)
FROM artista
WHERE campoartistico LIKE'telonero'
	AND id IN (SELECT id_artista FROM agenda 
                WHERE fecha = '2021-05-20');
```
Mostrar las actuaciones del segundo escenario (id) que necesitarán rótulos pirotécnicos o fuegos fríos
```sql
SELECT cod_actuacion FROM escenografia
WHERE id_espacio = 2 
AND id IN (SELECT id_escenografia FROM material_escenografia
			WHERE id_material IN (
             SELECT id FROM material 
              WHERE nombre LIKE'Fuegos frios' 
					OR nombre LIKE'Rotulos pirotecnicos'));
```
Buscar los artistas que compartan el género y campo artístico con el artista cuyo id es 1
```sql
SELECT nombreLegal, campoartistico, genero, sueldo
FROM artista
WHERE (campoartistico, genero) = (
        SELECT campoartistico, genero
        FROM artista
        WHERE id = 1)
    AND id != 1;
 ```