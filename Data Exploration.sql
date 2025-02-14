-- =========================================================
-- EXPLORATION AND SCHEMA UNDERSTANDING
-- =========================================================

-- 1. Finding Duplicate Records
-- Checking for duplicate TransactionIDs  
SELECT TransactionID, COUNT(*) AS Duplicate_Count
FROM sales_data
GROUP BY TransactionID
HAVING COUNT(*) > 1;

-- Observation: No duplicates found.

-- 2. NULL Values Identification
-- Checking for NULL values in each column  
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

-- 3. Checking for Records where both CustomerID and TransactionDate are NULL  
SELECT COUNT(*) AS Null_Customer_TransactionDate
FROM sales_data
WHERE CustomerID IS NULL AND TransactionDate IS NULL;

-- 4. Finding records where multiple key attributes are NULL  
SELECT COUNT(*) AS Fully_Null_Records
FROM sales_data
WHERE PaymentMethod IS NULL 
  AND StoreType IS NULL 
  AND CustomerAge IS NULL 
  AND CustomerGender IS NULL 
  AND ProductName IS NULL
  AND Region IS NULL;

-- 5. Finding Minimum and Maximum Values for Key Columns  
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
-- END OF SCHEMA EXPLORATION
-- =========================================================
