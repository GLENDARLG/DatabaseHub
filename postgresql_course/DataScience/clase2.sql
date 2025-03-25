CREATE OR REPLACE FUNCTION movies_stats()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
	total_rated_r REAL := 0.0;
	total_lager_than_100 REAL := 0.0;
	total_published_2006 REAL := 0.0;
	avg_duration REAL := 0.0;
	avg_rental_price  REAL := 0.0;
BEGIN
    total_rated_r :=  COUNT(*) FROM peliculas WHERE clasificacion ='R';
	total_lager_than_100 :=  COUNT(*) FROM peliculas WHERE duracion > 100;
	total_published_2006 :=  COUNT(*) FROM peliculas WHERE anio_publicacion = 2006;
	avg_duration :=  AVG(duracion) FROM peliculas;
	avg_rental_price :=  AVG(precio_renta) FROM peliculas;
	
	TRUNCATE TABLE peliculas_estadisticas;

	INSERT INTO public.peliculas_estadisticas(tipo_estadistica, total)
		VALUES
		       ('clasificacion r', total_rated_r),
			   ('mas de 100 minutos', total_lager_than_100),
		       ('publicadas en 2006', total_published_2006),
		       ('promedio de duracion', avg_duration),
		       ('precio promedio de renta', avg_rental_price);
	
END	
$$;

SELECT movies_stats();
