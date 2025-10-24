-- =========================================
-- TASK 4 : AGGREGATE FUNCTIONS AND GROUPING
-- =========================================

USE ecommerce_db;

-- 1️. TOTAL SALES PER CUSTOMER
SELECT 
    c.Customer_ID,
    c.Name AS Customer_Name,
    SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customer c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC;

-- 2️. TOTAL REVENUE PER PRODUCT
SELECT 
    p.Product_ID,
    p.Name AS Product_Name,
    SUM(oi.Quantity) AS Total_Quantity_Sold,
    SUM(oi.Price * oi.Quantity) AS Total_Revenue
FROM Order_Item oi
JOIN Product p ON oi.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Name
ORDER BY Total_Revenue DESC;

-- 3️. AVERAGE ORDER VALUE
SELECT 
    ROUND(AVG(Total_Amount), 2) AS Average_Order_Value
FROM Orders;

-- 4️. COUNT OF ORDERS PER CUSTOMER
SELECT 
    c.Name AS Customer_Name,
    COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Customer c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Name
ORDER BY Order_Count DESC;

-- 5️. PAYMENT METHOD WISE TOTAL COLLECTION
SELECT 
    COALESCE(Payment_Method, 'Pending') AS Payment_Method,
    COUNT(Payment_ID) AS Payment_Count,
    SUM(COALESCE(Amount, 0)) AS Total_Amount_Collected
FROM Payment
GROUP BY Payment_Method;

-- 6️. PRODUCTS WITH SALES ABOVE ₹5000 (HAVING CLAUSE)
SELECT 
    p.Name AS Product_Name,
    SUM(oi.Price * oi.Quantity) AS Total_Sales
FROM Order_Item oi
JOIN Product p ON oi.Product_ID = p.Product_ID
GROUP BY p.Name
HAVING Total_Sales > 5000
ORDER BY Total_Sales DESC;

-- 7️. TOTAL NUMBER OF CUSTOMERS, ORDERS, AND PAYMENTS
SELECT 
    (SELECT COUNT(*) FROM Customer) AS Total_Customers,
    (SELECT COUNT(*) FROM Orders) AS Total_Orders,
    (SELECT COUNT(*) FROM Payment) AS Total_Payments;
