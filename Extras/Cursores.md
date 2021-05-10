# Cursores
Generar una lista de los artistas que actúan con el género introducido por parámetro
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
	for v_artista in cur_artista loop
		if v_artista.genero = p_genero then
			raise notice 'Artista % (%): % de %', v_artista.nombreartistico, v_artista.nombrelegal, v_artista.campoartistico, v_artista.genero;
			v_artistas_genero := v_artistas_genero + 1;
		end if;
	end loop;
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
	for v_artista in cur_artista loop
		if v_artista.campoartistico = 'telonero' then
			raise notice 'Artista % (%): ', v_artista.nombreartistico, v_artista.nombrelegal;
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
	for v_artista in cur_artista loop
		raise notice 'Cuentas de % (%): ', v_artista.nombreartistico, v_artista.nombrelegal;
			for v_rrss in cur_rrss loop
				if v_artista.id = v_rrss.id_artista then
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
Buscar los artistas que tocan el género concretado
```sql
CREATE OR REPLACE PROCEDURE artistas_por_genero(
	p_genero artista.genero%type
) AS
$$
DECLARE
 v_art artista%rowtype;
 cur_art CURSOR FOR SELECT * FROM artista ORDER BY genero;
BEGIN		
	raise notice 'Genero %', p_genero;
	for v_art in cur_art loop
		if v_art.genero = p_genero then
			raise notice '	Artista %; %', v_art.nombreartistico, v_art.campoartistico;
		end if;
	end loop;
END
$$
LANGUAGE 'plpgsql';
```
Mostrar el listado de materiales según su tipo
```sql
--usamos loop y while, por lo que tendremos que abrir y cerrar los cursores, así como captarlos (FETCH)
CREATE OR REPLACE PROCEDURE listado_materiales() AS
$$
DECLARE
 reg_t RECORD;
 cur_tipo CURSOR FOR SELECT DISTINCT(tipo) FROM material;	--cursor solo con los distintos tipos de materiales que hay
 reg_m RECORD;
 cur_mat CURSOR FOR SELECT * FROM material ORDER BY tipo;
BEGIN
 OPEN cur_tipo;
 LOOP
	FETCH cur_tipo INTO reg_t;
	EXIT WHEN NOT FOUND;
	RAISE NOTICE 'Material de %:', reg_t.tipo;
	FETCH cur_mat INTO reg_m;
	OPEN cur_mat;		--abrimos el cursor de los materiales en el loop de los tipos para recorrer los materiales por cada tipo del cursor tipos
	WHILE( FOUND ) LOOP
			if reg_m.tipo = reg_t.tipo then		--mostramos solo los materiales con el mismo tipo que el cursor
				RAISE NOTICE '	%: % unidades a %€', reg_m.nombre, reg_m.cantidad, reg_m.precio;
			end if;
			FETCH cur_mat INTO reg_m;
	END LOOP;
	 CLOSE cur_mat;
 END LOOP;
 CLOSE cur_tipo;
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
 cur_tipo CURSOR FOR SELECT DISTINCT(tipo) FROM espacio;
 v_espacios RECORD;
 cur_mat CURSOR FOR SELECT * FROM espacio;
BEGIN
 for v_tipos in cur_tipo loop
		raise notice 'Información de %:', v_tipos.tipo;
			for v_mat in cur_mat loop
				if v_mat.tipo = v_tipos.tipo then
					raise notice '	id % en %, encargado: %, ', v_mat.id, v_mat.localizacion, v_mat.empleado_encargado;
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
	for v_mat_escenog in cur_mat_escenog loop
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