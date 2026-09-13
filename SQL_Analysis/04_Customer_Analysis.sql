-- Avg Transactions per customer ----
select cc.Card_Category, 
	count(DISTINCT cu.client_num) as Total_customers,
	sum(Total_Trans_Vol) as Total_Transactions, 
    round((sum(Total_Trans_Vol)/count(DISTINCT cu.client_num)),2) as Avg_Transactions_per_Customer
from cust_detail cu
join cc_detail cc on cu.Client_Num=cc.Client_Num
group by cc.Card_Category
order by Total_customers desc;

-- Avg Utilization Ratio by Customer Type ---
select Customer_Job,round(avg(Avg_Utilization_Ratio),3) as avg_utilization_ratio
from cc_detail cc
join cust_detail cu
on cc.Client_Num=cu.Client_Num
group by Customer_Job
order by avg_utilization_ratio asc;

-- Top 10 customers ----
with customer_rrnk as(
	select client_Num, sum(Total_Trans_Amt) as Total_Transaction_Amount,
			rank() over (order by sum(Total_Trans_Amt) desc) as rnk
    from cc_detail
    group by client_Num
)
select cr.client_num,
		cu.Customer_Age,
        cu.Customer_Job,
        cu.Income,
        cr.Total_Transaction_Amount,
        cr.rnk
from customer_rrnk cr
join cust_detail cu 
on cr.Client_Num=cu.Client_Num
where rnk<= 10
order by rnk;

-- customers whose transaction amount is above the average customer transaction amount ---------
with customers_cte as(
	select client_num,sum(total_trans_amt) as total_transaction_amount
    from cc_detail
    group by client_num
    )
select client_num
from customers_cte
where total_transaction_amount>
		(Select avg(total_transaction_amount) from customers_cte);
        
-- ----------Customer Value Segmentation-----------
with customer_spend as (
	select client_num,
		sum(total_trans_Amt) as Total_spent
    from cc_Detail
    group by client_num
    )
select client_num,
		Total_Spent,
        case
			when Total_Spent>=10000 Then "High Value"
            when Total_Spent>=5000 Then "Medium Value"
            Else "Low Value"
		END as Customer_Segment
from customer_spend;

-- ----------Number of customers in each segment--------------
with customer_spend as (
	select client_num,
		sum(total_trans_Amt) as Total_spent
    from cc_Detail
    group by client_num
    ),
 customers as (
	select client_num,
		Total_spent,
		case
			when Total_Spent>=10000 Then "High Value"
			when Total_Spent>=5000 Then "Medium Value"
			Else "Low Value"
		END as Customer_Segment
	from customer_spend
    )
select Customer_Segment, 
		count(*) as Total_Customers,
        sum(Total_Spent) as Total_spending
from customers
group by Customer_Segment
order by Total_Customers desc;

select min(total_trans_amt),max(total_trans_amt)
from cc_Detail;

-- ----------High Transaction + High Utilization Customers--------
with customer_metrics as(
	select client_num, 
			sum(total_trans_amt) as Total_Transaction_Amount,
            round(avg(Avg_Utilization_Ratio),3) as Avg_Utilization
	from cc_Detail
    group by client_num
    )
select client_num,
		Total_Transaction_Amount,
        Avg_Utilization
from customer_metrics
where Total_Transaction_Amount>
			(select avg(Total_Transaction_Amount) from customer_metrics)
		and
		Avg_Utilization>
			(Select avg(Avg_Utilization) from customer_metrics)
order by Total_Transaction_Amount desc;

