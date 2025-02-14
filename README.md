# incubyte_assessment
This repository contains data analysis of sales_data assessment shared by Incubyte for Data Craftsperson role along with necessary files. 
# **Sales Data Analysis Project**

## **Overview**
This project analyzes a sales transaction dataset containing **500,000 records** to extract meaningful business insights. The analysis covers **data cleaning, exploration, and key insights** into payment trends, customer behavior, product performance, regional sales, and return rates.

## **Dataset**
- The dataset includes fields like `TransactionID, CustomerID, TransactionDate, TransactionAmount, PaymentMethod, StoreType, CustomerAge, CustomerGender, ProductName, Region, and DiscountPercent`.
- **Time Range:** The transactions follow a **serial order**, allowing for time-based analysis.

## **Project Structure**
```
/SQL_Scripts
    - Create Table.sql          # SQL script to define database schema
    - Data Cleaning.sql         # SQL script for handling missing values & outliers
    - Data Exploration.sql      # SQL queries for exploratory data analysis
    - Insights.sql              # SQL queries to extract key insights
/Documentation
    - Assignment_Insights.docx  # Detailed report of findings
/Data
    - assessment_dataset.csv    # Sales dataset used for analysis
      link: https://incubytein-my.sharepoint.com/:x:/g/personal/akash_incubyte_co/EWbzbiLBCxNHogEQHUF0i7MBkK-86jKetzVDT4t0d-wZog?e=P0xulf
README.md                      # Project summary and instructions
```

## **Steps Performed**

### **1. Data Cleaning**
- **Missing Values:**
  - `CustomerID` replaced with `-1` for missing values.
  - `TransactionDate` imputed based on serial order.
  - `PaymentMethod, StoreType, CustomerGender, ProductName, Region` set to `'Unknown'`.
  - `CustomerAge` replaced with the median value.
- **Outliers:**
  - Negative `TransactionAmount` values converted to absolute values.

### **2. Data Exploration & Insights**
- **Overall Sales Performance:**
  - **High Average Order Value (₹20,420)** suggests high-ticket purchases.
  - **Right-skewed distribution:** Median **₹1,051.14**, indicating a few very large transactions inflating the mean.
- **Payment Trends:**
  - **Cash generates the highest revenue**, while **Debit Card has the most transactions**.
- **City-Level Insights:**
  - **Kolkata, Ahmedabad, and Bangalore** lead in both sales and order count.
- **Store Type Comparison:**
  - **Online and In-Store sales are nearly equal (~₹5,081 Cr each)**, showing similar consumer behavior.
- **Sales Trends Over Time:**
  - **1,440 orders per day** except the last day, which has **only 320** (incomplete data).
  - **Total sales per day ~₹30M**, except **₹6M on the last day**.
- **Product Performance:**
  - **Laptop, Sofa, and T-shirt generate the highest revenue**.
  - **Apple has the lowest revenue share.**
- **Customer Demographics:**
  - The **41-60 age group dominates** in order count and revenue.
- **Return Rate:**
  - **49.8% of orders were returned (249,467 out of 500,000)**, impacting revenue.
- **Discount Impact:**
  - **Average discount across all products ~25%**.
  - **Apple has the highest discount (25.03%) but lowest revenue share**.
- **Regional Sales:**
  - **South region leads with ₹3.17B in revenue (141K orders)**.
  - **East follows with ₹2.65B in sales (116K orders).**

## **How to Run the SQL Scripts**
### **1. Set Up the Database**
1. Create a PostgreSQL database.
2. Run `Create Table.sql` to define the schema.
3. Load `assessment_dataset.csv` into the `sales_data` table.

### **2. Perform Data Cleaning**
Execute `Data Cleaning.sql` to handle missing values, outliers, and standardization.

### **3. Explore and Extract Insights**
- Run `Data Exploration.sql` to analyze sales trends, payment methods, store types, etc.
- Run `Insights.sql` to generate key insights.
