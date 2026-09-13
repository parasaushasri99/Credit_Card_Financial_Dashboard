-- ---Top 10 customers  ----
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

-- month-over-month transaction growth -------------
with monthly_Transactions as(
	select month(week_Start_Date) as Month_num,
			monthname(Week_Start_Date) as Month_Name,
            sum(Total_Trans_Vol) as Total_transactions
    from cc_detail
    group by Month_num,Month_Name
    ),
    Previous_transactions as(
    select Month_Name,
		Total_transactions,
        lag(Total_transactions) over (order by Month_num) as previous_month_Transactions
	from monthly_transactions
    order by Month_num
)
select Month_Name,
	Total_transactions,
    previous_month_Transactions,
    round(((Total_transactions-previous_month_Transactions)/previous_month_Transactions)*100,2) as MOM_Growth_percentage
from Previous_transactions;

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
	

-- -- Revenue contribution by card category --------------
with card_contribution as (
	select card_category, sum(Total_Trans_Amt+Interest_Earned+annual_fees) as Total_Revenue
	from cc_detail
    group by Card_Category
    )
select card_category, 
		round((Total_Revenue/(select sum(Total_Trans_Amt+Interest_Earned+annual_fees) from cc_Detail)*100),2) as total_cont
from card_contribution 
;

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

-- -----Top Customer Job by Revenue Within Each Card Category-----------
with top_customer_job as(
	select cc.card_Category,
			cu.customer_job, 
			sum(cc.total_trans_Amt) as Total_Revenue,
            rank() over(partition by cc.card_Category order by sum(cc.total_trans_Amt) desc) as rnk
    from cust_Detail cu
    join cc_detail  cc
    on cu.Client_Num=cc.Client_Num
    group by cc.card_Category,cu.customer_job
    )
select card_Category,
		customer_job,
		Total_Revenue
from top_customer_job
where rnk=1;
