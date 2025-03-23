CALL public.prueba()
-- PROCEDURE: public.prueba()

-- DROP PROCEDURE IF EXISTS public.prueba();
CREATE OR REPLACE PROCEDURE public.prueba(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	rec record;
BEGIN
	FOR rec IN SELECT * FROM pasajero LOOP
		RAISE NOTICE 'un pasajero se llama %', rec.nombre;
	END LOOP;
END
$BODY$;
ALTER PROCEDURE public.prueba()
    OWNER TO grlg;


DO $$
DECLARE 
	rec record;
BEGIN
	FOR rec IN SELECT * FROM pasajero LOOP
		RAISE NOTICE 'un pasajero se llama %', rec.nombre;
	END LOOP;
END
$$;

CREATE OR REPLACE FUNCTION triangle_area(base float, hight float) 
	RETURNS real
AS
$BODY$
	DECLARE 
	area float;
	half float := 0.5;
	
	BEGIN 
		area := base*hight*half; 
		RAISE NOTICE 'The area is: %', area;
		RETURN area;
	END;
$BODY$
	LANGUAGE 'plpgsql';
	
	SELECT * FROM triangle_area(7,5);