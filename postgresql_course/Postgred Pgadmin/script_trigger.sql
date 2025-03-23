CREATE TRIGGER mitrigger
AFTER INSERT OR DELETE OR UPDATE
ON public.pasajero
FOR EACH ROW
EXECUTE PROCEDURE public.impl();

-- TRIGGER AFTER DELETE
CREATE TRIGGER AD_conteo_pasajeros
AFTER DELETE 
ON pasajero
FOR EACH ROW
EXECUTE PROCEDURE "borrarpasajero"();

-- FUNCION PARA DISMINUIR EN CASO DE ELIMINACION
CREATE OR REPLACE FUNCTION public.borrarPasajero()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	rec record:= NULL;
	contador integer:=0;
BEGIN
	FOR rec IN SELECT * FROM pasajero LOOP
		contador:= contador+1;
	END LOOP;
	INSERT INTO conteo_pasajeros (total, fecha)
	VALUES (contador, now());
	-- para que no de error de no retornar nada
	RETURN OLD;
END
$BODY$;

ALTER FUNCTION public.borrarPasajero()
    OWNER TO postgres;


CREATE OR REPLACE TABLE respaldo(
	id serial,
	antes_nombre varchar(255),
	despues_nombre varchar(255),
	fecha time with time zone default now(),
	constraint pk_respaldo PRIMARY key(id)
);
ALTER TABLE respaldo ADD accion VARCHAR(255);


CREATE OR REPLACE FUNCTION pasajeros_respaldo()
RETURNS TRIGGER AS $BODY$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO respaldo(antes_nombre, despues_nombre, accion)
		VALUES(NULL, NEW.nombre, 'REGISTRO NUEVO');
	ELSEIF (TG_OP = 'UPDATE') THEN
		INSERT INTO respaldo(antes_nombre, despues_nombre, accion)
		VALUES(OLD.nombre, NEW.nombre, 'REGISTRO ACTUALIZADO');
	ELSEIF (TG_OP = 'DELETE') THEN
		INSERT INTO respaldo(antes_nombre, despues_nombre, accion)
		VALUES(OLD.nombre, NULL, 'REGISTRO ELIMINADO');
	END IF;
	RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_personaje_respaldo
AFTER INSERT OR UPDATE OR DELETE ON pasajeros
FOR EACH ROW
EXECUTE FUNCTION pasajeros_respaldo();