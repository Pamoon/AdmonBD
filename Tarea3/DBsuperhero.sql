-- 1 Mostrar una lista de los superpoderes que tiene cada Super Heroe
SELECT s2.superhero_name, s.power_name FROM superhero.dbo.hero_power hp 
INNER JOIN superhero.dbo.superpower s 
ON s.id = hp.power_id 
INNER JOIN superhero.dbo.superhero s2 
ON s2.id = hp.hero_id;

-- 2 Mostrar la cantidad de superpoderes con los que cuenta cada Super Heroe
SELECT s2.superhero_name, COUNT(s.power_name) FROM superhero.dbo.hero_power hp 
INNER JOIN superhero.dbo.superpower s 
ON s.id = hp.power_id 
INNER JOIN superhero.dbo.superhero s2 
ON s2.id = hp.hero_id
GROUP BY s2.superhero_name;

-- 3 Mostrar los diez superpoderes que es mas frecuente en cada Super Heroe
SELECT TOP 10 s.power_name, COUNT(s2.superhero_name) AS frequency FROM superhero.dbo.hero_power hp 
INNER JOIN superhero.dbo.superpower s 
ON s.id = hp.power_id 
INNER JOIN superhero.dbo.superhero s2 
ON s2.id = hp.hero_id
GROUP BY s.power_name 
ORDER BY COUNT(s2.superhero_name) DESC;

-- 4 Mostrar los Super Heroes que no cuentan con el Atributo de Intelligence
SELECT s.superhero_name, a.attribute_name FROM superhero.dbo.superhero s 
INNER JOIN superhero.dbo.hero_attribute ha 
ON ha.hero_id = s.id 
INNER JOIN superhero.dbo.[attribute] a 
ON a.id = ha.attribute_id 
WHERE a.attribute_name != 'Intelligence';

-- 5 Mostrar los Super Heroes que cuentan con tres o 5 Atributos
SELECT s.superhero_name, COUNT(a.attribute_name) AS amount_attributes FROM superhero.dbo.superhero s 
INNER JOIN superhero.dbo.hero_attribute ha 
on ha.hero_id = s.id
INNER JOIN superhero.dbo.[attribute] a 
ON a.id = ha.attribute_id 
GROUP BY s.superhero_name
HAVING COUNT(a.attribute_name) = 5 OR COUNT(a.attribute_name) = 3;

-- 6 Mostrar la lista de las mujeres que son Super Heroes
SELECT * FROM superhero.dbo.superhero s 
INNER JOIN superhero.dbo.gender g 
ON g.id = s.gender_id 
WHERE g.gender = 'Female';

-- 7 Mostrar la lista de los colores de como se identifca un Super Heroe (color de ojos, traje y pelo)
SELECT s.superhero_name, c.colour FROM superhero.dbo.superhero s
INNER JOIN superhero.dbo.colour c 
ON c.id = s.eye_colour_id ;

-- 8 Mostrar la lista de Super Heroe indicando su origen (race) y cantidad de superpoderes
SELECT s.superhero_name, r.race, COUNT(hp.hero_id) AS amount_powers FROM superhero.dbo.superhero s 
INNER JOIN superhero.dbo.race r 
ON r.id = s.race_id 
INNER JOIN superhero.dbo.hero_power hp 
ON hp.hero_id = s.id
GROUP BY s.superhero_name, r.race ;

-- 9 Mostrar la cantidad de superheroes que tienen un papel de Superheroe Bueno(alignment) agrupado por cada editor(publisher)
SELECT p.publisher_name, COUNT(s.id) FROM superhero.dbo.superhero s 
INNER JOIN superhero.dbo.publisher p 
ON s.publisher_id = p.id 
INNER JOIN superhero.dbo.alignment a 
ON s.alignment_id = a.id
WHERE a.alignment = 'Good'
GROUP BY p.publisher_name;

