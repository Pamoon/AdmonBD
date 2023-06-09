-- 1 Mostrar la lista de los ganadores de medalla de oro en eventos de Futbol, Baloncesto y Golf
SELECT * FROM olympics.dbo.[event] e 
INNER JOIN olympics.dbo.competitor_event ce
ON e.id = ce.event_id
INNER JOIN olympics.dbo.medal m 
ON m.id = ce.medal_id
WHERE m.medal_name = 'Gold' AND e.event_name IN ('Futbol', 'Baloncesto', 'Golf'); 

-- 2 Cuales son los eventos que se jugaron en el año 2000
SELECT e.event_name FROM olympics.dbo.games g
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.games_id = g.id 
INNER JOIN olympics.dbo.competitor_event ce
ON ce.competitor_id = gc.id 
INNER JOIN olympics.dbo.[event] e 
ON e.id = ce.event_id
WHERE g.games_year = 2000;

-- 3 Cuales son las 20 principales ciudades donde se han jugado mas Olimpiadas
SELECT TOP 20 c.city_name, COUNT(gc.games_id) FROM olympics.dbo.games_city gc 
INNER JOIN olympics.dbo.city c 
ON c.id = gc.city_id 
GROUP BY c.city_name 
ORDER BY COUNT(gc.games_id) DESC;

-- 4 Liste los paises no tienen ningun participante en las ultimas 10 olimpiadas
SELECT TOP 10 nr.region_name FROM olympics.dbo.noc_region nr 
INNER JOIN olympics.dbo.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.dbo.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id  = p.id
LEFT JOIN olympics.dbo.games g
ON g.id = gc.games_id
WHERE g.games_year IS NULL;


-- 5 liste los 5 paises que mas ganan medallas de oro, plata y bronce
SELECT TOP 5 nr.region_name, COUNT(ce.event_id) FROM olympics.dbo.noc_region nr 
INNER JOIN olympics.dbo.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.dbo.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.dbo.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.dbo.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Gold'
GROUP BY nr.region_name ;


-- 6 El evento con mayor cantidad de personas participando
SELECT MAX(e.event_name) FROM olympics.dbo.[event] e 
INNER JOIN olympics.dbo.competitor_event ce 
ON ce.event_id = e.id ;

-- 7 Liste los deportes que en todas las olimpiadas siempre se llevan a cabo
SELECT * FROM olympics.dbo.sport s 
INNER JOIN olympics.dbo.event e 
ON e.sport_id = s.id 
INNER JOIN olympics.dbo.competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN olympics.dbo.games g ;

-- 8 Muestre la comparacion de la cantidad de veces entre los dos generos(M,F) que ganado medallas de cualquier tipo
SELECT m.medal_name, p.gender, COUNT(ce.event_id) FROM olympics.dbo.person p 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id = p.id 
INNER JOIN olympics.dbo.ceompetitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.dbo.medal m 
GROUP BY m.medal_name, p.gender ;

-- 9 Cual es la altura y peso que mas es mas frecuente en los participantes del deporte de Boxeo
SELECT MAX(p.height) AS altura, MAX(p.weight) AS peso FROM olympics.dbo.sport s 
INNER JOIN olympics.dbo.event e 
ON e.sport_id = s.id 
INNER JOIN olympics.dbo.competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN olympics.dbo.person p 
ON gc.person_id = p.id 
WHERE s.sport_name = 'Boxeo';

-- 10 Muestre los participantes menores de edad que participan en las olimpiadas
SELECT p.full_name, gc.age FROM olympics.dbo.games_competitor gc 
INNER JOIN olympics.dbo.person p 
ON p.id = gc.person_id 
WHERE gc.age < 18;

