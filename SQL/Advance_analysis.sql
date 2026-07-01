USE Insurance_DB;

-- 26. Rank customers based on Customer Lifetime Value.
SELECT Customer,
       Customer_Lifetime_Value,
       RANK() OVER(ORDER BY Customer_Lifetime_Value DESC) AS Customer_Rank
FROM customers;

-- 27. Show the Top 10 customers by Customer Lifetime Value.
SELECT Customer,
       Customer_Lifetime_Value
FROM customers
ORDER BY Customer_Lifetime_Value DESC
LIMIT 10;

-- 28. Rank states based on total premium collected.
SELECT c.State,
       ROUND(SUM(p.Monthly_Premium_Auto),2) AS Total_Premium,
       RANK() OVER(ORDER BY SUM(p.Monthly_Premium_Auto) DESC) AS State_Rank
FROM customers c
JOIN policies p
ON c.Customer=p.Customer
GROUP BY c.State;

-- 29. Find the highest claim amount in each state.
SELECT c.State,
       MAX(cl.Total_Claim_Amount) AS Highest_Claim
FROM customers c
JOIN claims cl
ON c.Customer=cl.Customer
GROUP BY c.State;

-- 30. Calculate a running total of premium.
SELECT Customer,
       Monthly_Premium_Auto,
       SUM(Monthly_Premium_Auto)
       OVER(ORDER BY Monthly_Premium_Auto) AS Running_Total
FROM policies;

-- 31. Calculate the average premium for each policy type using a window function.
SELECT Customer,
       Policy_Type,
       Monthly_Premium_Auto,

AVG(Monthly_Premium_Auto)
OVER(PARTITION BY Policy_Type) AS Average_Premium

FROM policies;

-- 32. Find customers whose income is above the company average.
SELECT Customer,
       Income
FROM customers
WHERE Income >
(
SELECT AVG(Income)
FROM customers
);

-- 33. Display the premium contribution (%) by each policy type.
SELECT Policy_Type,

ROUND(SUM(Monthly_Premium_Auto),2) AS Premium,

ROUND(
SUM(Monthly_Premium_Auto)*100/
(SELECT SUM(Monthly_Premium_Auto) FROM policies),2)
AS Contribution_Percentage

FROM policies

GROUP BY Policy_Type;

-- 34. Find the Top 5 vehicle classes with the highest claim amount.
SELECT p.Vehicle_Class,

ROUND(SUM(c.Total_Claim_Amount),2) AS Total_Claim

FROM policies p

JOIN claims c
ON p.Customer=c.Customer

GROUP BY p.Vehicle_Class

ORDER BY Total_Claim DESC

LIMIT 5;

-- 35. Calculate the Loss Ratio (Claims ÷ Premium).
SELECT

ROUND(
SUM(c.Total_Claim_Amount)/
SUM(p.Monthly_Premium_Auto),2)
AS Loss_Ratio

FROM claims c

JOIN policies p
ON c.Customer=p.Customer;

-- 36. Create a Customer Summary View.
CREATE VIEW vw_customer_summary AS
SELECT
c.Customer,
c.State,
p.Policy_Type,
p.Coverage,
cl.Total_Claim_Amount,
p.Monthly_Premium_Auto
FROM customers c

JOIN policies p
ON c.Customer=p.Customer

JOIN claims cl
ON c.Customer=cl.Customer;

-- 37. View the customer summary.
SELECT *
FROM vw_customer_summary;

-- 38. Find the Top 5 customers by premium.
SELECT Customer,

Monthly_Premium_Auto

FROM policies

ORDER BY Monthly_Premium_Auto DESC

LIMIT 5;

-- 39. Find the Top 5 customers by claim amount.
SELECT Customer,

Total_Claim_Amount

FROM claims

ORDER BY Total_Claim_Amount DESC

LIMIT 5;

-- 40. Display the customer, premium, claim amount, and loss amount in one report.
SELECT

c.Customer,
p.Monthly_Premium_Auto,
cl.Total_Claim_Amount,

(cl.Total_Claim_Amount-p.Monthly_Premium_Auto)
AS Profit_Loss

FROM customers c

JOIN policies p
ON c.Customer=p.Customer

JOIN claims cl
ON c.Customer=cl.Customer;
