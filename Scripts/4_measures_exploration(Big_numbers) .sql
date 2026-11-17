--4..measure exploration-calculate the key metric of the business (Big Numbers)
--highest Level of Aggregation |lowest Level Of details
--using sum,avg we can find the measures

--find the total Sales
select sum(sales_amount) totalSale from gold.fact_sales
--Find how many items are sold
select sum(quantity) from gold.fact_sales
--find the average selling price
select avg(price) avgPrice from gold.fact_sales

--Find the Total Number of Orders
select count(order_number) totalOrder from gold.fact_sales
select count(distinct order_number) totalOrder from gold.fact_sales

--Find the Total Number of Products
select count(product_key) from gold.dim_products
select count(product_id) from gold.dim_products

--Find The total Number of Customers
select count(distinct customer_id) from gold.dim_customers
select count(customer_id) from gold.dim_customers

--Find the Total Number of customers that has placed an order
select count(distinct customer_key) from gold.fact_sales

--SQL TAsk--Generate Report that shows all key matrics of the business
select 'totalSale' as Measure_name ,sum(sales_amount) as Measure_value from gold.fact_sales
union all
select 'TotalQuantity',sum(quantity) from gold.fact_sales
union all
select 'avgPrice', avg(price)  from gold.fact_sales
union all
select 'totalOrder' ,count(distinct order_number)  from gold.fact_sales
union all
select 'TotalProduct' ,count(product_id) from gold.dim_products
union all
select 'Total nr. customer',count(distinct customer_id) from gold.dim_customers
union all
select 'Total nr. customer place order', count(distinct customer_key) from gold.fact_sales
