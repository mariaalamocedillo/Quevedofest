# Cursores
Generar una lista de los artistas que se contrataron con el género introducido por parámetro
```sql
create or replace procedure artistas_por_genero (
		p_genero artista.genero%type
)
language plpgsql
as
$$
declare
	v_artistas_genero integer := 0;
	v_artista artista%rowtype;
	cur_artista cursor for SELECT * FROM artista;
begin
	--recorremos los artistas, buscando los que coincidan con el género introducido y los mostramos de ser así
	for v_artista in cur_artista loop	
		if v_artista.genero = p_genero then
			raise notice 'Artista % (%): % de %', v_artista.nombreartistico, v_artista.nombrelegal, v_artista.campoartistico, v_artista.genero;
			v_artistas_genero := v_artistas_genero + 1;
		end if;
	end loop;
	--mostramos el total de artistas de dicho género
	raise notice 'Núm artistas de %: %', p_genero, v_artistas_genero;
exception
   when others then
     raise exception 'Se ha producido un error inesperado';
end;
$$
```
Mostrar los teloneros que tienen actuaciones asignadas con su horario
```sql
create or replace procedure teloneros_actuaciones ()
language plpgsql
as
$$
declare
	v_artista artista%rowtype;
	cur_artista cursor for SELECT * FROM artista;	
	v_agenda artista%rowtype;
	cur_agenda cursor for SELECT * FROM agenda;
begin
--recorremos cada artista para buscar el campo artístico de teloneros
	for v_artista in cur_artista loop		
		--en caso de ser teloneros, procedemos a recorrer la agenda en busca de coincidencias con su id
		if v_artista.campoartistico = 'telonero' then		
			raise notice 'Artista % (%): ', v_artista.nombreartistico, v_artista.nombrelegal;
			--recorremos su agenda
			for v_agenda in cur_agenda loop
				if v_artista.id = v_agenda.id_artista then
					raise notice '---actúa el % a las %', v_agenda.fecha, v_agenda.horario;
				end if;
			end loop;
		end if;
	end loop;
exception
   when others then
     raise exception 'Se ha producido un error inesperado';
end;
$$
```
Mostrar las redes sociales de cada artista
```sql
create or replace procedure rrss_artista ()
language plpgsql
as
$$
declare
	v_artista artista%rowtype;
	cur_artista cursor for SELECT * FROM artista;	
	v_rrss rrss_artista%rowtype;
	cur_rrss cursor for SELECT * FROM rrss_artista;
begin
	--recorremos cada artista
	for v_artista in cur_artista loop	
		raise notice 'Cuentas de % (%): ', v_artista.nombreartistico, v_artista.nombrelegal;
			--recorremos la tabla con sus redes sociales, mostrando sus cuentas (coincidiendo los id)
			for v_rrss in cur_rrss loop		
				if v_artista.id = v_rrss.id_artista then --mostramos la plataforma y nombre de la cuenta del artista donde está el cursor
					raise notice '**%: %', v_rrss.plataforma, v_rrss.nombre_cuenta;
				end if;
			end loop;
	end loop;
exception
   when others then
     raise exception 'Se ha producido un error inesperado';
end;
$$
```
Mostrar el listado de materiales según su tipo
```sql
--usamos loop y while, por lo que tendremos que abrir y cerrar los cursores, así como captarlos (FETCH)
CREATE OR REPLACE PROCEDURE listado_materiales() AS
$$
DECLARE
 reg_t RECORD;
 cur_tipo CURSOR FOR SELECT DISTINCT(tipo) FROM material;	--cursor que almacena sólo los distintos tipos de materiales que hay
 reg_m RECORD;
 cur_mat CURSOR FOR SELECT * FROM material ORDER BY tipo;
BEGIN
 OPEN cur_tipo;
 LOOP	--recorremos en un bucle loop los distintos tipos de materiales que hay
	FETCH cur_tipo INTO reg_t;
	EXIT WHEN NOT FOUND;
	RAISE NOTICE 'Material de %:', reg_t.tipo;	--mostramos el título (el tipo de material, al que le seguirá cada material de ese tipo)
	FETCH cur_mat INTO reg_m;
	--abrimos el cursor de los materiales en el loop de los tipos para recorrer los materiales por cada tipo del cursor tipos
	OPEN cur_mat;	
	--recorremos los materiales con un while	
	WHILE( FOUND ) LOOP
			if reg_m.tipo = reg_t.tipo then		--mostramos solo los materiales que comparte tipo con el cursor
				RAISE NOTICE '	%: % unidades a %€', reg_m.nombre, reg_m.cantidad, reg_m.precio;
			end if;
			FETCH cur_mat INTO reg_m;
	END LOOP;
	CLOSE cur_mat;	--cerramos el cursor de materiales
 END LOOP;
 CLOSE cur_tipo;	--cerramos el cursor de los tipos de material
END
$$
LANGUAGE 'plpgsql';
```
Mostrar toda la información de los espacios que hay en el festival según el tipo
```sql
CREATE OR REPLACE PROCEDURE listado_espacios() AS
$$
DECLARE
 v_tipos RECORD;
 cur_tipo CURSOR FOR SELECT DISTINCT(tipo) FROM espacio;	--consultamos los distintos tipos de espacios que hay en el cursor
 v_esp RECORD;
 cur_esp CURSOR FOR SELECT * FROM espacio;
BEGIN
 --recorremos los distintos tipos de espacios
 for v_tipos in cur_tipo loop		
		raise notice 'Información de %:', v_tipos.tipo;
			for v_espt in cur_esp loop	
				--mostramos la informacion de todos los espacios cuyo tipo coincida
				if v_esp.tipo = v_tipos.tipo then
					raise notice '	id % en %, encargado: %, ', v_esp.id, v_esp.localizacion, v_esp.empleado_encargado;
				end if;
			end loop;
 end loop;
END
$$
LANGUAGE 'plpgsql';
```
Borrar un material de todas las tablas dado su identificador
```sql
create or replace procedure borrar_material (
		p_id_material material.id%type
)
language plpgsql
as
$$
declare
	v_id_material material.id%type;
	v_mat_escenog material_escenografia%rowtype;
	cur_mat_escenog cursor for SELECT * FROM material_escenografia;
begin
   -- comprobamos que exista el material
   select id from material
   into v_id_material
   where id = p_id_material;
   --dado que tenemos establecido el borrado en cascada, antes debemos eliminar el material del resto de tablas(material_escenografia)
	for v_mat_escenog in cur_mat_escenog loop	--buscamos las relaciones con las actuaciones que necesitarán dicho material
		if v_mat_escenog.id_material = p_id_material then
			delete from material_escenografia
			where id_material = p_id_material;
		end if;
	end loop;   
	raise notice 'Material eliminado del resto de relaciones';
	-- borramos el material
   delete from material
   where id = p_id_material;
   raise notice 'Material eliminado correctamente';
   -- capturamos las excepciones
   exception
      when no_data_found then 
         raise notice 'El material % no existe', p_id_material;
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```
Procedimiento que comprueba todos los materiales fungibles (que se gastan según se usan), asgurándose que se han encargado las cantidades necesarias para las actuaciones que lo necesitan; en caso de tener menos cantidad que unidades necesarias, se actualiza pidiendo las unidades necesarias (con margen de seguridad para evitar otro desabastecimiento)
```sql
CREATE OR REPLACE PROCEDURE reajuste_materiales()
LANGUAGE 'plpgsql'
AS 
$$
declare
    v_material material%rowtype;
	v_me_unidades integer;
	v_cant_a_añadir integer;
	cur_material cursor for SELECT * FROM material WHERE fin_disponibilidad IS NULL;	--ponemos el cursor en los materiales que no tienen fecha de devolución
begin
	--recorremos los materiales
	for v_material in cur_material loop		
		SELECT SUM(unidades) unidades from material_escenografia 	--capturamos las cantidades del material que se usarán
		into v_me_unidades 
		where id_material = v_material.id;
		--comprobamos el material y las unidades que se usarán
		if v_material.cantidad < v_me_unidades then		--en caso de que la cantidad sea menor que las unidades usadas, procedemos a aumentar la cantidad
			SELECT ROUND(v_me_unidades*1,4) - v_material.cantidad 	--se añade un extra a la cantidad para tener cierto margen
			INTO v_cant_a_añadir;	--esta variable mostrará la cantidad que falta para conseguir las unidades necesarias
			--actualizamos la cantidad
			update material
			set cantidad = cantidad + v_cant_a_añadir	--se añade la variable a la cantidad actual
			where material.id = v_material.id;
			--mostramos una nota informativa
			raise notice 'Al material % se le añadieron % unidades, quedando en %€ más', v_material.nombre, v_cant_a_añadir, v_cant_a_añadir * v_material.precio;
		end if;
	end loop;
   -- capturamos las excepciones
   exception
      when others then
         raise exception 'Se ha producido en un error inesperado';
end;
$$
```