-- 1. Find customers who made payments greater than the average payment

SELECT DISTINCT c.customerNumber, c.customerName
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.amount > (SELECT AVG(amount) FROM payments);

-- 2. List products that have never been ordered

SELECT p.productCode, p.productName
FROM products p
WHERE p.productCode NOT IN (
    SELECT DISTINCT od.productCode
    FROM orderdetails od
);

-- 3. Find the employee with the highest number of direct reports

SELECT e.employeeNumber,
       CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
       COUNT(sub.employeeNumber) AS reportCount
FROM employees e
LEFT JOIN employees sub ON e.employeeNumber = sub.reportsTo
GROUP BY e.employeeNumber, employeeName
ORDER BY reportCount DESC
LIMIT 1;

-- 4. Show orders that contain the most expensive product

SELECT DISTINCT o.orderNumber, o.orderDate, o.status
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE od.productCode = (
    SELECT productCode
    FROM products
    ORDER BY MSRP DESC
    LIMIT 1
);

-- 5. List the top 3 offices with the highest total sales

SELECT o.officeCode, o.city, o.country,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders ord ON c.customerNumber = ord.customerNumber
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY o.officeCode, o.city, o.country
ORDER BY totalSales DESC
LIMIT 3;