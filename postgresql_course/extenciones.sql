CREATE EXTENSION pgcrypto;

SELECT crypt('123456789', 'md5');
-- Esta función nos permite encriptar un password
-- segun la forma de encriptación

CREATEEATE EXTENSION fuzzystrmatch;
SELECT levenshtein('oswaldo', 'osvaldo')
SELECT difference('oswaldo', 'osvaldo');
SELECT difference('beard', 'bird');

--CREATE EXTENSION unaccent;
SELECT unaccent('Última acción en la academia española')

--Retorna sin acentos
Ultima accion en la academia espanola


CREATE EXTENSION fuzzystrmatch;

--Función Levenshtein:
SELECT levenshtein ('hola', 'hola'); -- regresa un valor 0
SELECT levenshtein ('hola', 'ola'); -- regresa un valor 1
SELECT levenshtein ('hola', 'olam'); -- regresa un valor 2
SELECT levenshtein ('hola', 'aloh'); -- regresa un valor 4

--Función Soundex
SELECT difference ('cat', 'moon'); -- regresa un valor 2 (sonido medio similar)
SELECT difference ('beard', 'bird'); -- regresa un valor 4 (sonido muy similar)
SELECT difference ('one', 'doctor'); -- regresa un valor 0 (sonido nada igual)


Extensiones
-- Creamos la extenxion
CREATE EXTENSION fuzzystrmatch;
-- Funcion que retorna el numero de letras que hay que cambiar para las palabras iguales. 1: True, 0: False.
SELECT levenshtein('oswaldo', 'osvaldo');
-- Funcion para saber que tan iguales suenan, manda valores de 0 a 4, 0: Nada parecido, 4: Muy parecido.
SELECT difference('oswaldo', 'osvaldo');
SELECT difference('beard', 'bird');