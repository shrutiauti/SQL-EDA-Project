 -- Part 7: Business Insights
 
 -- 1. Which country generates the most revenue?
SELECT c.country,
       SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY totalRevenue DESC
LIMIT 1;

-- 2. Who are the top 5 sales representatives by payments?
SELECT e.employeeNumber,
       CONCAT(e.firstName, ' ', e.lastName) AS salesRep,
       SUM(p.amount) AS totalPayments
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber, salesRep
ORDER BY totalPayments DESC
LIMIT 5;

-- 3. Which month has the highest number of orders?
SELECT DATE_FORMAT(orderDate, '%Y-%m') AS orderMonth,
       COUNT(orderNumber) AS orderCount
FROM orders
GROUP BY orderMonth
ORDER BY orderCount DESC
LIMIT 1;

-- 4. What is the average order size (quantity of products per order)?
SELECT AVG(orderSize) AS avgOrderSize
FROM (
    SELECT o.orderNumber, SUM(od.quantityOrdered) AS orderSize
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY o.orderNumber
) sub;

-- 5. Which product has the highest profit margin (MSRP - buyPrice)?
SELECT productCode, productName,
       (MSRP - buyPrice) AS profitMargin
FROM products
ORDER BY profitMargin DESC
LIMIT 1;

-- 6. Which office manages the largest number of customers?
SELECT o.officeCode, o.city, o.country,
       COUNT(c.customerNumber) AS customerCount
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY o.officeCode, o.city, o.country
ORDER BY customerCount DESC
LIMIT 1;

-- 7. Who are the most valuable customers (based on payments)?
SELECT c.customerNumber, c.customerName,
       SUM(p.amount) AS totalPayments
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY totalPayments DESC
LIMIT 5;

-- 8. Find the trend of sales over years

SELECT YEAR(o.orderDate) AS salesYear,
       SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY salesYear
ORDER BY salesYear;

-- 9. Which product line has highest stock but lowest sales?
SELECT p.productLine,
       SUM(p.quantityInStock) AS totalStock,
       COALESCE(SUM(od.quantityOrdered), 0) AS totalSold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY totalStock DESC, totalSold ASC
LIMIT 1;

-- 10. Detect customers with zero payments
SELECT c.customerNumber, c.customerName
FROM customers c
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.customerNumber IS NULL;

-- 11. Find the slowest-moving products (very few orders)

SELECT p.productCode, p.productName,
       COALESCE(SUM(od.quantityOrdered), 0) AS totalSold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName
ORDER BY totalSold ASC
LIMIT 10;