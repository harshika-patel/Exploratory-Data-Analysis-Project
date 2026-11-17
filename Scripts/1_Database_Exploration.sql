--1.1.Database Exploration
--explore all objects in the database
select * from information_schema.tables

--explore all columns in the database
select * from information_schema.columns
where table_name='dim_customers'
