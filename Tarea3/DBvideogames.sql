-- 1 Mostrar la lista de juegos con el genero
SELECT g.game_name, g2.genre_name FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.genre g2 
ON g.genre_id = g2.id ;

-- 2 Mostrar la lista de juegos que tiene cada Plataforma
SELECT g.game_name, p.platform_name FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
INNER JOIN video_games.dbo.platform p 
ON p.id = gp2.platform_id ;

-- 3 Mostrar los juegos lanzados antes del año 2000
SELECT g.game_name FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
WHERE gp2.release_year < 2000;

-- 4 Mostrar los juegos mas vendidos en Europa
SELECT g.game_name, r.region_name FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
INNER JOIN video_games.dbo.region_sales rs
ON rs.game_platform_id = gp2.id 
INNER JOIN video_games.dbo.region r 
ON r.id = rs.region_id 
WHERE r.region_name = 'Europe';

-- 5 Mostrar los juegos con ventas menores al 0.5 de la plataforma Wii durante la decada del 2000
SELECT g.game_name  FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
INNER JOIN video_games.dbo.region_sales rs
ON rs.game_platform_id = gp2.id 
INNER JOIN video_games.dbo.platform p 
ON p.id = gp2.platform_id 
WHERE rs.num_sales < 0.5 AND p.platform_name = 'Wii' AND gp2.release_year >= 2000 AND gp2.release_year <= 2010;

-- 6 Mostrar la lista de juegos de PlayStation
SELECT g.game_name, p.publisher_name FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.publisher p 
ON p.id = gp.publisher_id 
WHERE p.publisher_name = 'PlayStation';

-- 7 Cuales son los 5 generos de juego que mas se venden en Europa
SELECT TOP 5 g2.genre_name, rs.num_sales  FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.genre g2 
ON g2.id = g.genre_id 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
INNER JOIN video_games.dbo.region_sales rs
ON rs.game_platform_id = gp2.id 
INNER JOIN video_games.dbo.region r 
ON r.id = rs.region_id 
WHERE r.region_name = 'Europe'
ORDER BY rs.num_sales DESC;

-- 8 Que editores tienen mejor presencia en el mercado de ventas de Norte America
SELECT p.publisher_name, COUNT(gp.id) FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
INNER JOIN video_games.dbo.publisher p 
ON gp.publisher_id = p.id
INNER JOIN video_games.dbo.region_sales rs
ON rs.game_platform_id = gp2.id 
INNER JOIN video_games.dbo.region r 
ON r.id = rs.region_id 
WHERE r.region_name = 'North America'
GROUP BY p.publisher_name 
ORDER BY COUNT(gp.id) DESC;

-- 9 Que editor genera mas juegos de accion
SELECT TOP 1 p.publisher_name, COUNT(g.id) FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
INNER JOIN video_games.dbo.publisher p 
ON gp.publisher_id = p.id
INNER JOIN video_games.dbo.genre g2 
ON g2.id = g.genre_id 
WHERE g2.genre_name = 'Action'
GROUP BY p.publisher_name 
ORDER BY COUNT(g.id) DESC;

-- 10 Cantidad de juegos de estrategia desarrollados por Microsoft
SELECT COUNT(g.id) AS cantidad_juegos_microsoft FROM video_games.dbo.game g 
INNER JOIN video_games.dbo.game_publisher gp 
ON gp.game_id = g.id 
INNER JOIN video_games.dbo.game_platform gp2 
ON gp2.game_publisher_id = gp.publisher_id 
INNER JOIN video_games.dbo.publisher p 
ON gp.publisher_id = p.id
INNER JOIN video_games.dbo.genre g2 
ON g2.id = g.genre_id 
WHERE g2.genre_name = 'Strategy' AND p.publisher_name LIKE 'Microsoft%'
ORDER BY COUNT(g.id) DESC;

