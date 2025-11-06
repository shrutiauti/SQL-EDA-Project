-- 1. Find customers who placed more than 5 orders
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS orderCount
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(o.orderNumber) > 5;

-- 2. List product lines where the average MSRP > 100
SELECT p.productLine, AVG(p.MSRP) AS avgMSRP
FROM products p
GROUP BY p.productLine
HAVING AVG(p.MSRP) > 100;

3. Show employees with more than 3 customers assigned
SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
       COUNT(c.customerNumber) AS customerCount
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber, employeeName
HAVING COUNT(c.customerNumber) > 3;

-- 4. Display orders where the shippedDate is NULL
SELECT * FROM orders
WHERE shippedDate IS NULL;

-- 5. Categorize customers by credit limit: High, Medium, Low

SELECT customerNumber, customerName, creditLimit,
       CASE
           WHEN creditLimit > 100000 THEN 'High'
           WHEN creditLimit BETWEEN 50000 AND 100000 THEN 'Medium'
           ELSE 'Low'
       END AS CreditCategory
FROM customers;

-- 6. Find the top 10 most ordered products
SELECT p.productCode, p.productName,
       SUM(od.quantityOrdered) AS totalOrdered
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName
ORDER BY totalOrdered DESC
LIMIT 10;

-- 7. Show the revenue contribution % of each product line
SELECT pl.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS lineRevenue,
       (SUM(od.quantityOrdered * od.priceEach) /
        (SELECT SUM(od2.quantityOrdered * od2.priceEach) FROM orderdetails od2) * 100) AS contributionPercent
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
JOIN productlines pl ON p.productLine = pl.productLine
GROUP BY pl.productLine
ORDER BY contributionPercent DESC;