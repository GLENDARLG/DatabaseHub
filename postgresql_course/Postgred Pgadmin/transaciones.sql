BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100 WHERE user_id = 2;
-- Si esta instrucción falla, podemos volver al SAVEPOINT anterior
ROLLBACK TO SAVEPOINT my_savepoint;
-- Si no hay errores, confirmamos la transacción
COMMIT;


El BEGIN; es como hacer git add .
El COMMIT; es como hacer git commit -m "Comentario"
El ROLLBACK; es como hacer git rm --cached . o también git reset --mixed

BEGIN;
SELECT now();
COMMIT;

BEGIN;	
INSERT INTO public.tren(
	 modelo, capacidad)
	VALUES ( 'Model Tran', 100);
	
INSERT INTO public.estacion(
	 id, nombre, direccion)
	VALUES ( 2,'Begin', 'Tran');
COMMIT;

BEGIN TRANSACTION; -- Inicia la transacción

-- Realiza operaciones SQL aquí
UPDATE tabla SET columna = valor WHERE condición;

-- Verifica si todo está bien
IF todo_esta_bien THEN
    COMMIT; -- Confirma la transacción
ELSE
    ROLLBACK; -- Deshace la transacción
END IF;


BEGIN ;
INSERT INTO trenes(
                   modelo, capacidad)
                VALUES ('Modelo Ehdf2', 130);
INSERT INTO estaciones(
                    estacion_id, nombre, direccion)
            VALUES (50 ,'Estacion Transs', 'San Pablo');