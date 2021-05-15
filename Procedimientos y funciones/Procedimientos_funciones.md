# Procedimientos
Procedimiento que nos permite cambiar la fecha de una actuación 
```sql
create or replace procedure cambiar_fecha(
	p_cod_actuacion agenda.cod_actuacion%type,   --codigo de la actuación
   p_fecha agenda.fecha%type  --nueva fecha que quiere establecer
)
language plpgsql
as
$$
declare
   v_agenda agenda%rowtype;
begin
   -- primero comprobar si existe la actuacion
   select * from agenda
   into v_agenda
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
         raise exception 'Se produjo un error inesperado';
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
   v_agenda1 agenda%rowtype;
	v_agenda2 agenda%rowtype;
begin
   -- comprobamos si existen
   select * from agenda
   into v_agenda1
   where cod_actuacion = p_cod_actuacion1;
   raise notice 'Actuacion % (artista %) inicialmente el % horario %', v_agenda1.cod_actuacion, v_agenda1.id_artista, v_agenda1.fecha, v_agenda1.horario;
   select * from agenda
   into v_agenda2
   where cod_actuacion = p_cod_actuacion2;
   raise notice 'Actuacion % (artista %) inicialmente el % horario %', v_agenda2.cod_actuacion, v_agenda2.id_artista, v_agenda2.fecha, v_agenda2.horario;
   -- intercambiamos la fecha y hora de las actuaciones
   --actuacion 1
   update agenda
   set fecha = v_agenda2.fecha
   where cod_actuacion = p_cod_actuacion1;
   update agenda
   set horario = v_agenda2.horario
   where cod_actuacion = p_cod_actuacion1; 
   raise notice 'Actuacion % (artista %) cambiado al % horario %', p_cod_actuacion1, v_agenda1.id_artista, v_agenda2.fecha, v_agenda2.horario;
   --actiuacion 2
   update agenda
   set fecha = v_agenda1.fecha
   where cod_actuacion = p_cod_actuacion2;
   update agenda
   set horario = v_agenda1.horario
   where cod_actuacion = p_cod_actuacion2;
   raise notice 'Actuacion % (artista %) cambiado al % horario %', p_cod_actuacion2, v_agenda2.id_artista, v_agenda1.fecha, v_agenda1.horario;
   -- capturar excepciones
   exception
      when no_data_found then 
         raise notice 'La actuación % o % no existe', p_cod_actuacion1, p_cod_actuacion2;
      when others then
         raise exception 'Se produjo un error inesperado';
end;
$$
```
Procedimiento que muestra la informacion del material cuyo id es introducido; fechas de disponibilidad y cantidades sin utilizar
```sql
create or replace procedure disponibilidad_material(
	p_id_material v_material.id%type
)
language plpgsql
as
$$
declare
   v_material material%rowtype;
	v_me_unidades integer;
	v_cant_libre integer;
begin
   -- primero obtenemos la fila si existe el material
	SELECT *
	from material 
	into v_material
	WHERE id = p_id_material;
	--almacenamos la suma total de unidades que se van a usar
	SELECT SUM(unidades) from material_escenografia 
   into v_me_unidades 
   where id_material = p_id_material;
	--calculamos la cantidad de unidades que no han sido asignadas a ninguna actuación 
	SELECT v_material.cantidad - v_me_unidades 
   into v_cant_libre;   
	--mostramos la información
	if v_material.fin_disponibilidad is null then --en caso de ser fungible, no mostramos cuándo hay que devolverlo
   		raise notice 'El material % estará disponible a partir del %, y quedan % unidades sin asignar', v_material.nombre, v_material.inicio_disponibilidad, v_cant_libre;
	else
   		raise notice 'El material % estará disponible desde % hasta %, y quedan % unidades sin asignar', v_material.nombre, v_material.inicio_disponibilidad, v_material.fin_disponibilidad, v_cant_libre;
	end if;
   --capturamos las excepciones
   exception
      when no_data_found then 
         raise notice 'El material % no existe', p_id_material;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
Procedimiento que actualiza la información de un material tras la adquisición de más unidades
```sql
create or replace procedure compra_unidades(
	p_id_material v_material.id%type,     --introduce por parámetro su id y la cantidad que ha adquirido
	p_cantidad v_material.cantidad%type
)
language plpgsql
as
$$
declare
    v_material material%rowtype;
    v_cantidad_total v_material.cantidad%type;
begin
   --comprobamos que existe el material y lo almacenamos en la variable
	SELECT *
	from material m
	into v_material
	WHERE id = p_id_material;
   --calculamos la cantidad final y la almacenamos en la variable creada
   select v_material.cantidad + p_cantidad into v_cantidad_total;
   --actualizamos la tabla con la cantidad final calculada
	update material
   	set cantidad = v_cantidad_total
   	where id = p_id_material;
   --mostramos la información
   raise notice 'Cantidad de % actualizada a %', v_material.nombre, v_cantidad_total;
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
Función que devuelve el balance del coste de las actuaciones (todo el material y sueldos)
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
	SELECT SUM(a.sueldo)*COUNT(ag.*) --coste de artistas (sueldo por actuación)
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
Función que muestra el número de invitados que tiene el artista introducido por parámetro
```sql
create or replace function contar_invitados (
		p_id_artista artista.id%type
)
returns integer
language plpgsql
as
$$
declare
	v_id_artista artista.id%type;
	v_invitados integer;
begin
   -- comprobamos que exista el artista
   select id from artista
   into v_id_artista
   where id = p_id_artista;
	--contamos los invitados
	SELECT SUM(num_acompanantes) + COUNT(*)
	FROM invitaciones
	INTO v_invitados
	WHERE id_artista = p_id_artista;
	return v_invitados;
   -- capturamos las excepciones
   exception
      when no_data_found then 
         raise notice 'El material % no existe', p_id_material;
      when others then
         raise exception 'Se ha producido en un error inesperado';
     
end;
$$
```
