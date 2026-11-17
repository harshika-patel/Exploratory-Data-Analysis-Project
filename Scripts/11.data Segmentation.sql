--Data segmentation:-
--group the data based on a specific range.
--helps understand the correlation between two measures.
--formula
--[measure] by [measure]
--total products by sales range
--total customers by age
--for that we use case when stmts

--sql task-segment products into cost ranges and count how many products fall into each segment.
with products_segments as(
select product_key,product_name,cost,
case when cost < 100 then  'below 100'
     when cost between 100 and 500 then  '100-500'
     when cost between 500 and 1000 then  '1000-500'
     else'above 1000'
end segment
from gold.dim_products)

select segment,count(product_key) totalProduct 
from products_segments
group by segment


--group customers into three segments based on their spending behaviours:
--VIP: customers with at least 12 months of hisrtoty and spending more than 5000$
--regular: customers with altease 12 month  of history but spending   5000 or lese
--new:customers with a lifespan less than 12 months
--and find the total num,bers of customers by each group
with customer_segments as(select c.customer_key,
sum(f.sales_amount) as total_spending,
min(order_date) as firstorder,
max(order_date) as lastorder,
datediff(month,min(order_date) ,max(order_date)) MonthsHistory
from gold.dim_customers c left join gold.fact_sales f
on c.customer_key=f.customer_key
group by c.customer_key),

customerGroups as (select *,
case when MonthsHistory >= 12 and total_spending > 5000 then 'VIP'
when MonthsHistory >=12 and total_spending < = 5000 then 'Regular'
else 'New'
end CustomerGroupSegment
from customer_segments)

select CustomerGroupSegment,count(customer_key) totalCustomer from customerGroups
group by CustomerGroupSegment

