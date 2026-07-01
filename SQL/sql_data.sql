CREATE DATABASE Insurance_DB;
USE Insurance_DB;
CREATE TABLE staging_insurance (
    Customer VARCHAR(20),
    State VARCHAR(50),
    Customer_Lifetime_Value DECIMAL(12,2),
    Response VARCHAR(20),
    Coverage VARCHAR(20),
    Education VARCHAR(50),
    Effective_To_Date DATE,
    Employment_Status VARCHAR(50),
    Gender VARCHAR(20),
    Income VARCHAR(50),
    Location_Code VARCHAR(20),
    Marital_Status VARCHAR(20),
    Monthly_Premium_Auto VARCHAR(50),
    Months_Since_Last_Claim INT,
    Months_Since_Policy_Inception INT,
    Number_of_Open_Complaints INT,
    Number_of_Policies INT,
    Policy_Type VARCHAR(50),
    Policy VARCHAR(50),
    Renew_Offer_Type VARCHAR(50),
    Sales_Channel VARCHAR(50),
    Total_Claim_Amount VARCHAR(100),
    Vehicle_Class VARCHAR(50),
    Vehicle_Size VARCHAR(20)
);

desc staging_insurance;

SELECT COUNT(*) AS Total_Records
FROM staging_insurance;
-- data check
SELECT *
FROM staging_insurance
LIMIT 10;
-- finding duplicates
SELECT Customer,
       COUNT(*) AS Duplicate_Count
FROM staging_insurance
GROUP BY Customer
HAVING COUNT(*) > 1;
-- Customer Table
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    state VARCHAR(50),
    customer_lifetime_value DECIMAL(12,2),
    response VARCHAR(20),
    education VARCHAR(50),
    employment_status VARCHAR(50),
    gender VARCHAR(20),
    income DECIMAL(12,2),
    location_code VARCHAR(20),
    marital_status VARCHAR(20)
);
INSERT INTO customers
(
    customer_id,
    state,
    customer_lifetime_value,
    response,
    education,
    employment_status,
    gender,
    income,
    location_code,
    marital_status
)
SELECT DISTINCT
    Customer,
    State,

    CAST(
        REPLACE(REPLACE(Customer_Lifetime_Value,'$',''),',','')
        AS DECIMAL(12,2)
    ),

    Response,
    Education,
    Employment_Status,
    Gender,

    CAST(
        REPLACE(REPLACE(Income,'$',''),',','')
        AS DECIMAL(12,2)
    ),

    Location_Code,
    Marital_Status

FROM staging_insurance;

SELECT *
FROM customers
LIMIT 10;
SELECT COUNT(*)
FROM customers;

ALTER TABLE customers
CHANGE customer_id Customer VARCHAR(20);

-- policy table
CREATE TABLE policies (
    policy_id INT AUTO_INCREMENT PRIMARY KEY,
    Customer VARCHAR(20),
    Policy VARCHAR(50),
    Policy_Type VARCHAR(50),
    Coverage VARCHAR(30),
    Monthly_Premium_Auto DECIMAL(10,2),
    Months_Since_Policy_Inception INT,
    Number_of_Policies INT,
    Renew_Offer_Type VARCHAR(30),
    Vehicle_Class VARCHAR(50),
    Vehicle_Size VARCHAR(30),

    FOREIGN KEY (Customer)
    REFERENCES customers(Customer)
);
-- claims table
CREATE TABLE claims (
    claim_id INT AUTO_INCREMENT PRIMARY KEY,
    Customer VARCHAR(20),
    Effective_To_Date DATE,
    Months_Since_Last_Claim INT,
    Number_of_Open_Complaints INT,
    Total_Claim_Amount DECIMAL(12,2),
    FOREIGN KEY (Customer) REFERENCES customers(Customer)
);

-- sales table
CREATE TABLE sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    Customer VARCHAR(20),
    Sales_Channel VARCHAR(50),
    Response VARCHAR(20),
    FOREIGN KEY (Customer) REFERENCES customers(Customer)
);

SELECT COUNT(*) AS Total_Customers
FROM customers;

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM policies;
SELECT COUNT(*) FROM claims;
SELECT COUNT(*) FROM sales;

DESCRIBE customers;

INSERT INTO policies
(
    Customer,
    Policy,
    Policy_Type,
    Coverage,
    Monthly_Premium_Auto,
    Months_Since_Policy_Inception,
    Number_of_Policies,
    Renew_Offer_Type,
    Vehicle_Class,
    Vehicle_Size
)

SELECT
    Customer,
    Policy,
    Policy_Type,
    Coverage,

    CAST(
        REPLACE(REPLACE(Monthly_Premium_Auto,'$',''),',','')
        AS DECIMAL(10,2)
    ),

    Months_Since_Policy_Inception,
    Number_of_Policies,
    Renew_Offer_Type,
    Vehicle_Class,
    Vehicle_Size

FROM staging_insurance;

INSERT INTO claims
(
    Customer,
    Effective_To_Date,
    Months_Since_Last_Claim,
    Number_of_Open_Complaints,
    Total_Claim_Amount
)

SELECT
    Customer,
    CAST(Effective_To_Date AS DATE),
    Months_Since_Last_Claim,
    Number_of_Open_Complaints,
    CAST(
        REPLACE(REPLACE(Total_Claim_Amount,'$',''),',','')
        AS DECIMAL(12,2)
    )

FROM staging_insurance;

INSERT INTO sales
(
    Customer,
    Sales_Channel,
    Response
)

SELECT
    Customer,
    Sales_Channel,
    Response

FROM staging_insurance;

SELECT 'staging_insurance' AS Table_Name, COUNT(*) AS Total_Records
FROM staging_insurance

UNION ALL

SELECT 'customers', COUNT(*)
FROM customers

UNION ALL

SELECT 'policies', COUNT(*)
FROM policies

UNION ALL

SELECT 'claims', COUNT(*)
FROM claims

UNION ALL

SELECT 'sales', COUNT(*)
FROM sales;



