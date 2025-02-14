-- =========================================================
-- DATA CLEANING
-- =========================================================

-- Replacing NULL CustomerID with -1
UPDATE sales_data
SET CustomerID = -1
WHERE TransactionDate IS NULL 
  AND CustomerID IS NULL;

-- Replacing NULL TransactionDate by imputing them according to other transactions 
-- as TransactionDate is in serial order
WITH numbered AS (
    SELECT TransactionID, 
           TransactionDate, 
           ROW_NUMBER() OVER (ORDER BY TransactionID) AS rn
    FROM sales_data
),
cte AS (
    SELECT n.TransactionID, 
           n.TransactionDate, 
           n.rn,
           MAX(CASE WHEN n.TransactionDate IS NOT NULL THEN rn END) 
                OVER (ORDER BY n.rn) AS last_valid_rn,
           MAX(CASE WHEN n.TransactionDate IS NOT NULL THEN TransactionDate END) 
                OVER (ORDER BY n.rn) AS last_valid_date
    FROM numbered n
)
UPDATE sales_data s
SET TransactionDate = c.last_valid_date + INTERVAL '1 minute' * (c.rn - c.last_valid_rn)
FROM cte c
WHERE s.TransactionID = c.TransactionID
  AND s.TransactionDate IS NULL;

-- Updating Text/Categorical Fields to 'Unknown'
UPDATE sales_data
SET PaymentMethod = 'Unknown',
    StoreType = 'Unknown',
    CustomerGender = 'Unknown',
    ProductName = 'Unknown',
    Region = 'Unknown'
WHERE PaymentMethod IS NULL;

-- Updating missing CustomerAge with median values
UPDATE sales_data
SET CustomerAge = (
    SELECT PERCENTILE_CONT(0.5) 
           WITHIN GROUP (ORDER BY CustomerAge)
    FROM sales_data
    WHERE CustomerAge IS NOT NULL
)
WHERE CustomerAge IS NULL;

-- Replacing Negative TransactionAmount values with their absolute values
UPDATE sales_data
SET TransactionAmount = ABS(TransactionAmount)
WHERE TransactionAmount < 0;

-- Data Validation: NULL Values Identification
SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(TransactionID) AS Non_Null_TransactionID,
    COUNT(CustomerID) AS Non_Null_CustomerID,
    COUNT(TransactionDate) AS Non_Null_TransactionDate,
    COUNT(TransactionAmount) AS Non_Null_TransactionAmount,
    COUNT(PaymentMethod) AS Non_Null_PaymentMethod,
    COUNT(ProductName) AS Non_Null_ProductName,
    COUNT(CustomerAge) AS Non_Null_CustomerAge,
    COUNT(CustomerGender) AS Non_Null_CustomerGender,
    COUNT(Region) AS Non_Null_Region
FROM sales_data;

-- Data Validation: Minimum and Maximum Values
SELECT 'TransactionID' AS Column_Name, 
       MIN(TransactionID)::TEXT AS Min_Value, 
       MAX(TransactionID)::TEXT AS Max_Value FROM sales_data
UNION ALL
SELECT 'CustomerID', 
       MIN(CustomerID)::TEXT, 
       MAX(CustomerID)::TEXT FROM sales_data
UNION ALL
SELECT 'TransactionDate', 
       MIN(TransactionDate)::TEXT, 
       MAX(TransactionDate)::TEXT FROM sales_data
UNION ALL
SELECT 'TransactionAmount', 
       MIN(TransactionAmount)::TEXT, 
       MAX(TransactionAmount)::TEXT FROM sales_data
UNION ALL
SELECT 'Quantity', 
       MIN(Quantity)::TEXT, 
       MAX(Quantity)::TEXT FROM sales_data
UNION ALL
SELECT 'DiscountPercent', 
       MIN(DiscountPercent)::TEXT, 
       MAX(DiscountPercent)::TEXT FROM sales_data
UNION ALL
SELECT 'CustomerAge', 
       MIN(CustomerAge)::TEXT, 
       MAX(CustomerAge)::TEXT FROM sales_data
UNION ALL
SELECT 'LoyaltyPoints', 
       MIN(LoyaltyPoints)::TEXT, 
       MAX(LoyaltyPoints)::TEXT FROM sales_data
UNION ALL
SELECT 'FeedbackScore', 
       MIN(FeedbackScore)::TEXT, 
       MAX(FeedbackScore)::TEXT FROM sales_data
UNION ALL
SELECT 'ShippingCost', 
       MIN(ShippingCost)::TEXT, 
       MAX(ShippingCost)::TEXT FROM sales_data
UNION ALL
SELECT 'DeliveryTimeDays', 
       MIN(DeliveryTimeDays)::TEXT, 
       MAX(DeliveryTimeDays)::TEXT FROM sales_data;


-- =========================================================
-- END OF DATA CLEANING
-- =========================================================
