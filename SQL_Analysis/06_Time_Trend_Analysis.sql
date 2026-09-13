-- Monthly Transactions Trend ----
select monthname(week_start_date) as month,sum(Total_Trans_Vol) as Total_Transactions
from cc_detail
group by month(week_start_date),monthname(week_start_date)
order by month(week_start_date);

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
