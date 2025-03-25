SELECT
	peliculas.pelicula_id AS id,
	peliculas.titulo,
	COUNT(*) AS numero_rentas,
	ROW_NUMBER () OVER (
		order by COUNT(*) DESC
   	) AS lugar
FROM	rentas
	INNER JOIN inventarios ON rentas.inventario_id = inventarios.inventario_id
	INNER JOIN peliculas ON inventarios.pelicula_id = peliculas.pelicula_id
GROUP BY peliculas.pelicula_id
ORDER BY numero_rentas DESC
LIMIT 10;

----- actuliza precios 
SELECT	peliculas.pelicula_id,
		tipos_cambio.tipo_cambio_id,
		tipos_cambio.cambio_usd * peliculas.precio_renta AS precio_mxn
FROM	peliculas,
 		tipos_cambio
WHERE 	tipos_cambio.codigo = 'MXN';

-- update_precio_tipo_cambio
BEGIN
	INSERT INTO precio_peliculas_tipo_cambio (
		pelicula_id,
		tipo_cambio_id,
		precio_tipo_cambio,
		ultima_actualizacion
	)
	SELECT	NEW.pelicula_id,
		tipos_cambio.tipo_cambio_id,
		tipos_cambio.cambio_usd * NEW.precio_renta AS precio_tipo_cambio,
		CURRENT_TIMESTAMP
	FROM tipos_cambio
	WHERE 	tipos_cambio.codigo = 'MXN';
	RETURN NEW;
END

CREATE TRIGGER trigger_update_tipos_cambio
    AFTER INSERT OR UPDATE
    ON public.peliculas
    FOR EACH ROW
    EXECUTE PROCEDURE public.update_precio_tipo_cambio();

--rangos

SELECT
	peliculas.pelicula_id AS id,
	peliculas.titulo,
	COUNT(*) AS numero_rentas,
	ROW_NUMBER () OVER (
		order by COUNT(*) DESC
   	) AS lugar
FROM	rentas
	INNER JOIN inventarios ON rentas.inventario_id = inventarios.inventario_id
	INNER JOIN peliculas ON inventarios.pelicula_id = peliculas.pelicula_id
GROUP BY peliculas.pelicula_id
ORDER BY numero_rentas DESC
LIMIT 10;

SELECT
	peliculas.pelicula_id AS id,
	peliculas.titulo,
	COUNT(*) AS numero_rentas,
	PERCENT_RANK () OVER (
		ORDER BY COUNT(*) ASC
   	) AS lugar
FROM	rentas
	INNER JOIN inventarios ON rentas.inventario_id = inventarios.inventario_id
	INNER JOIN peliculas ON inventarios.pelicula_id = peliculas.pelicula_id
GROUP BY peliculas.pelicula_id
ORDER BY numero_rentas DESC;

SELECT
	peliculas.pelicula_id AS id,
	peliculas.titulo,
	COUNT(*) AS numero_rentas,
	DENSE_RANK () OVER (     
		ORDER BY COUNT(*) DESC
   	) AS lugar
FROM	rentas
	INNER JOIN inventarios ON rentas.inventario_id = inventarios.inventario_id
	INNER JOIN peliculas ON inventarios.pelicula_id = peliculas.pelicula_id
GROUP BY peliculas.pelicula_id
ORDER BY numero_rentas DESC;

---datos geograficoa
SELECT	ciudades.ciudad_id,
		ciudades.ciudad,
		COUNT(*) AS rentas_por_ciudad
FROM	ciudades
	INNER JOIN direcciones ON ciudades.ciudad_id = direcciones.ciudad_id
	INNER JOIN tiendas ON tiendas.direccion_id = direcciones.direccion_id
	INNER JOIN inventarios ON inventarios.tienda_id = tiendas.tienda_id
	INNER JOIN rentas ON inventarios.inventario_id = rentas.inventario_id
GROUP BY	ciudades.ciudad_id;