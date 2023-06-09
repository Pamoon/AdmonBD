-- 1 Realizar una consulta donde pueda obtener los paises donde estan ubicadas cada universidad.
SELECT u.university_name, c.country_name FROM universities.dbo.university u 
INNER JOIN universities.dbo.country c ON u.country_id = c.id;

-- 2 Conocer cuantas universidades hay en cada pais.
SELECT COUNT(c.id) AS amount_universities, c.country_name 
FROM universities.dbo.country c 
INNER JOIN universities.dbo.university u 
ON c.id = u.country_id
GROUP BY c.country_name
ORDER BY COUNT(c.id) DESC;

-- 3 Conocer cuantos paises no tienen universidades en el ranking.
SELECT COUNT(c.id) AS countries_with_no_ranking_university 
FROM universities.dbo.country c WHERE c.id NOT IN (
	SELECT DISTINCT u.country_id FROM universities.dbo.university u 
	INNER JOIN universities.dbo.university_ranking_year ury 
	ON ury.university_id = u.id
);

-- 4 Mostrar los criterios de cada tipo de ranking.
SELECT rs.system_name, rc.criteria_name FROM universities.dbo.ranking_criteria rc 
INNER JOIN universities.dbo.ranking_system rs 
ON rc.ranking_system_id = rs.id;


-- 5 Conocer el ranking que tiene mas criterios
SELECT rs.system_name FROM universities.dbo.ranking_system rs WHERE id = (
	SELECT MAX(ranking_system_id) FROM universities.dbo.ranking_criteria rc 
);


-- 6 Cual es el top de universidades de forma descendente del ano 2012 por cada criterio
SELECT u.university_name, rc.criteria_name , ury.[year] FROM universities.dbo.university_ranking_year ury 
INNER JOIN universities.dbo.university u 
ON u.id = ury.university_id 
INNER JOIN universities.dbo.ranking_criteria rc 
ON ury.ranking_criteria_id = rc.id
WHERE ury.[year] <= 2012
ORDER BY ury.[year] DESC;


-- 7 Mostrar las 5 universidad con mas cantidades de score 100 del ranking tipo 'Center for World University Rankings'
SELECT TOP 5 MAX(u.id), u.university_name, ury.score FROM universities.dbo.university u
INNER JOIN universities.dbo.university_ranking_year ury 
ON u.id = ury.university_id
INNER JOIN universities.dbo.ranking_criteria rc 
ON rc.id = ury.ranking_criteria_id 
INNER JOIN universities.dbo.ranking_system rs 
ON rs.id  = rc.ranking_system_id 
WHERE ury.score = 100 AND rs.system_name = 'Center for World University Rankings'
GROUP BY u.university_name, ury.score 
ORDER BY MAX(u.id) DESC;


-- 8 Mostrar que paises se posicionaron con universidades con un score mayor a 90
SELECT c.country_name FROM universities.dbo.country c 
INNER JOIN universities.dbo.university u 
ON c.id = u.country_id 
INNER JOIN universities.dbo.university_ranking_year ury 
ON u.id = ury.university_id 
WHERE ury.score > 90
GROUP BY c.country_name;


-- 9 Mostrar las universidades que utilizan los criterios del tipo ranking 'Shangai Ranking'
SELECT u.university_name FROM universities.dbo.university u 
INNER JOIN universities.dbo.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.dbo.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.dbo.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Shanghai Ranking'
GROUP BY u.university_name;


-- 10 Mostrar el top 10 de las peores posiciones del tipo ranking 'Times Higher....'
SELECT TOP 10 u.university_name, ury.score, rs.system_name FROM universities.dbo.university u 
INNER JOIN universities.dbo.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.dbo.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.dbo.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Times Higher Education World University Ranking' AND ury.score >= 0
ORDER BY ury.score ASC;

