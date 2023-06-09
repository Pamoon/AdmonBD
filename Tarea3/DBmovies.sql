-- 1 Mostrar la lista de todas las peliculas indicando si esta en Idioma español o no
SELECT m.title, CASE WHEN l.language_code = 'es' THEN 'si' ELSE 'no' END AS español FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_languages ml 
ON ml.movie_id = m.movie_id 
INNER JOIN movies.dbo.[language] l 
ON l.language_id = ml.language_id ;

--2 Mostrar el genero(drama, accion, terror, etc) de cada pelicula
SELECT m.title, g.genre_name FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.dbo.genre g 
ON g.genre_id = mg.genre_id ;

-- 3 Cuales son las 5 compañias productoras de peliculas que tiene mayor aceptacion (votos)
SELECT TOP 5 SUM(m.vote_count), pc.company_name FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_company mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.dbo.production_company pc 
ON pc.company_id = mc.company_id 
GROUP BY pc.company_name 
ORDER BY SUM(m.vote_count) DESC;

-- 4 Mostrar una lista de las personas que participan en cada pelicula
SELECT m.title, p.person_name  FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.dbo.person p 
ON p.person_id = mc.person_id ;

-- 5 Mostrar una lista con la cantidad de personas por departamento que cuenta cada compañia productora
SELECT d.department_name, COUNT(mc.movie_id) FROM movies.dbo.department d 
INNER JOIN movies.dbo.movie_crew mc 
ON d.department_id = mc.department_id 
GROUP BY d.department_name ;

-- 6 Mostrar las peliculas en las que ha participado las personas como parte del movie_cast
SELECT m.title FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_cast mc 
ON mc.movie_id = m.movie_id
GROUP BY m.title ;


-- 7 Listar los paises donde estan ubicas las compañias productoras
SELECT pc2.company_name, c.country_name  FROM movies.dbo.movie m 
INNER JOIN movies.dbo.production_country pc 
ON pc.movie_id = m.movie_id 
INNER JOIN movies.dbo.country c 
ON pc.country_id = c.country_id 
INNER JOIN movies.dbo.movie_company mc 
ON m.movie_id = mc.movie_id 
INNER JOIN movies.dbo.production_company pc2 
ON mc.company_id = pc2.company_id ;

-- 8 Mostrar de la lista de elencos cuantas mujeres participan en una pelicula de drama}
SELECT COUNT(g2.gender_id) AS cantidad_mujeres FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.dbo.genre g 
ON g.genre_id = mg.genre_id 
INNER JOIN movies.dbo.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.dbo.gender g2 
ON mc.gender_id = g2.gender_id 
WHERE g2.gender = 'Female' AND g.genre_name = 'Drama';

-- 9 Mostrar la cantidad de idiomas en los que se dobla cada pelicula
SELECT m.title, COUNT(ml.movie_id) FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_languages ml 
ON ml.movie_id = m.movie_id 
GROUP BY m.title;

-- 10 Mostrar las 8 palabras claves mas utilizadas en las peliculas
SELECT TOP 8 k.keyword_name, COUNT(m.movie_id) FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_keywords mk 
ON mk.movie_id = m.movie_id 
INNER JOIN movies.dbo.keyword k 
ON k.keyword_id = mk.keyword_id 
GROUP BY k.keyword_name 
ORDER BY COUNT(m.movie_id) DESC;

