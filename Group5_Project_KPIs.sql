##Connect to database
USE finance_db;

##############################################
##KPI_1 : Year wise loan amount Stats
SELECT YEAR(issue_d) AS issue_year,
COUNT(loan_amnt)AS count_loan_amt,
SUM(loan_amnt) AS total_loan_amt, ROUND(AVG(loan_amnt)) AS average_loan_amt ,
MIN(loan_amnt) AS min_loan_amt,MAX(loan_amnt) AS max_loan_amt 
FROM finance_1 GROUP BY issue_year ORDER BY issue_year;
##############################################

##KPI_2 : Grade and sub grade wise revol_bal
SELECT
grade, sub_grade,SUM(revol_bal) AS total_revol_bal
FROM finance_1 f1 INNER JOIN finance_2 f2
ON (f1.id = f2.id)
GROUP BY grade , sub_grade
ORDER BY grade , sub_grade;

#########################################

## KPI_4 : State wise and last_credit_pull_d wise loan status
SELECT 
f1.addr_state AS state, f2.last_credit_pull_d AS last_credit_pulled, f1.loan_status
FROM
finance_1 f1  JOIN finance_2 f2 ON f1.id = f2.id
ORDER BY last_credit_pulled , state, loan_status;

############################################

## KPI_5 : Home ownership Vs last payment date stats
SELECT 
YEAR(f2.last_pymnt_d) as last_payment_year,
f1.home_ownership,
COUNT(f1.loan_amnt) as member_count, SUM(f1.loan_amnt) as total_loan_amount, 
ROUND(AVG(f1.loan_amnt)) as average_loan_amount,
MIN(f1.loan_amnt) as minimum_loan_amount,MAX(f1.loan_amnt) as maximum_loan_amount	
FROM finance_1 AS f1 INNER JOIN finance_2 AS f2 ON f1.id = f2.id
GROUP BY YEAR(f2.last_pymnt_d) , f1.home_ownership
HAVING last_payment_year IS NOT NULL ORDER BY last_payment_year, total_loan_amount DESC ;
############################################


##### Slicers #####
SELECT distinct(grade) from finance_1 ORDER BY grade;
SELECT distinct(sub_grade) from finance_1 ORDER BY sub_grade;
SELECT distinct(verification_status) from finance_1 ORDER BY verification_status;
SELECT distinct(loan_status) from finance_1 ORDER BY loan_status;
SELECT distinct(home_ownership) from finance_1 ORDER BY home_ownership;
###########################################################

##### Dashboard Cards #####
SELECT SUM(loan_amnt) as total_loan_amt FROM finance_1;
SELECT MIN(loan_amnt) as minimum_loan_amt FROM finance_1;
SELECT MAX(loan_amnt) as maximum_loan_amt FROM finance_1;
SELECT SUM(funded_amnt) as total_funded_amt FROM finance_1;
SELECT SUM(revol_bal) as total_revol_bal FROM finance_2;
###########################################################