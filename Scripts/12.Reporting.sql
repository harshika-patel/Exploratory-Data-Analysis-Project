--12.build customer Reporting
/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
       - total orders
       - total sales
       - total quantity purchased
       - total products
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last order)
       - average order value
       - average monthly spend
===============================================================================
*/

--for big queries 
--1. i start gathering data first i take data from facts tables and move towards dimesions tables for that we used join
--where filter data
--and we create based data in from of CTE
--after that transformation

--step1:base query retrieves core columns from tables 
create view gold.report_customer as 
with base_query as(
select c.customer_key,
c.customer_number, 
concat(c.first_name,' ',c.last_name) as Customer_name,
datediff(year,c.birthdate,getdate()) as age,
p.category,
f.product_key,
f.sales_amount,
f.order_number,
f.order_date,
f.quantity
from gold.fact_sales f left join gold.dim_customers c
on f.customer_key=c.customer_key left join gold.dim_products p
on f.product_key=p.product_key
where order_date is not null),

--step2: create new cTe here aggregations
customer_aggregation as(select customer_key,
customer_number, 
Customer_name,
age,
count(distinct product_key) TotalProduct,
sum(sales_amount) totalSale,
count(distinct order_number) totalOrder,
sum(quantity) TotalQuantity,
max(order_date)  last_order_date,
datediff(month,min(order_date),max(order_date)) as lifespan
from base_query
group by customer_key,
customer_number, 
Customer_name,age)

--step: 3final query
select customer_key,
customer_number, 
Customer_name,
age,
case when age<20 then 'Under 20'
     when age between 20 and 29 then'20-29'
     when age between 30 and 39 then'30-39'
     when age between 40 and 49 then'40-49'
     else '50 and above'
end age_group,
case when lifespan >=12 and totalSale>5000 then 'VIP'
    when lifespan >=12 and totalSale<=5000 then 'Regular'
    else 'New'
end as Customer_segment,
last_order_date,
datediff(month,last_order_date,getdate()) recency,
TotalProduct,
totalSale,
totalOrder,
--average order value
case when totalOrder=0 then 0
 else totalSale/totalOrder 
end as avg_order_value,
TotalQuantity,
--compute average monlty spend--total sale/Number of months
case when lifespan=0 then totalSale
       else totalSale/lifespan 
 end as Avg_monthly_spend,
lifespan 
from customer_aggregation
--now whole query is ready so put as a view

--now check in view
select * from gold.report_customer

