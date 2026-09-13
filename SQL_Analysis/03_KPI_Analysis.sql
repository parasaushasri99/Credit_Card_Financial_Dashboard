-- KPI's ----
-- Total Transaction amount ---
select concat(round(sum(Total_Trans_Amt)/1000000,2),'M') as Total_transaction_amount
from cc_detail;

-- Total Earned amount ---
select concat(round(sum(Interest_Earned)/1000000,2),' M') as Total_Earned_amount
from cc_detail;

-- Total annual fees --
select sum(Annual_Fees) from cc_detail;

-- Total Revenue --
select concat(round((sum(Total_Trans_Amt)+sum(Interest_Earned)+sum(annual_fees))/1000000,2),'M') as Total_Revenue
from cc_detail;

-- Net Revenue / Contribution----
select concat(round((sum(Total_Trans_Amt)+sum(Interest_Earned)+sum(annual_fees)-sum(customer_acq_cost))/1000000,2),'M') as Total_Revenue
from cc_detail;

-- Total CUstomers ---
select count(DISTINCT client_num) as Total_customers 
from cust_detail;

select Education_Level,count(DISTINCT client_num) as Total_customers 
from cust_detail
group by Education_Level;

-- Total Transaction volume ---
select sum(Total_Trans_Vol)as Total_Transactions 
from cc_detail;
