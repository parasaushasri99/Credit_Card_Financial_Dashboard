-- Total Transaction Volume by card category ---
select Card_Category,sum(Total_Trans_Vol)as Total_Transactions 
from cc_detail
group by Card_Category
order by Total_Transactions desc;


-- Total Customers by card Category ---
select cc.Card_Category, count(DISTINCT cu.client_num) as Total_customers 
from cust_detail cu
join cc_detail cc on cu.Client_Num=cc.Client_Num
group by cc.Card_Category
order by Total_customers desc;

-- --------- Top 3 customers by card type----
with top_customers as (
	select Client_Num,card_category,sum(Total_Trans_Amt) as Total_Transaction_amount,
		rank() over(partition by card_category order by sum(Total_Trans_Amt) desc) as rnk
    from cc_Detail
    group by Client_Num,card_category
    )
select tc.client_num,
	tc.card_Category,
	cu.Customer_Age,
    cu.Customer_Job,
    cu.Income,
	tc.Total_Transaction_amount,
    tc.rnk
from top_customers tc
join cust_detail cu
on tc.client_num=cu.client_num
where tc.rnk<=3
order by tc.card_Category,tc.rnk;

-- each card category's contribution to total transaction amount --------
with card_contribution as(
	select Card_Category,sum(Total_Trans_amt) as Total_Transaction_Amount
	from cc_detail
	group by Card_Category
    )
select card_category,
	Total_Transaction_Amount,  
    round((Total_Transaction_Amount/(select sum(Total_Trans_amt) from cc_Detail))*100,2) as card_per
from card_contribution
;

-- each card category's contribution to total transaction volume --------
with card_contribution as(
	select Card_Category,sum(Total_Trans_vol) as Total_Transactions
	from cc_detail
	group by Card_Category
    )
select card_category,
	Total_Transactions,  
    round((Total_Transactions/(select sum(Total_Trans_vol) from cc_Detail))*100,2) as card_per
from card_contribution
;

-- ---- ----Delinquent Accounts by Card Category-----------
select card_category,
		sum(Delinquent_Acc) as Delinquent_Accounts
from cc_Detail
group by card_category
order by Delinquent_Accounts desc;
