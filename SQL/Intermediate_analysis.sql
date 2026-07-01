USE Insurance_DB;

-- 11. Which states have customers with an average income greater than $40,000?
SELECT State,
       ROUND(AVG(Income),2) AS Average_Income
FROM customers
GROUP BY State
HAVING AVG(Income) > 40000
ORDER BY Average_Income DESC;

-- 12. Which coverage types generate the highest average premium?
SELECT Coverage,
       ROUND(AVG(Monthly_Premium_Auto),2) AS Average_Premium
FROM policies
GROUP BY Coverage
ORDER BY Average_Premium DESC;

-- 13. Show customers whose monthly premium is greater than the overall average premium.
SELECT Customer,
       Monthly_Premium_Auto
FROM policies
WHERE Monthly_Premium_Auto >
(
SELECT AVG(Monthly_Premium_Auto)
FROM policies
)
ORDER BY Monthly_Premium_Auto DESC;

-- 14. Find customers whose claim amount is greater than $500.
SELECT Customer,
       Total_Claim_Amount
FROM claims
WHERE Total_Claim_Amount > 500
ORDER BY Total_Claim_Amount DESC;

-- 15. Categorize customers based on income.
SELECT Customer,
Income,

CASE
WHEN Income < 30000 THEN 'Low Income'
WHEN Income BETWEEN 30000 AND 60000 THEN 'Medium Income'
ELSE 'High Income'
END AS Income_Category

FROM customers;

-- 16. Categorize customers based on Customer Lifetime Value.
SELECT Customer,
Customer_Lifetime_Value,

CASE

WHEN Customer_Lifetime_Value < 5000 THEN 'Low Value'

WHEN Customer_Lifetime_Value BETWEEN 5000 AND 10000
THEN 'Medium Value'

ELSE 'High Value'

END AS Customer_Category

FROM customers;

-- 17. Which education group has the highest average claim amount?
SELECT c.Education,
ROUND(AVG(cl.Total_Claim_Amount),2) AS Average_Claim

FROM customers c

JOIN claims cl
ON c.Customer=cl.Customer

GROUP BY c.Education

ORDER BY Average_Claim DESC;

-- 18. What is the total premium collected by each state?
SELECT c.State,
ROUND(SUM(p.Monthly_Premium_Auto),2) AS Total_Premium

FROM customers c

JOIN policies p
ON c.Customer=p.Customer

GROUP BY c.State

ORDER BY Total_Premium DESC;

-- 19. Which vehicle class has the highest average claim amount?
SELECT p.Vehicle_Class,

ROUND(AVG(c.Total_Claim_Amount),2) AS Average_Claim

FROM policies p

JOIN claims c
ON p.Customer=c.Customer

GROUP BY p.Vehicle_Class

ORDER BY Average_Claim DESC;

-- 20. Which sales channel generated the highest premium?
SELECT s.Sales_Channel,

ROUND(SUM(p.Monthly_Premium_Auto),2) AS Total_Premium

FROM sales s

JOIN policies p
ON s.Customer=p.Customer

GROUP BY s.Sales_Channel

ORDER BY Total_Premium DESC;

-- 21. Find the top 10 customers by Customer Lifetime Value.
SELECT Customer,
Customer_Lifetime_Value

FROM customers

ORDER BY Customer_Lifetime_Value DESC

LIMIT 10;

-- 22. Find customers who have not made a claim recently (more than 30 months).
SELECT Customer,
Months_Since_Last_Claim

FROM claims

WHERE Months_Since_Last_Claim >30

ORDER BY Months_Since_Last_Claim DESC;

-- 23. Which policy type has the highest average premium?
SELECT Policy_Type,

ROUND(AVG(Monthly_Premium_Auto),2) AS Average_Premium

FROM policies

GROUP BY Policy_Type

ORDER BY Average_Premium DESC;

-- 24. Find the total number of customers by response.
SELECT Response,

COUNT(*) AS Total_Customers

FROM customers

GROUP BY Response;

-- 25. Show customers whose claim amount is above the average claim amount.
SELECT Customer,
Total_Claim_Amount

FROM claims

WHERE Total_Claim_Amount >
(
SELECT AVG(Total_Claim_Amount)
FROM claims
)

ORDER BY Total_Claim_Amount DESC;