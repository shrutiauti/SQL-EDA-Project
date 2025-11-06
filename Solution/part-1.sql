--  Part 1: Basic Exploration

-- 1 List all customers from USA.
SELECT * FROM customers
WHERE country = 'USA';

 -- 2 Show all products where stock is less than 500 units.
SELECT * FROM products
WHERE quantityInStock < 500;

 -- 3 Find employees working in the Paris office.
 SELECT e.*
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
WHERE o.city = 'Paris';

--  4 Get orders with status = 'Cancelled'.
SELECT * FROM orders
WHERE status = 'Cancelled';

 -- 5 List all customers whose credit limit > 100000.
SELECT * FROM customers
WHERE creditLimit > 100000;
 
 -- 6 Find customers who have no assigned sales representative.
SELECT * FROM customers
WHERE salesRepEmployeeNumber IS NULL;
 
 -- 7 Show all orders placed in 2004.
SELECT * FROM orders
WHERE YEAR(orderDate) = 2004;