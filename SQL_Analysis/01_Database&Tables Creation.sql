create database credit_card_db;

-- credit card Table creation -- ----------
create table cc_detail(
	Client_Num INT,
	Card_Category varchar(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num varchar(20),
    Qtr varchar(20),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Vol INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip varchar(10),
    Exp_Type varchar(20),
    Interest_Earned decimal(20,3),
    Delinquent_Acc varchar(5)
    );
    
    -- Customer details Table creation -- ---------------
    create table cust_detail(
	Client_Num INT,
	Customer_Age INT,
    Gender varchar(5),
    Dependent_Count INT,
    Education_Level varchar(50),
    Marital_Status varchar(20),
    state_cd varchar(50),
    Zipcode varchar(20),
    Car_Owner varchar(5),
    House_Owner varchar(5),
    Personal_loan varchar(5),
    contact varchar(50),
    Customer_Job varchar(50),
    Income iNT,
    Cust_Satisfaction_Score INT
    )
    
select * from cc_detail;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/credit_card.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';

-- due to different date formats in week start date column we are using below query to let sql change the format directly -----
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/credit_card.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	Client_Num,
	Card_Category,
    Annual_Fees,
    Activation_30_Days,
    Customer_Acq_Cost,
    @Week_Start_Date,
    Week_Num,
    Qtr,
    current_year,
    Credit_Limit,
    Total_Revolving_Bal,
    Total_Trans_Amt,
    Total_Trans_Vol,
    Avg_Utilization_Ratio,
    Use_Chip,
    Exp_Type,
    Interest_Earned,
    Delinquent_Acc
)
SET Week_Start_Date =
CASE
        WHEN @Week_Start_Date LIKE '%-%-%'
             AND SUBSTRING_INDEX(@Week_Start_Date, '-', 1) > 31
        THEN STR_TO_DATE(@Week_Start_Date, '%Y-%m-%d')
        ELSE STR_TO_DATE(@Week_Start_Date, '%d-%m-%Y')
END;

select * from cc_detail;

select count(*) from cc_detail;

SELECT * FROM cc_detail
LIMIT 10;

describe cc_detail;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from cust_detail;

select count(*) from cust_detail;

describe cust_detail;
