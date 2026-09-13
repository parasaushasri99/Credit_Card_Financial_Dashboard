-- Total Revenue by card category
select Card_Category, round(sum(Total_Trans_Amt+Interest_Earned+annual_fees)/1000000,2) as Total_Revenue_M
from cc_detail
group by Card_Category;

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

-- ----------- --- Revenue by Customer Job -----------
select cu.customer_job,round(sum(cc.Interest_Earned+cc.Total_Trans_Amt+cc.annual_fees)/1000000,2) as Total_revenue_Millions
from cc_detail cc
join cust_Detail cu
on cc.client_num=cu.client_num
group by cu.customer_job
order by Total_revenue_Millions desc;

-- ----------Average Revenue per Customer----------
select round(sum(Interest_Earned+Total_Trans_Amt+annual_fees)/count(distinct client_num),2) as Avg_Revenue_per_Customer
from cc_detail
group by client_num
order by Avg_Revenue_per_Customer desc;

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
