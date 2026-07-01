USE Insurance_DB;
-- 1. How many customers does the insurance company have?
SELECT COUNT(*) AS Total_Customers
FROM customers;

-- 2. What is the total monthly premium collected by the company?
SELECT ROUND(SUM(Monthly_Premium_Auto),2) AS Total_Premium
FROM policies;

-- 3. What is the average claim amount?
SELECT ROUND(AVG(Total_Claim_Amount),2) AS Average_Claim
FROM claims;

-- 4. How many customers are there in each state?
SELECT State,
COUNT(*) AS Total_Customers
FROM customers
GROUP BY State
ORDER BY Total_Customers DESC;

-- 5. What is the gender distribution of customers?
SELECT Gender,
COUNT(*) AS Total_Customers
FROM customers
GROUP BY Gender;

-- 6. How many customers belong to each education level?
SELECT Education,
COUNT(*) AS Total_Customers
FROM customers
GROUP BY Education
ORDER BY Total_Customers DESC;

-- 7. How many policies belong to each coverage type?
SELECT Coverage,
COUNT(*) AS Total_Policies
FROM policies
GROUP BY Coverage
ORDER BY Total_Policies DESC;

-- 8. How many policies belong to each policy type?
SELECT Policy_Type,
COUNT(*) AS Total_Policies
FROM policies
GROUP BY Policy_Type
ORDER BY Total_Policies DESC;

-- 9. Which sales channel acquired the most customers?
SELECT Sales_Channel,
COUNT(*) AS Total_Customers
FROM sales
GROUP BY Sales_Channel
ORDER BY Total_Customers DESC;

-- 10. What is the distribution of customers by vehicle class?
SELECT Vehicle_Class,
COUNT(*) AS Total_Customers
FROM policies
GROUP BY Vehicle_Class
ORDER BY Total_Customers DESC;