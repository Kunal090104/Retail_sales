-- SQL Retail Sales Analysis 

-- CREATE TABLE
create table retail_sales
				(
					transactions_id	INT PRIMARY KEY,
					sale_date DATE,
					sale_time TIME,
					customer_id INT,
					gender VARCHAR(20),
					age INT,
					category VARCHAR(20),	
					quantiy INT,
					price_per_unit FLOAT,	
					cogs FLOAT,
					total_sale FLOAT
				);

ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning

SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE quantiy IS NULL;

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR 
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- 
DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR 
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
	
-- Data Exploration
-- Ho many sales we have?
SELECT COUNT(*) as total_sales FROM retail_sales;

-- How many custoners we have?
SELECT COUNT(DISTINCT customer_id) as total_customers FROM retail_sales;

-- How many categories we have?
SELECT COUNT(DISTINCT category) as total_category FROM retail_sales;

-- what are the different categories?
SELECT DISTINCT category as categories FROM retail_sales;

-- Data Analysis & Business Key Problems 

-- My Analysis and Findings.
-- Q.1 Write a SQL query to find the total number of orders placed by each customer.
-- Q.2 Write a SQL query to find the number of customers for each gender.
-- Q.3 Write a SQL query to calculate the total quantity of products sold in each category.
-- Q.4 Write a SQL query to find the average price per unit for each product category.
-- Q.5 Write a SQL query to find all customers whose age is greater than the average customer age.
-- Q.6 Write a SQL query to retrieve all transactions where only one item was purchased.
-- Q.7 Write a SQL query to calculate the total sales amount for each sale date.
-- Q.8 Write a SQL query to identify the product category with the highest number of orders.
-- Q.9 Write a SQL query to find the minimum and maximum age of customers in the dataset.
-- Q.10 Write a SQL query to create each shift and number of orders (Example: Morning <= 12, Afternoon Between 12 & 17, Evening >17)
-- Q.11 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.


-- Q.1 Write a SQL query to find the total number of orders placed by each customer.
SELECT customer_id, COUNT(*) as Total_orders FROM retail_sales
GROUP BY customer_id ORDER BY customer_id;


-- Q.2 Write a SQL query to find the number of customers for each gender.
SELECT gender, COUNT(DISTINCT customer_id) as total_customers FROM retail_sales
GROUP BY gender;


-- Q.3 Write a SQL query to calculate the total quantity of products sold in each category.
select category, SUM(quantity) as Total_quantity FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average price per unit for each product category.
SELECT category, AVG(price_per_unit) as Avg_price_per_unit FROM retail_sales
GROUP BY category;


-- Q.5 Write a SQL query to find all customers whose age is greater than the average customer age.
SELECT customer_id, MAX(age) AS age FROM retail_sales
GROUP BY customer_id
HAVING MAX(age) > (SELECT AVG(age) FROM retail_sales)
ORDER BY customer_id;


-- Q.6 Write a SQL query to retrieve all transactions where only one item was purchased.
SELECT transactions_id, quantity FROM retail_sales
WHERE quantity = 1;


-- Q.7 Write a SQL query to calculate the total sales amount for each sale date.
SELECT sale_date, SUM(total_sale) as total_amount FROM retail_sales
GROUP BY sale_date;


-- Q.8 Write a SQL query to identify the product category with the highest number of orders.
SELECT category, COUNT(*)as number_of_orders FROM retail_sales
GROUP BY category
ORDER BY number_of_orders DESC
LIMIT 1;


-- Q.9 Write a SQL query to find the minimum and maximum age of customers in the dataset.
SELECT MIN(age) as min_age, MAX(age) as max_age FROM retail_sales;


-- Q.10 Write a SQL query to create each shift and number of orders (Example: Morning <= 12, Afternoon Between 12 & 17, Evening >17).
SELECT 
CASE 
	WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'MORNING'
	WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'EVENING'
	ELSE 'AFTERNOON'
	END AS shift,
	COUNT(*) AS no_of_orders
FROM retail_sales
GROUP BY shift
ORDER BY shift;


-- Q.11 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT year, month, Avg_sale FROM
(
	SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as Avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank FROM retail_sales
	GROUP BY year, month
) as T1
WHERE rank = 1;

-- END OF PROJECT






