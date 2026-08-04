
# NovaCart — End-to-End Business Intelligence Dashboard

End-to-end Business Intelligence project using **Excel, SQL, and Power BI** to analyze Sales, Customer, Product, and Operational performance through data modeling, SQL analysis, DAX measures, and interactive dashboards.

---
![Sales Dashboard](Nova_Cart_Business_Intelligence_Dashboard/Screenshots/Sales%20Intelligence%20Dashboard.ss.jpeg)

---

##  Project Overview

This project transforms a raw e-commerce dataset into meaningful business insights through a complete BI pipeline: data cleaning in Excel, business analysis in SQL, and interactive dashboarding in Power BI. It focuses on analyzing **Sales, Customers, Products, and Operational Performance** to support data-driven business decisions.

##  Business Objective

- Analyze sales performance across different dimensions
- Understand customer acquisition and retention
- Evaluate product performance and customer ratings
- Monitor operational efficiency and delivery performance
- Build an interactive Power BI dashboard for business decision-making

##  Tools & Technologies

`Microsoft Excel` · `MySQL` · `SQL` · `Power BI` · `DAX` · `Data Modeling`

---

##  Project Workflow

### 1. Data Collection
Raw e-commerce dataset containing multiple related tables — [Nova_Cart_Dataset.xlsx](Nova_Cart_Business_Intelligence_Dashboard/Dataset/Nova_Cart_Dataset.xlsx)

### 2. Excel Analysis
Initial data exploration, validation, summary analysis, and basic reporting — [Novacart_Excel_Analysis.xlsx](Nova_Cart_Business_Intelligence_Dashboard/Excel%20Analysis/Novacart_Excel_Analysis.xlsx)

### 3. SQL Analysis
**39+ business SQL queries** were written in [NovaCart_SQL_Analysis_Queries.sql](Nova_Cart_Business_Intelligence_Dashboard/SQL%20Queries/NovaCart_SQL_Analysis_Queries.sql) to answer real business questions, covering:
Customer Analysis · Revenue Analysis · Product Analysis · Brand Analysis · Category Analysis · Order Analysis · Return Analysis · Payment Method Analysis · Monthly Sales Trend · Customer Segmentation · Ranking Analysis · Window Functions · Revenue Contribution · Top Customers · Top Products

**Queries - -- Top 3 Products in Each Category
WITH X AS(
SELECT Product_Category, Product_Name, SUM(Order_Value) Revenue,
DENSE_RANK() OVER(PARTITION BY Product_Category ORDER BY SUM(Order_Value) DESC) r
FROM tbl_orders GROUP BY Product_Category, Product_Name)
SELECT * FROM X WHERE r<=3;

Cumulative Revenue
SELECT Order_Date,
SUM(Order_Value) OVER(ORDER BY Order_Date) Cumulative_Revenue
FROM tbl_orders;

Customers Spending Above Average
SELECT Customer_ID, SUM(Order_Value)
FROM tbl_orders GROUP BY Customer_ID
HAVING SUM(Order_Value) > (SELECT AVG(Order_Value) FROM tbl_orders);

##4. Power BI Development
Built in [NovaCart_Business_Intelligence_Dashboard.pbix](Nova_Cart_Business_Intelligence_Dashboard/Dashboard/NovaCart_Business_Intelligence_Dashboard%20%281%29.pbix), covering:

- Data Modeling & Relationship Creation
- DAX Measures & KPI Cards
- Interactive Dashboards & Business Visualizations

## Dashboards

### 1. Sales Intelligence Dashboard
Revenue Analysis · Order Analysis · Customer Analysis · Payment Analysis · Top Cities

### 2. Customer Intelligence Dashboard
Customer Acquisition · Customer Retention · Customer Lifetime Value · Customer Ratings · Monthly Customer Trend

### 3. Product Performance Dashboard
Product Ratings · Category Performance · Selling Price Analysis · Product Reviews · Product Revenue

### 4. Operational Performance Dashboard
Delivery Performance · Return Analysis · Shipping Fee · Monthly Operations · Order Status

 Key Business Insights

- Generated **₹7.69M in total revenue** from 1,000 orders and 500 customers (AOV: ₹7.68K)
- Achieved a **66.5% customer retention rate** with 290 repeat customers and an average CLV of ₹17.6K
- **Chandigarh, Delhi, and Surat** were identified as the top revenue-generating cities
- Maintained a **10% return rate** with an average delivery time of 4.4 days
- Average product rating stood at **3.9/5** across 10 categories, with the top product generating ₹7,689K in revenue
- Wallet and UPI emerged as the most preferred payment methods, each contributing ₹1.4M in revenue

Full detailed findings are documented in the [Nova Cart Project Report](Nova_Cart_Business_Intelligence_Dashboard/Report/Nova_Cart%20project%20Report.pdf)
Repository Structure

Nova_Cart_Business_Intelligence_Dashboard
│
├── Dashboard/          → Power BI (.pbix) file
├── Dataset/            → Raw e-commerce dataset
├── Excel Analysis/     → Excel-based exploratory analysis
├── SQL Queries/        → 39+ SQL business analysis queries
├── Report/             → Final PDF business report
├── Screenshots/        → Dashboard preview images
├── README.md
└── LICENSE

 Skills Demonstrated

Business Intelligence · Data Analysis · SQL Query Writing · Excel Analytics · Power BI Dashboard Development · DAX Measures · Data Modeling · KPI Development · Data Visualization · Business Storytelling

 Future Improvements

- Live Database Integration
- Power BI Service Deployment
- Automated Data Refresh
- Predictive Sales Analytics
- Customer Segmentation using Machine Learning

 Author

Yukti Dang

Business Analyst | Data Analyst
