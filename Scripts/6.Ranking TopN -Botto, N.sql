--6.ranking -top N to bottom N
--order the values of dimensions by measure.
--top N perfromarnce , bottom N perfromnace
--Rank [Dimension] by sum[Measure]
--Rank countries by total_sales
--top 5 products by quantity
--bottom 3 customes by totalOrders

--which 5 products generate dthe highest revenue

select top 5 p.product_name,sum(f.sales_amount) Salerevenue from gold.fact_sales f left join gold.dim_products p
on f.product_key=p.product_key
group by p.product_name
order by Salerevenue  desc

--or
select * from(select p.product_name,sum(f.sales_amount) Salerevenue ,
rank() over(order by sum(f.sales_amount) desc ) as ranked_products
from gold.fact_sales f left join gold.dim_products p
on f.product_key=p.product_key
group by p.product_name)t
where ranked_products<=5

--what are the 5 worst -perfoming products in terms of sales
select top 5 p.product_name,sum(f.sales_amount) Salerevenue from gold.fact_sales f left join gold.dim_products p
on f.product_key=p.product_key
group by p.product_name
order by Salerevenue  asc

--find the top10 customers who have generated the highest revenue and 3 customers with the fewest orders placed
select * from (select  c.customer_key,c.first_name,c.last_name,sum(f.sales_amount) totalSale,
rank() over(order by sum(f.sales_amount) desc) as ranked_products
from gold.fact_sales f left join
gold.dim_customers c on c.customer_key=f.customer_key
group by c.customer_key,c.first_name,c.last_name)t
where ranked_products<=10 and ranked_products
--3 customers with the fewest orders placed
select top 3 c.customer_key,c.first_name,c.last_name,count(distinct f.order_number) TotalOrder
from gold.fact_sales f left join
gold.dim_customers c on c.customer_key=f.customer_key
group by c.customer_key,c.first_name,c.last_name
order by TotalOrder asc
