 -- Part 2: Joins Practice
 
 -- 1 Show all orders along with the customer name.
SELECT o.orderNumber, o.orderDate, o.status, c.customerName
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber;

 -- 2 Show each customer with their sales representative’s name.
SELECT c.customerName,
CONCAT(e.firstName, ' ', e.lastName) AS salesRepName
FROM customers c
LEFT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

 
 -- 3 Find all employees and the office city they work in.
SELECT e.employeeNumber,
       e.firstName, e.lastName,
       o.city AS officeCity
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode;

 -- 4 Show each order with its ordered products and quantities.
 SELECT o.orderNumber,
       p.productName,
       od.quantityOrdered
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode;

 
 -- 5 List all payments with customer name and country.
SELECT p.paymentDate, p.amount,
       c.customerName, c.country
FROM payments p
JOIN customers c ON p.customerNumber = c.customerNumber;

 
 -- 6 Show all customers who have never placed an order.
SELECT c.customerNumber, c.customerName
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL;

 
 -- 7 Find employees who don’t manage anyone.
SELECT e.employeeNumber, e.firstName, e.lastName
FROM employees e
LEFT JOIN employees sub ON e.employeeNumber = sub.reportsTo
WHERE sub.employeeNumber IS NULL;
