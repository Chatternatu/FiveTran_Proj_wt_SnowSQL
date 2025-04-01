--create a data warehouse
create or replace warehouse aaliyah_wh
warehouse_size = xsmall;

--create database
create or replace database afolasoge_db;
use database afolasoge_db;
--create schema
create schema leyeah_schema;

CREATE OR REPLACE ROLE FIVETRAN_ROLE;
--CREATE OR REPLACE USER FIVETRAN_USER;

GRANT USAGE ON WAREHOUSE aaliyah_wh TO ROLE FIVETRAN_ROLE;
GRANT USAGE ON DATABASE afolasoge_db TO ROLE FIVETRAN_ROLE;
GRANT USAGE, CREATE TABLE ON SCHEMA afolasoge_db.leyeah_schema TO ROLE FIVETRAN_ROLE;
GRANT ROLE FIVETRAN_ROLE TO USER Chatternatu;

--grant all privileges on database afolasoge_db to role FIVETRAN_ROLE;

--Using the snowsql command-line client to test the my swowflak credentials and account identifier:
snowflakecomputing.com -u Chatternatu -p Brainy2804@ -w aaliyah_wh -d afolasoge_db -s leyeah_schema;

--create target table in fivetran
--create orders table
create or replace table afolasoge_db.leyeah_schema.retail_sales_dataset
(
    transaction_id varchar not null,
    date date not null,
    customer_id varchar not null,
    gender varchar not null,
    age int not null,
    product_category varchar not null,
    quantity int,
    price_per_unit float not null,
    total_amount float not null
    );
     select * from retail_sales_dataset;
   show tables;
  show warehouses;

   -- Enhancing the retail Dataset for Analysis
   --Check for missing values in quantity
SELECT COUNT(*) FROM retail_sales_dataset WHERE quantity IS NULL;

-- Handle missing values (e.g., replace with 0)
UPDATE retail_sales_dataset SET quantity = 0 WHERE quantity IS NULL;

-- Identify and remove duplicate records
CREATE OR REPLACE TABLE retail_sales_dataset AS
SELECT DISTINCT * FROM retail_sales_dataset
where Age is not null;

--Checking to see if duplicates were present in the first place
Select count(*) from retail_sales_dataset;     --Result shows no duplicates

--Transformation of the retail Dataset
  -- Aggregate sales by product category

    --Creating Objects(VIEW)
CREATE OR REPLACE VIEW sales_by_category AS
SELECT product_category, SUM(total_amount) AS total_sales
FROM retail_sales_dataset
GROUP BY product_category; 

--Checking to see the view created
Select * from sales_by_category;

--Adding column to retail dataset for Customer Segmentation by age range
ALTER TABLE retail_sales_dataset ADD COLUMN Age_group VARCHAR;
UPDATE retail_sales_dataset
SET Age_group = CASE
    WHEN Age < 25 THEN '18-24'
    WHEN Age < 35 THEN '25-34'
    WHEN Age < 45 THEN '35-44'
    ELSE '45+'
END;

Select * from retail_sales_dataset;
 