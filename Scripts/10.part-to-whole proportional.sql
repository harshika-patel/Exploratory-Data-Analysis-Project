--part-to -whole anlaysis-proportional Analysis
--analye how an individual part is performaing compared to the overall , allowing us to understand which category has the 
--greatest impact on the business
--([measure]/total[measure])*100 by [dimesion]
--salesamount/sum(salesamount )*100 by category
--quanityt/total quantity * 100 by country

--which category contributes the most to overall sales?
with category_sales as
(select p.category,sum(f.sales_amount) TotalSale
from gold.fact_sales f left join gold.dim_products p
on f.product_key =p.product_key
group by category)

select category,totalSale,sum(TotalSale) over() overallSale,
concat(round((cast (totalSale as float)/sum(TotalSale) over()  )*100 ,2) ,'%')as percentage_total
from category_sales
