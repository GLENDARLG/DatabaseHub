CREATE OR REPLACE FUNCTION prueba_funcion()
RETURNS void AS $$
BEGIN
	DROP TABLE IF EXISTS aaa;
	CREATE TABLE aaa (bbb char(5) CONSTRAINT firstkey PRIMARY KEY);
	
	DROP TABLE IF EXISTS aaaB;
	CREATE TABLE aaaB (bbbA char(5) CONSTRAINT secotkey PRIMARY KEY);
	
END	
$$ LANGUAGE plpgsql;

select prueba_funcion();

CREATE OR REPLACE PROCEDURE test_procedue()
LANGUAGE SQL
AS $$
	DROP TABLE IF EXISTS aaa;
	CREATE TABLE aaa (bbb char(5) CONSTRAINT firstkey PRIMARY KEY);
$$;

CALL test_procedue();


CREATE OR REPLACE FUNCTION total_movies()
RETURNS int 
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN COUNT(*) FROM peliculas;
	
END	
$$;


select total_movies();


--TRIGGER 
CREATE OR REPLACE FUNCTION duplicate_record()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO aaab (bbba)
	VALUES(NEW.bbb);
	RETURN NEW;
END	
$$;


CREATE TRIGGER aaa_changes
	BEFORE INSERT	
	ON aaa
	FOR EACH ROW
	EXECUTE PROCEDURE duplicate_record();