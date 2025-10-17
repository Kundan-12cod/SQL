use project;

CREATE TABLE subscription_customers (
  CustomerID VARCHAR(20) PRIMARY KEY,
  SignupDate DATE,
  TenureMonths INT,
  LastLoginDate DATE,
  DaysSinceLastLogin INT,
  PlanType VARCHAR(20),
  MonthlyFee DECIMAL(10,2),
  TotalSpend DECIMAL(12,2),
  NumLogins_Last30Days INT,
  NumSupportTickets INT,
  AvgSessionMinutes INT,
  Country VARCHAR(50),
  City VARCHAR(100),
  Age INT,
  Gender VARCHAR(20),
  DeviceType VARCHAR(20),
  Churn INT, -- 1 churned, 0 active
  Renewal VARCHAR(10),
  CLTV DECIMAL(12,2),
  Active INT
);

select * from subscription_customers;


-- 1 Top cities by churn rate

select city,count(*) as total_customer,
            sum(churn) as churned,
			round(100.0*sum(churn)/count(*),2) as churn_rat
from subscription_customers
group by city
order by churn_rat desc ;


-- Average CLTV by Plan 

select PlanType,
				count(*) as customer ,
                round(avg(cltv),2) as avg_cltv,
                round(sum(cltv),2) as total_cltv
from subscription_customers 
group by plantype
order by avg_cltv desc;


-- 3 Who’s at risk: last login > 30 days & low logins

select * FROM subscription_customers
where DaysSinceLastLogin > 30 
       and NumLogins_Last30Days < 3  
       and churn = 0  
order by DaysSinceLastLogin desc ;

SELECT CustomerID, City, PlanType, DaysSinceLastLogin, NumLogins_Last30Days, CLTV
FROM subscription_customers
WHERE DaysSinceLastLogin > 30
  AND NumLogins_Last30Days < 3
  AND Churn = 0
ORDER BY DaysSinceLastLogin DESC;


-- Average support tickets vs churn

SELECT NumSupportTickets, 
       COUNT(*) AS cnt, 
       SUM(Churn) AS churned,
       ROUND(100.0 * SUM(Churn)/COUNT(*),2) AS churn_pct
FROM subscription_customers
GROUP BY NumSupportTickets
ORDER BY NumSupportTickets;

-- Cohort signups by month

SELECT datediff('month', SignupDate) AS cohort_month,
       COUNT(*) AS signups
FROM subscription_customers
GROUP BY cohort_month
ORDER BY cohort_month;

                