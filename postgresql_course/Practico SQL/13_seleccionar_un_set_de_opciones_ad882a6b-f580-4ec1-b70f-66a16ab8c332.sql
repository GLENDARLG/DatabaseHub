/**
  * RETO: Presentar la segunda mitad de la tabla.
  */
SELECT ROW_NUMBER() OVER() AS row_id, *
FROM platzi.alumnos
OFFSET (
	SELECT COUNT(*)/2
	FROM platzi.alumnos
);


/**
  * Seleccionar resultados en un set
  */

-- In array --
SELECT  *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM platzi.alumnos
) AS alumnos_with_row_num
WHERE row_id IN (1,2,3,4,5);

-- In con subquery --
SELECT  *
FROM platzi.alumnos
WHERE id IN (
    SELECT id
    FROM platzi.alumnos
    WHERE tutor_id = 30
);