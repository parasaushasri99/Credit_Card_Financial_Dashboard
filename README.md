Project Overview:
This project analyzes credit card transaction and customer data to understand revenue, customer behavior, card performance, and delinquency trends. The analysis helps identify key business drivers and opportunities for improving customer engagement and revenue.

Business Problem:
•	Credit card operations generate large volumes of customer, transaction, revenue, and account-level data. However, analyzing these metrics across different dimensions can be challenging without a centralized reporting solution.
•	The objective of this project is to develop a comprehensive Credit Card Financial Dashboard that provides actionable insights into key performance metrics, revenue trends, customer behavior, and transaction performance. The dashboard enables stakeholders to monitor business performance, identify trends, and make data-driven decisions.

Tools used:
•	SQL / MySQL – Data exploration and business analysis
•	Power BI – Data modeling, DAX calculations and interactive dashboard
•	Excel – Initial data exploration and validation

Dataset Overview

The dataset contains credit card customer and transaction-level information used to analyze customer behavior, transaction performance, revenue trends, card category performance, and delinquency.
The analysis was performed using two main tables:
1. Customer Details (cust_detail): Contains customer-level information such as demographics, job, income-related attributes, customer acquisition cost, annual fees, and activation status.
2. Credit Card Details (cc_detail): Contains transaction and card-level information including transaction amount, transaction volume, interest earned, annual fees, credit limit, revolving balance, utilization ratio, expenditure type, card category, and delinquency information.
Dataset size: The initial dataset contained 10,108 rows across both tables. An additional 185 rows representing one week of data were subsequently added, bringing the final dataset to 10,293 rows.
The data was analyzed across different dimensions including card category, customer type, gender, age group, state, job, expenditure type, and time to identify key business trends and performance indicators.

KPIs:
•	Total Transaction Amount
•	Net Revenue
•	Total Earned Amount
•	Total Annual Fees
•	Total Customers
•	Total Transactions
•	Delinquency Rate

SQL - Deep Dive Business Analysis:
•	Total Transaction Volume by card category
•	Total Customers by card Category
•	Avg Transactions per Customer
•	Monthly Transactions Trend
•	Avg Utilization Ratio by Customer Type
•	Top 10 customers by total transaction amount
•	Top 3 customers by card category
•	M-o-M growth Percentage
•	Contribution of Each Card by Transaction Volume 
•	Contribution of Each Card by Transaction Amount 
•	Customers Above Average Transaction Amount
•	Total Revenue by card category
•	Revenue contribution by card category
•	Revenue by Customer Job
•	Average Revenue per Customer
•	Customer Value Segmentation
•	Number of customers in each segment
•	High Transaction + High Utilization Customers
•	Delinquent Accounts by Card Category
•	Top Customer Job by Revenue Within Each Card Category

Power BI dashboard:
•	Customer Analysis
•	Card Analysis
•	Time Trend Analysis
•	Revenue Analysis
•	Risk Analysis

Key Business insights:
•	Revenue increased by 28.8% WoW, indicating strong short-term growth in the credit card business and improved revenue generation compared with the previous week. 
•	The increase in revenue, transaction volume, and customer count together indicates that the business experienced broad-based growth rather than growth driven by a single metric.
•	Overall revenue reached $57M YTD, reflecting strong revenue generation across the credit card portfolio. 
•	Total interest earned was $8M, highlighting interest income as a significant component of overall revenue. 
•	Total transaction amount reached $46M, indicating substantial customer spending and credit card utilization. 
•	Male customers contributed $31M in revenue compared with $26M from female customers, indicating a higher revenue contribution from male customers. 
•	Blue and Silver credit cards generated 93% of overall revenue, making them the dominant revenue-generating card categories. 
•	Texas (TX), New York (NY), and California (CA) contributed 68% of overall revenue. 
•	Overall activation rate was 57.5%, indicating that there is considerable scope to improve card activation and customer engagement. 
•	Overall delinquent rate was 6.06%, highlighting the importance of monitoring repayment behavior and identifying higher-risk customer segments.




The data was analyzed across different dimensions including card category, customer type, gender, age group, state, job, expenditure type, and time to identify key business trends and performance indicators.
