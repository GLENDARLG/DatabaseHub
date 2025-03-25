CREATE TABLE ordenes (
   ID serial NOT NULL PRIMARY KEY,
   info json NOT NULL
);

INSERT INTO ordenes (info)
VALUES
   (
      '{ "cliente": "David Sanchez", "items": {"producto": "Biberón","cantidad": 24}}'
   ),
   (
      '{ "cliente": "Edna Cardenas", "items": {"producto": "Carro de juguete","cantidad": 1}}'
   ),
   (
      '{ "cliente": "Israel Vazquez", "items": {"producto": "Tren de juguete","cantidad": 2}}'
   );

SELECT
   info -> 'cliente' AS cliente
FROM
   ordenes;

SELECT
   info ->> 'cliente' AS cliente
FROM
   ordenes
WHERE
   info -> 'items' ->> 'producto' = 'Biberón'