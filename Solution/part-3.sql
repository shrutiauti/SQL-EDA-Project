-- Part 3: Aggregates & Grouping

-- 1. Count how many customers each country has
SELECT country, COUNT(*) AS customerCount
FROM customers
GROUP BY country
ORDER BY customerCount DESC;

-- 2. Find the total sales amount for each customer

SELECT c.customerNumber, c.customerName,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY totalSales DESC;

-- 3. Show the average credit limit per country
SELECT country, AVG(creditLimit) AS avgCreditLimit
FROM customers
GROUP BY country
ORDER BY avgCreditLimit DESC;

-- 4. Find the maximum payment amount per customer
SELECT c.customerNumber, c.customerName,
       MAX(p.amount) AS maxPayment
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY maxPayment DESC;

-- 5. Count the number of products in each product line
SELECT productLine, COUNT(*) AS productCount
FROM products
GROUP BY productLine
ORDER BY productCount DESC;

-- 6. Find which employee manages the most customers
SELECT e.employeeNumber,
       CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
       COUNT(c.customerNumber) AS customerCount
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber, employeeName
ORDER BY customerCount DESC
LIMIT 1;

-- 7. Get the monthly sales totals for 2004

SELECT DATE_FORMAT(p.paymentDate, '%Y-%m') AS month,
       SUM(p.amount) AS monthlyTotal
FROM payments p
WHERE YEAR(p.paymentDate) = 2004
GROUP BY month
ORDER BY month;

-- 8. Find the top 5 customers by total payments
SELECT c.customerNumber, c.customerName,
       SUM(p.amount) AS totalPayments
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY totalPayments DESC
LIMIT 5;