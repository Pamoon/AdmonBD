-- 1 Mostrar una lista de los libros con el autor e idiomas del libro
SELECT * FROM gravity_books.dbo.book b 
INNER JOIN gravity_books.dbo.book_author ba 
ON b.book_id = ba.book_id 
INNER JOIN gravity_books.dbo.book_language bl 
ON bl.language_id = b.language_id ;

-- 2 Obtener la cantidad de compras que ha realizado un cliente
SELECT c.customer_id, c.first_name, COUNT(co.order_id) AS compras FROM gravity_books.dbo.customer c 
INNER JOIN gravity_books.dbo.cust_order co 
ON c.customer_id = co.customer_id 
GROUP BY c.customer_id, c.first_name ;

-- 3 Listar los 5 libros mas vendidos
SELECT TOP 5 b.title, COUNT(ol.order_id) FROM gravity_books.dbo.order_line ol 
INNER JOIN gravity_books.dbo.book b 
ON b.book_id = ol.book_id 
GROUP BY b.title
ORDER BY COUNT(ol.order_id) DESC;

-- 4 Mostrar los paises donde se ha utilizado el tipo de envio Express
SELECT * FROM gravity_books.dbo.cust_order co 
INNER JOIN gravity_books.dbo.shipping_method sm 
ON sm.method_id = co.shipping_method_id 
WHERE sm.method_name = 'Express'

-- 5 Mostrar los libros que sus ordenes se han cancelado
SELECT * FROM gravity_books.dbo.order_history oh 
INNER JOIN gravity_books.dbo.order_status os 
ON oh.status_id = os.status_id 
WHERE os.status_value = 'Cancelled';

-- 6 Mostrar el pais donde tiene mas influencia cada autor de libro
SELECT a.author_name, c.country_name, COUNT(ol.order_id) FROM gravity_books.dbo.order_line ol 
INNER JOIN gravity_books.dbo.cust_order co 
ON co.order_id  = ol.order_id 
INNER JOIN gravity_books.dbo.book b 
ON b.book_id = ol.book_id 
INNER JOIN gravity_books.dbo.book_author ba 
ON ba.book_id = b.book_id 
INNER JOIN gravity_books.dbo.author a 
ON a.author_id = ba.author_id 
INNER JOIN gravity_books.dbo.customer_address ca 
ON ca.customer_id = co.customer_id 
INNER JOIN gravity_books.dbo.address a2 
ON ca.address_id = a2.address_id 
INNER JOIN gravity_books.dbo.country c 
ON c.country_id = a2.country_id 
GROUP BY a.author_name, c.country_name 
ORDER BY COUNT(ol.order_id) DESC;


-- 7 Mostrar los clientes que han retornado o devuelto libros
SELECT c.customer_id, c.first_name, c.last_name, c.email FROM gravity_books.dbo.order_history oh 
INNER JOIN gravity_books.dbo.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.dbo.cust_order co 
ON co.order_id = oh.order_id 
INNER JOIN gravity_books.dbo.customer c 
ON c.customer_id = co.customer_id 
WHERE os.status_value = 'Returned';

-- 8 Mostrar la cantidad de libros y el titulo del libro que se han entregado satisfactoriamente
SELECT b.title, COUNT(oh.history_id) FROM gravity_books.dbo.order_history oh 
INNER JOIN gravity_books.dbo.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.dbo.order_line ol 
ON ol.order_id = oh.order_id 
INNER JOIN gravity_books.dbo.book b 
ON b.book_id = ol.book_id 
WHERE os.status_value = 'Delivered'
GROUP BY b.title ;

-- 9 Mostrar la lista de los clientes mas frecuentes
SELECT c.customer_id, c.first_name, COUNT(co.order_id) FROM gravity_books.dbo.cust_order co 
INNER JOIN gravity_books.dbo.customer c 
ON co.customer_id = c.customer_id 
GROUP BY c.customer_id, c.first_name 
ORDER BY COUNT(co.order_id) DESC;

-- 10 Mostrar el mes en el que mas pedidos de libros se realizan
SELECT TOP 1 MONTH(co.order_date) as Mes, COUNT(co.order_id) FROM gravity_books.dbo.cust_order co 
GROUP BY MONTH(co.order_date)
ORDER BY COUNT(co.order_id) DESC;

