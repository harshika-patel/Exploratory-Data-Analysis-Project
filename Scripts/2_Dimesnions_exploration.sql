--2.diemsions exploration--identifying the unique vaules or categories in each dimensions .
--recognizing how data might be grouped ir segmented which is useful for later analysis.
--using distinct we can identify diemension --get all unique values
--explore all countries our customes come from
select distinct country from gold.dim_customers

--explore all category the majop divisions
select distinct category,subcategory,product_name from gold.dim_products
order by 1,2,3
