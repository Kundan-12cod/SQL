use project;
select * from supply_chain_data;
drop table supply_chain_data;


-- Total revenue by region

select region,round(sum(revenue)) as Total_revenue
from supply_chain_data 
group by region
order by Total_revenue desc; 


-- 2. Average supplier rating per category

select Category,avg(SupplierRating) as Avg_SupplierRating
from supply_chain_data
group by Category 
order by Avg_SupplierRating asc;

SELECT Category, AVG(SupplierRating) AS AvgRating
FROM supply_chain_data
GROUP BY Category;


-- 3. Stock shortages
select productid ,region,stocklevel
from supply_chain_data
where stocklevel > 500
order by stocklevel asc;
