/*
===============================================================================
--Now we move towrads the Advanced Analytics Project::
================================================================================
 here we used complezx queries, window functions, CTE, subqueries, reports
Advance Analytics
       7.Change over-time trends
       8.cumulative Analysis
       9.Perfromance Analysis
       10.part-to-whole proportional
       11.data Segmentation
       12.Reporting
 */
 -- 7.Change over-time trends--
 --analyze how a measure evolves over time.
 --helps track trends and identity seasonality in your data
 --sum [Measure] by [Date dimesion]
 --totalSale by year,
 --Average Cost by Month

 --analyse sales performance over Time
select year(order_date) Order_year,
sum(sales_amount) totalSale ,
count(customer_key) total_customer
from gold.fact_sales
where order_date is not null
group by year(order_date)
order by year(order_date)

select year(order_date) Order_year,
Month(order_date) Order_month,
sum(sales_amount) totalSale ,
count(customer_key) total_customer
from gold.fact_sales
where order_date is not null
group by year(order_date),Month(order_date)
order by year(order_date),Month(order_date)

select
DATETRUNC(month,order_date),
sum(sales_amount) totalSale ,
count(customer_key) total_customer
from gold.fact_sales
where order_date is not null
group by DATETRUNC(month,order_date)
order by DATETRUNC(month,order_date)

select
FORMAT(order_date,'yyyy-MMM'),
sum(sales_amount) totalSale ,
count(customer_key) total_customer
from gold.fact_sales
where order_date is not null
group by FORMAT(order_date,'yyyy-MMM')
order by FORMAT(order_date,'yyyy-MMM')

