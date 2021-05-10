# Procedimientos
Procedimiento que nos permite cambiar la fecha de una actuación 
```sql
create or replace procedure cambiar_fecha(
	p_cod_actuacion agenda.cod_actuacion%type,
   p_fecha agenda.fecha%type     --nueva fecha
)
language plpgsql
as
$$
declare
    agenda agenda%rowtype;
begin
   -- primero comprobar si existe la actuacion
   select * from agenda
   into agenda
   where cod_actuacion = p_cod_actuacion;
   -- actualizamos la fecha
   update agenda
   set fecha = p_fecha
   where cod_actuacion = p_cod_actuacion;
   raise notice 'Fecha cambiada al %', p_fecha;
   -- capturar excepciones
   exception
      when no_data_found then 
         raise notice 'La actuación % no existe', p_cod_actuacion;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
Procedimiento que dados dos códigos de actuaciones, intercambia la fecha y hora de estas (manteniendo la relación con del artista y la escenografía)
```sql
create or replace procedure reagendar_actuaciones(
	p_cod_actuacion1 agenda.id_artista%type,
   	p_cod_actuacion2 agenda.id_artista%type
)
language plpgsql
as
$$
declare
    agenda1 agenda%rowtype;
	agenda2 agenda%rowtype;
begin
   -- comprobamos si existen
   select * from agenda
   into agenda1
   where cod_actuacion = p_cod_actuacion1;
   raise notice 'Actuacion % (artista %) inicialmente el % horario %', agenda1.cod_actuacion, agenda1.id_artista, agenda1.fecha, agenda1.horario;
   select * from agenda
   into agenda2
   where cod_actuacion = p_cod_actuacion2;
   raise notice 'Actuacion % (artista %) inicialmente el % horario %', agenda2.cod_actuacion, agenda2.id_artista, agenda2.fecha, agenda2.horario;
   -- intercambiamos la fecha y hora de las actuaciones
   --actuacion 1
   update agenda
   set fecha = agenda2.fecha
   where cod_actuacion = p_cod_actuacion1;
   update agenda
   set horario = agenda2.horario
   where cod_actuacion = p_cod_actuacion1; 
   raise notice 'Actuacion % (artista %) cambiado al % horario %', p_cod_actuacion1, agenda1.id_artista, agenda2.fecha, agenda2.horario;
   --actiuacion 2
   update agenda
   set fecha = agenda1.fecha
   where cod_actuacion = p_cod_actuacion2;
   update agenda
   set horario = agenda1.horario
   where cod_actuacion = p_cod_actuacion2;
   raise notice 'Actuacion % (artista %) cambiado al % horario %', p_cod_actuacion2, agenda2.id_artista, agenda1.fecha, agenda1.horario;
   -- capturar excepciones
   exception
      when no_data_found then 
         raise notice 'La actuación % o % no existe', p_cod_actuacion1, p_cod_actuacion2;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
Procedimiento que muestra la informacion del material cuyo id es introducido; fechas de disponibilidad y cantidades sin utilizar
```sql
create or replace procedure disponibilidad_material(
	p_id_material material.id%type
)
language plpgsql
as
$$
declare
    material material%rowtype;
	v_me_unidades integer;
	v_cant_libre integer;
begin
   -- primero obtenemos la fila si existe el material
	SELECT *
	from material 
	into material
	WHERE id = p_id_material;
	
	SELECT SUM(unidades) from material_escenografia into v_me_unidades where id_material = p_id_material;
	
	SELECT material.cantidad-v_me_unidades into v_cant_libre;
	
	if material.fin_disponibilidad is null then
   		raise notice 'El material % estará disponible a partir del %, y quedan % unidades sin asignar', material.nombre, material.inicio_disponibilidad, v_cant_libre;
	else
   		raise notice 'El material % estará disponible desde % hasta %, y quedan % unidades sin asignar', material.nombre, material.inicio_disponibilidad, material.fin_disponibilidad, v_cant_libre;
	end if;
   exception
      when no_data_found then 
         raise notice 'El material % no existe', p_id_material;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
Procedimiento que actualiza un material tras la adquisición de más unidades
```sql
create or replace procedure compra_unidades(
	p_id_material material.id%type,
	p_cantidad material.cantidad%type
)
language plpgsql
as
$$
declare
    material material%rowtype;
    v_cantidad_total material.cantidad%type;
begin
   --comprobamos que existe el material
	SELECT *
	from material m
	into material
	WHERE id = p_id_material;
   --calculamos la cantidad final y la almacenamos en la variable creada
   select material.cantidad + p_cantidad into v_cantidad_total;
   --actualizamos la tabla con la cantidad final calculada
	update material
   	set cantidad = v_cantidad_total
   	where id = p_id_material;
   --mostramos la información
   raise notice 'Cantidad de % actualizada a %', material.nombre, v_cantidad_total;
   --capturamos las excepciones
   exception
      when no_data_found then 
         raise notice 'El material % no existe', p_id_material;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
# Funciones
Función que devuelve el número de puestos que hay en un espacio, dado su identificador
```sql
create or replace function puestos_espacio(
	p_id_espacio espacio.id%type
)
returns integer
language plpgsql
as
$$
declare
    v_puestos integer;
begin
   -- obtenemos el número de puestos de la tabla, dado el id del espacio
	SELECT COUNT(*) 
	FROM puesto_catering 
	INTO v_puestos
	WHERE id_espacio = p_id_espacio;
   return v_puestos;
   --capturamos la excepción
   exception
      when others then 
         return null;
end;
$$
```
Función que devuelve el balance del coste de las actuaciones (material usados o no y sueldos)
```sql
create or replace function balance_costes()
returns integer
language plpgsql
as
$$
declare
    v_costes_actuaciones integer;
	v_costes_materiales integer;
	v_total integer;
begin
   --obtenemos todos los datos necesarios respecto materiales y sueldos
	SELECT SUM(a.sueldo)*COUNT(ag.*)
	FROM artista a
		FULL OUTER JOIN agenda ag ON ag.id_artista = a.id
	INTO v_costes_actuaciones;
	
	SELECT SUM(precio * cantidad)
	FROM material
	INTO v_costes_materiales;
	--calculamos el total sumando ambas variables
	v_total := v_costes_actuaciones + v_costes_materiales;
   return v_total;
   --capturamos la excepción
   exception
      when others then 
         return null;
end;
$$
```
Función que devuelve las actuaciones que se realizarán en un escenario en el dia concretado
```sql
create or replace function actuaciones_escenario(
	p_id_espacio espacio.id%type,
	p_dia integer
)
returns integer
language plpgsql
as
$$
declare
    v_actuaciones integer;
begin
   -- obtener tiempo disponible
	SELECT COUNT(*) 
	FROM escenografia e JOIN agenda a ON a.cod_actuacion = e.cod_actuacion 
	INTO v_actuaciones
	WHERE e.id_espacio = p_id_espacio AND extract(day from a.fecha) = p_dia;
   return v_actuaciones;
end;
$$
```
