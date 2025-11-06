-- 1. Procedure: Get all orders by a given customer
DELIMITER $$
CREATE PROCEDURE GetOrdersByCustomer(IN custNumber INT)
BEGIN
    SELECT o.orderNumber, o.orderDate, o.status
    FROM orders o
    WHERE o.customerNumber = custNumber;
END $$
DELIMITER ;
CALL GetOrdersByCustomer(103);

-- 2. Procedure: Find total sales between two dates
DELIMITER $$
CREATE PROCEDURE GetTotalSalesBetweenDates(IN startDate DATE, IN endDate DATE)
BEGIN
    SELECT SUM(od.quantityOrdered * od.priceEach) AS totalSales
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE o.orderDate BETWEEN startDate AND endDate;
END $$
DELIMITER ;


CALL GetTotalSalesBetweenDates('2004-01-01', '2004-12-31');

-- 3. Procedure: Show the best-selling product line

DELIMITER $$
CREATE PROCEDURE GetBestSellingProductLine()
BEGIN
    SELECT pl.productLine,
           SUM(od.quantityOrdered * od.priceEach) AS totalSales
    FROM orderdetails od
    JOIN products p ON od.productCode = p.productCode
    JOIN productlines pl ON p.productLine = pl.productLine
    GROUP BY pl.productLine
    ORDER BY totalSales DESC
    LIMIT 1;
END $$
DELIMITER ;

CALL GetBestSellingProductLine();

-- 4. Procedure: Display all customers handled by an employee
DELIMITER $$
CREATE PROCEDURE GetCustomersByEmployee(IN empNumber INT)
BEGIN
    SELECT c.customerNumber, c.customerName, c.country
    FROM customers c
    WHERE c.salesRepEmployeeNumber = empNumber;
END $$
DELIMITER ;


CALL GetCustomersByEmployee(1337);

5. Procedure: Calculate yearly revenue given an input year


DELIMITER $$
CREATE PROCEDURE GetYearlyRevenue(IN inputYear INT)
BEGIN
    SELECT inputYear AS year,
           SUM(p.amount) AS totalRevenue
    FROM payments p
    WHERE YEAR(p.paymentDate) = inputYear;
END $$
DELIMITER ;


CALL GetYearlyRevenue(2004);