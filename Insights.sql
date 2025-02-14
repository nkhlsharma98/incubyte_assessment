-- =========================================================
-- KEY INSIGHTS
-- =========================================================

-- Total number of orders, total sales, and average order value
SELECT 
    COUNT(*) AS total_orders,
    SUM(TransactionAmount) AS total_sales,
    AVG(TransactionAmount) AS average_order_value
FROM sales_data;

-- Mean and Median of TransactionAmount to analyze data skewness
SELECT 
    AVG(TransactionAmount) AS mean_amount,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY TransactionAmount) AS median_amount
FROM sales_data;

-- Sales by Payment Method
SELECT 
    PaymentMethod, 
    COUNT(*) AS order_count, 
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY PaymentMethod
ORDER BY total_sales DESC;

-- Sales by City
SELECT 
    City, 
    COUNT(*) AS order_count, 
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY City
ORDER BY total_sales DESC;

-- Sales by Store Type
SELECT 
    StoreType, 
    COUNT(*) AS order_count, 
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY StoreType
ORDER BY total_sales DESC;

-- Sales Trend Over Time
SELECT 
    TransactionDate::date AS sales_date, 
    COUNT(*) AS order_count, 
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY TransactionDate::date
ORDER BY sales_date;

-- Top 10 Products by Sales
SELECT 
    ProductName, 
    COUNT(*) AS order_count, 
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY ProductName
ORDER BY order_count DESC
LIMIT 10;

-- Customer Age Group Segmentation
SELECT 
    CASE 
        WHEN CustomerAge < 25 THEN 'Under 25'
        WHEN CustomerAge BETWEEN 25 AND 40 THEN '25-40'
        WHEN CustomerAge BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS order_count,
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY age_group
ORDER BY total_sales DESC;

-- Return Rate Analysis
SELECT 
    Returned, 
    COUNT(*) AS order_count, 
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY Returned;

-- Discount Impact Analysis
SELECT 
    ProductName, 
    AVG(DiscountPercent) AS avg_discount, 
    COUNT(*) AS order_count
FROM sales_data
GROUP BY ProductName
ORDER BY avg_discount DESC;

-- Regional Sales Analysis
SELECT 
    Region, 
    COUNT(*) AS order_count, 
    SUM(TransactionAmount) AS total_sales
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC;
