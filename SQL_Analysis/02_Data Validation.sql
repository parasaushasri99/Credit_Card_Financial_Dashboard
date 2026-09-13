-- Data validation & cleaning ---
select
	sum(case when Client_Num is null then 1 else 0 end) as null_client_num,
    sum(case when Card_Category is null then 1 else 0 end) as null_card_category,
    sum(case when Annual_Fees is null then 1 else 0 end) as null_annual_fees,
    sum(case when Activation_30_Days is null then 1 else 0 end) as null_activation_30_days,
    sum(case when Customer_Acq_Cost is null then 1 else 0 end) as null_customer_acq_cost,
    sum(case when Week_Start_Date is null then 1 else 0 end) as null_week_start_date,
    sum(case when Week_Num is null then 1 else 0 end) as null_Week_num,
    sum(case when qtr is null then 1 else 0 end) as null_qtr,
    sum(case when current_year is null then 1 else 0 end) as null_current_year,
    sum(case when Credit_Limit is null then 1 else 0 end) as null_credit_limit,
    sum(case when Total_Revolving_Bal is null then 1 else 0 end) as null_total_revolving_bal,
    sum(case when Total_Trans_Amt is null then 1 else 0 end) as null_total_trans_amt,
    sum(case when Total_Trans_Vol is null then 1 else 0 end) as null_total_trans_vol,
    sum(case when Avg_Utilization_Ratio is null then 1 else 0 end) as null_avg_utilization_ratio,
    sum(case when Use_Chip is null then 1 else 0 end) as null_use_chip,
    sum(case when Exp_Type is null then 1 else 0 end) as null_exp_type,
    sum(case when Interest_Earned is null then 1 else 0 end) as null_interest_earned,
    sum(case when Delinquent_Acc is null then 1 else 0 end) as null_delinquen_acc
from cc_detail;

select
	sum(case when Client_Num is null then 1 else 0 end) as null_client_num,
    sum(case when Customer_Age is null then 1 else 0 end) as null_customer_age,
    sum(case when gender is null then 1 else 0 end) as gender_null,
    sum(case when Dependent_Count is null then 1 else 0 end) as null_dependent_count,
    sum(case when Education_Level is null then 1 else 0 end) as null_education_level,
    sum(case when Marital_Status is null then 1 else 0 end) as null_marital_status,
    sum(case when state_cd is null then 1 else 0 end) as null_state_cd,
    sum(case when Zipcode is null then 1 else 0 end) as null_zipcode,
    sum(case when Car_Owner is null then 1 else 0 end) as null_car_owner,
    sum(case when House_Owner is null then 1 else 0 end) as null_house_owner,
    sum(case when Personal_loan is null then 1 else 0 end) as null_personal_loan,
    sum(case when contact is null then 1 else 0 end) as null_contact,
    sum(case when Customer_Job is null then 1 else 0 end) as null_customer_job,
    sum(case when income is null then 1 else 0 end) as null_income,
    sum(case when Cust_Satisfaction_Score is null then 1 else 0 end) as null_cust_satisfaction_score
from cust_detail;

-- check for null or blank values ---------------
SELECT *
FROM cc_detail
WHERE Client_Num IS NULL OR Card_Category IS NULL OR Card_Category = '' OR Annual_Fees IS NULL
   OR Activation_30_Days IS NULL OR Customer_Acq_Cost IS NULL OR Week_Start_Date IS NULL
   OR Week_Num IS NULL OR Qtr IS NULL OR Qtr = '' OR current_year IS NULL OR Credit_Limit IS NULL
   OR Total_Revolving_Bal IS NULL OR Total_Trans_Amt IS NULL OR Total_Trans_Vol IS NULL
   OR Avg_Utilization_Ratio IS NULL OR Use_Chip IS NULL OR Use_Chip = '' OR Exp_Type IS NULL OR Exp_Type = ''
   OR Interest_Earned IS NULL OR Delinquent_Acc IS NULL;

select * from cust_detail
where Client_Num is null or Customer_Age is null or Customer_Age='' or Gender is null or Gender='' or 
Dependent_Count is null or Education_Level is null or Education_Level='' or Marital_Status is null or Marital_Status='' or
state_cd is null or state_cd='' or Zipcode is null or Car_Owner is null or Car_Owner='' or House_Owner is null or House_Owner='' or
Personal_loan is null or Personal_loan='' or contact is null or contact='' or Customer_Job is null or Customer_Job='' or 
Income is null or Cust_Satisfaction_Score is null;

-- check for duplicate records ---
select Client_Num, Card_Category, Annual_Fees, Activation_30_Days, Customer_Acq_Cost, Week_Start_Date,
    Week_Num, Qtr, current_year, Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt, Total_Trans_Vol,
    Avg_Utilization_Ratio, Use_Chip, Exp_Type, Interest_Earned, Delinquent_Acc, count(*) as cnt
    from cc_detail
group by Client_Num, Card_Category, Annual_Fees, Activation_30_Days, Customer_Acq_Cost, Week_Start_Date,
    Week_Num, Qtr, current_year, Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt, Total_Trans_Vol,
    Avg_Utilization_Ratio, Use_Chip, Exp_Type, Interest_Earned, Delinquent_Acc
having cnt>1;
