# Procedimientos
Procedimiento que nos permite cambiar la fecha de una actuación 
```sql
create or replace procedure cambiar_fecha(
	p_cod_actuacion agenda.cod_actuacion%type,
   	p_fecha agenda.fecha%type
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
Procedimiento que dados dos códigos de actuaciones, intercambia la fecha y hora de estas (así se mantiene la relación con del artista y la escenografía)
```sql
create or replace procedure intercambiar_actuaciones(
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
   raise notice 'Artista % inicialmente en %, hora: %', agenda1.id_artista, agenda1.cod_actuacion, agenda1.horario;
   select * from agenda
   into agenda2
   where cod_actuacion = p_cod_actuacion2;
    raise notice 'Artista % inicialmente en %, hora: %', agenda2.id_artista, agenda2.cod_actuacion, agenda2.horario;
   -- intercambiamos los artistas de las actuaciones
   update agenda
   set fecha = agenda2.fecha
   where cod_actuacion = p_cod_actuacion1;
   
   update agenda
   set horario = agenda2.horario
   where cod_actuacion = p_cod_actuacion1; 
   
   update agenda
   set fecha = agenda1.fecha
   where cod_actuacion = p_cod_actuacion2;
   
   update agenda
   set horario = agenda1.horario
   where cod_actuacion = p_cod_actuacion2;
   -- capturar excepciones
   exception
      when no_data_found then 
         raise notice 'La actuación % o % no existe', p_cod_actuacion1, p_cod_actuacion2;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```