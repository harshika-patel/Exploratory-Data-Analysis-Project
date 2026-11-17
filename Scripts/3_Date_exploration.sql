--3.Date Exploration--identify the earliest and latest dates (boundaries)
--understabd the scope of data and the timespan
--min/max function to indentify earliest and latest dates

--find the date of the first and last order
--how mant years if sales are available
select min(order_date) firstOrderDate,
max(order_date) lastOrderDate ,
DATEDIFF(year,min(order_date),max(order_date)) years_of_sales
from gold.fact_sales

--find the youngest and old customer
select first_name,last_name,birthdate,

from gold.dim_customers
where birthdate =(select min(birthdate) from gold.dim_customers)
or
birthdate =(select Max(birthdate) from gold.dim_customers)
order by birthdate
