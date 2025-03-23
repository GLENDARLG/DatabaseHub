SELECT * FROM pasajero
JOIN viaje ON (viaje.id_pasajero = pasajero.id);

SELECT * FROM pasajero
LEFT JOIN viaje ON (viaje.id_pasajero = pasajero.id)
WHERE viaje.id IS NULL;

SELECT * FROM tren
LEFT JOIN trayecto ON (tren.id = trayecto.id_tren);


SELECT * FROM tren
RIGHT JOIN trayecto ON (tren.id = trayecto.id_tren);

SELECT * FROM tren
LEFT JOIN trayecto ON (tren.id = trayecto.id_tren)
WHERE trayecto.id IS NULL;