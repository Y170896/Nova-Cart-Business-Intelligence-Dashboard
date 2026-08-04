-- NOVA CART BUSINESS INTELLIGENCE PROJECT
-- SQL Analysis Queries

CREATE DATABASE IF NOT EXISTS novacart_db;
USE novacart_db;

-- Relationships (uncomment and adjust if needed)
-- ALTER TABLE statements for PK/FK ...

-- Validation
SELECT COUNT(*) AS Total_Customers FROM tbl_customers;
SELECT COUNT(*) AS Total_Orders FROM tbl_orders;
SELECT COUNT(*) AS Total_Products FROM tbl_products;

-- 1 Active vs Inactive Customers
SELECT Customer_Status, COUNT(*) Total_Customers
FROM tbl_customers GROUP BY Customer_Status;

-- 2 Loyalty Level Distribution
SELECT Loyalty_Level, COUNT(*) Total_Customers
FROM tbl_customers GROUP BY Loyalty_Level;

-- 3 Acquisition Channel Distribution
SELECT Acquisition_Channel, COUNT(*) Total_Customers
FROM tbl_customers GROUP BY Acquisition_Channel;

-- 4 Preferred Category
SELECT Preferred_Category, COUNT(*) Total_Customers
FROM tbl_customers GROUP BY Preferred_Category;

-- 5 Order Status Distribution
SELECT Order_Status, COUNT(*) Total_Orders
FROM tbl_orders GROUP BY Order_Status;

-- 6 Monthly Orders
SELECT MONTHNAME(Order_Date) Month_Name, COUNT(*) Total_Orders
FROM tbl_orders
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MONTH(Order_Date);

-- 7 Total Revenue
SELECT SUM(Order_Value) Total_Revenue FROM tbl_orders;

-- 8 Average Order Value
SELECT AVG(Order_Value) Average_Order_Value FROM tbl_orders;

-- 9 Top 10 Customers by Spending
SELECT Customer_ID,SUM(Order_Value) Spending
FROM tbl_orders GROUP BY Customer_ID
ORDER BY Spending DESC LIMIT 10;

-- 10 Best Selling Products
SELECT Product_Name,SUM(Quantity) Units_Sold
FROM tbl_order_items GROUP BY Product_Name
ORDER BY Units_Sold DESC LIMIT 10;

-- 11 Highest Revenue Categories
SELECT Product_Category,SUM(Order_Value) Revenue
FROM tbl_orders GROUP BY Product_Category
ORDER BY Revenue DESC;

-- 12 Revenue by Brand
SELECT Brand_Name,SUM(Order_Value) Revenue
FROM tbl_orders GROUP BY Brand_Name;

-- 13 Revenue by City
SELECT City_Name,SUM(Order_Value) Revenue
FROM tbl_orders GROUP BY City_Name;

-- 14 Customer with Highest Orders
SELECT Customer_ID,COUNT(*) Total_Orders
FROM tbl_orders GROUP BY Customer_ID
ORDER BY Total_Orders DESC;

-- 15 Revenue by Loyalty Level
SELECT Loyalty_Level,SUM(Order_Value) Revenue
FROM tbl_orders GROUP BY Loyalty_Level;

-- 16 Revenue by Payment Method
SELECT Payment_Method,SUM(Order_Value) Revenue
FROM tbl_orders GROUP BY Payment_Method;

-- 17 Top Returned Products
SELECT Product_Name,COUNT(*) Returns_Count
FROM tbl_returns GROUP BY Product_Name
ORDER BY Returns_Count DESC LIMIT 10;

-- 18 Highest Rated Products
SELECT Product_Name,AVG(Rating) Avg_Rating
FROM tbl_reviews GROUP BY Product_Name
ORDER BY Avg_Rating DESC LIMIT 10;

-- 19 Lowest Rated Products
SELECT Product_Name,AVG(Rating) Avg_Rating
FROM tbl_reviews GROUP BY Product_Name
ORDER BY Avg_Rating LIMIT 10;

-- 20 Top Returned Categories
SELECT Product_Category,COUNT(*) Returns_Count
FROM tbl_returns GROUP BY Product_Category;

-- 21 Return Rate by Order Status
SELECT Order_Status,
ROUND(SUM(CASE WHEN Return_Status='Returned' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) Return_Rate
FROM tbl_orders GROUP BY Order_Status;

-- 22 Revenue by Acquisition Channel
SELECT Acquisition_Channel,SUM(Order_Value) Revenue
FROM tbl_orders GROUP BY Acquisition_Channel;

-- 23 Average Order Value by Payment Method
SELECT Payment_Method,AVG(Order_Value) Avg_Order_Value
FROM tbl_orders GROUP BY Payment_Method;

-- 24 Highest Delivered AOV by Acquisition Channel
SELECT Acquisition_Channel,AVG(Order_Value)
FROM tbl_orders
WHERE Order_Status='Delivered'
GROUP BY Acquisition_Channel;

-- 25 Categorize Orders by Value
SELECT Order_ID,
CASE WHEN Order_Value>=10000 THEN 'High'
WHEN Order_Value>=5000 THEN 'Medium'
ELSE 'Low' END AS Value_Category
FROM tbl_orders;

-- 26 Categorize Customers by Spending
SELECT Customer_ID,SUM(Order_Value) Spending,
CASE WHEN SUM(Order_Value)>=50000 THEN 'High Value'
WHEN SUM(Order_Value)>=20000 THEN 'Medium Value'
ELSE 'Low Value' END Spending_Category
FROM tbl_orders GROUP BY Customer_ID;

-- 27 Categorize Products by Price
SELECT Product_Name,Selling_Price,
CASE WHEN Selling_Price>=10000 THEN 'Premium'
WHEN Selling_Price>=5000 THEN 'Mid'
ELSE 'Budget' END Price_Category
FROM tbl_products;

-- 28 Categorize Orders by Delivery Status
SELECT Order_ID,
CASE WHEN Order_Status='Delivered' THEN 'Completed'
WHEN Order_Status='Returned' THEN 'Returned'
ELSE 'Open' END Delivery_Status
FROM tbl_orders;

-- 29 Customers by Age Group
SELECT Age_Group,COUNT(*) Customers
FROM tbl_customers GROUP BY Age_Group;

-- 30 Monthly Revenue Trend
SELECT MONTHNAME(Order_Date),SUM(Order_Value)
FROM tbl_orders
GROUP BY MONTH(Order_Date),MONTHNAME(Order_Date);

-- 31 Top 3 Products in Each Category
WITH X AS(
SELECT Product_Category,Product_Name,SUM(Order_Value) Revenue,
DENSE_RANK() OVER(PARTITION BY Product_Category ORDER BY SUM(Order_Value) DESC) r
FROM tbl_orders GROUP BY Product_Category,Product_Name)
SELECT * FROM X WHERE r<=3;

-- 32 Top 5 Customers using DENSE_RANK
WITH X AS(
SELECT Customer_ID,SUM(Order_Value) Revenue,
DENSE_RANK() OVER(ORDER BY SUM(Order_Value) DESC) r
FROM tbl_orders GROUP BY Customer_ID)
SELECT * FROM X WHERE r<=5;

-- 33 Cumulative Revenue
SELECT Order_Date,
SUM(Order_Value) OVER(ORDER BY Order_Date) Cumulative_Revenue
FROM tbl_orders;

-- 34 Highest Revenue Product in Each Category
WITH X AS(
SELECT Product_Category,Product_Name,SUM(Order_Value) Revenue,
ROW_NUMBER() OVER(PARTITION BY Product_Category ORDER BY SUM(Order_Value) DESC) rn
FROM tbl_orders GROUP BY Product_Category,Product_Name)
SELECT * FROM X WHERE rn=1;

-- 35 Customers Spending Above Average
SELECT Customer_ID,SUM(Order_Value)
FROM tbl_orders GROUP BY Customer_ID
HAVING SUM(Order_Value)>(SELECT AVG(Order_Value) FROM tbl_orders);

-- 36 Top Brands by Revenue
SELECT Brand_Name,SUM(Order_Value)
FROM tbl_orders GROUP BY Brand_Name
ORDER BY SUM(Order_Value) DESC LIMIT 10;

-- 37 Products Never Returned
SELECT Product_Name FROM tbl_products
WHERE Product_Name NOT IN (SELECT Product_Name FROM tbl_returns);

-- 38 Average Customer Rating by Brand
SELECT Brand_Name,AVG(Rating)
FROM tbl_reviews GROUP BY Brand_Name;

-- 39 Sales Contribution by Category
SELECT Product_Category,
ROUND(SUM(Order_Value)*100/(SELECT SUM(Order_Value) FROM tbl_orders),2)
FROM tbl_orders GROUP BY Product_Category;
