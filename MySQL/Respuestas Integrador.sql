
/* Candado A : 
Posición: El candado A está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado A estará con formada por la/s siguientes consulta/s a la base de
datos:
Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea
centro o esté comprendida en otras posiciones.*/

SELECT MAX(Asistencias_por_partido) FROM ESTADISTICAS;

SELECT COUNT(*), Asistencias_por_partido
	FROM estadisticas WHERE 
    Asistencias_por_partido = (SELECT MAX(Asistencias_por_partido) FROM ESTADISTICAS)
GROUP BY Asistencias_por_partido;

SELECT sum(Peso)
FROM jugadores j
INNER JOIN equipos e ON e.Nombre = j.Nombre_equipo 
WHERE e.Conferencia = "East" and j.Posicion like "%C%";


/* Candado B: 
Posición: El candado B está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
jugadores que tiene el equipo Heat.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de
datos:
La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.
*/

SELECT COUNT(codigo) FROM JUGADORES WHERE Nombre_equipo ='Heat'; /*16 jugadores*/

SELECT e.Asistencias_por_partido, j.Nombre_equipo
FROM estadisticas e INNER JOIN jugadores j ON  j.codigo = e.jugador 
WHERE e.Asistencias_por_partido > (SELECT Count(*) FROM jugadores WHERE Nombre_equipo = 'Heat');

SELECT COUNT(*) AS cantidad_jugadores
FROM jugadores j INNER JOIN estadisticas e 
ON j.codigo = e.jugador
WHERE e.asistencias_por_partido > (
    SELECT COUNT(*) 
    FROM jugadores 
    WHERE nombre_equipo = 'Heat'
);

/*Clave: Conteo de partidos*/

SELECT * FROM PARTIDOS;
SELECT * FROM ESTADISTICAS;

SELECT COUNT(*) FROM PARTIDOS 
WHERE TEMPORADA LIKE '%99%';

/* CANDADO C
Posición: El candado C está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman
parte de equipos de la conferencia oeste.
Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a
195, y a eso le vamos a sumar 0.9945.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de
datos: Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de
sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
tapones por partido. Además, este resultado debe ser, donde la división sea central.*/

SELECT * FROM JUGADORES;

select count(*) as total_count
from jugadores j
inner join equipos e
on j.Nombre_equipo = e.Nombre
where j.Procedencia = "michigan" and e.Conferencia = "west";

SELECT COUNT(*) FROM JUGADORES 
WHERE PESO >=195;

SELECT 
    ( COUNT(CASE WHEN j.procedencia = 'Michigan' AND e.conferencia = 'West' THEN 1 END)
    /COUNT( CASE WHEN j.peso >= 195 THEN 1 END)
    + 0.9945 
    ) AS result
FROM jugadores j INNER JOIN equipos e 
ON j.Nombre_equipo = e.Nombre;


/*Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de
datos: Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de
sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
tapones por partido. Además, este resultado debe ser, donde la división sea central*/

SELECT FLOOR(AVG(e.Puntos_por_partido) + COUNT(e.Asistencias_por_partido) + SUM(e.Tapones_por_partido))
FROM ((equipos t INNER JOIN jugadores j
	ON t.Nombre = j.Nombre_equipo)
INNER JOIN estadisticas e ON e.jugador = j.codigo)
WHERE t.Division = 'Central';

/*Posición: El candado D está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este
resultado debe ser redondeado. Nota: el resultado debe estar redondeado
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado D estará con formada por la/s siguientes consulta/s a la base de
datos:
Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido
de todos los jugadores de procedencia argentina. */

SELECT ROUND(e.Tapones_por_partido)
FROM estadisticas e INNER JOIN jugadores j ON
	e.jugador = j.codigo
WHERE j.Nombre = 'Corey Maggette' AND e.temporada = '00/01';

SELECT ROUND(SUM(Puntos_por_partido))
FROM estadisticas e INNER JOIN jugadores j ON
	e.jugador = j.codigo
WHERE j.Procedencia = 'Argentina';
