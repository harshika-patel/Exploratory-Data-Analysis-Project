-Cumulative Analysis --aggreagate the data progressively over time.
--Helps to understand whether our business is growing or declining.
--sum [cumulative Measure]by [Date Dimension]
--running totalSale by year
--Moving Average and Sales By Month
--fro that we use aggregate window functions
--calculate the total sales per month and ruunin total of sales over time
select *,
sum(totalSale) over(order by Monthss) runningTotal,
avg(avgPrice) over(order by Monthss) movingAvg

from (select 
datetrunc(month,order_date) Monthss,
sum(sales_amount) totalSale,
avg(price) avgPrice
from gold.fact_sales
where order_date is not null
group by datetrunc(month,order_date))t

