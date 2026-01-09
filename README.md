# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to showcase SQL skills and techniques commonly used by data analysts for exploring, cleaning, and analyzing retail sales data. It involves the creation of a retail sales database, the execution of exploratory data analysis (EDA), and the formulation of SQL queries to address specific business questions. The project is intended for individuals at the early stages of their data analysis journey and aims to build a strong foundational understanding of SQL concepts and practical applications.

## Objectives

1. **Retail Sales Database Setup**: Design, create, and populate a retail sales database using the provided sales data.
2. **Data Cleaning and Validation**: Identify, analyze, and remove records containing missing, null, or inconsistent values to ensure data quality.
3. **Exploratory Data Analysis (EDA)**: Conduct exploratory data analysis to examine data distributions, identify patterns, and gain an overall understanding of the dataset.
4. **Business-Oriented Analysis**: Apply SQL queries to address specific business questions and extract meaningful insights from the retail sales data.

## Project Structure

### 1. Retail Sales Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
-- Method1; By manually selecting and creating a database. 
-- Method2; CREATE DATABASE sql_project_p1.

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


### 2. Data Cleaning and Validation

- **Record Count**: Calculated the total number of transactions present in the retail sales dataset.
- **Customer Count**: Identified the total number of unique customers by counting distinct customer identifiers.
- **Category Identification**: Retrieved all unique product categories available in the dataset to understand the product mix..
- **Null Value Detection and Removal**: Examined the dataset for missing or null values across all relevant columns and removed records containing incomplete data to maintain data integrity.

```sql
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
```

### 3. Data Analysis & Business Key Problems 

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to find the total number of orders placed by each customer**:
```sql
SELECT customer_id, COUNT(*) as Total_orders FROM retail_sales
GROUP BY customer_id ORDER BY customer_id;
```

2. **Write a SQL query to find the number of customers for each gender**:
```sql
SELECT gender, COUNT(DISTINCT customer_id) as total_customers FROM retail_sales
GROUP BY gender;
```

3. **Write a SQL query to calculate the total quantity of products sold in each category**:
```sql
select category, SUM(quantity) as Total_quantity FROM retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average price per unit for each product category**:
```sql
select category, SUM(quantity) as Total_quantity FROM retail_sales
GROUP BY category;
```

5. **Write a SQL query to find all customers whose age is greater than the average customer age**:
```sql
SELECT customer_id, MAX(age) AS age FROM retail_sales
GROUP BY customer_id
HAVING MAX(age) > (SELECT AVG(age) FROM retail_sales)
ORDER BY customer_id;
```

6. **Write a SQL query to calculate the total sales amount for each sale date**:
```sql
SELECT transactions_id, quantity FROM retail_sales
WHERE quantity = 1;
```

7. **Write a SQL query to calculate the total sales amount for each sale date**:
```sql
SELECT sale_date, SUM(total_sale) as total_amount FROM retail_sales
GROUP BY sale_date;
```

8. **Write a SQL query to identify the product category with the highest number of orders**:
```sql
SELECT category, COUNT(*)as number_of_orders FROM retail_sales
GROUP BY category
ORDER BY number_of_orders DESC
LIMIT 1;
```

9. **Write a SQL query to find the minimum and maximum age of customers in the dataset**:
```sql
SELECT MIN(age) as min_age, MAX(age) as max_age FROM retail_sales;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

11. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**:
```sql
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
```

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub to your local system using the following command:
   git clone <repository-url>
2. **Set Up the Database**: Open your SQL client (e.g., pgAdmin or MySQL Workbench) and connect to your database server.
   Create or select the database named `sql_project_p1`, then execute the SQL script provided in the `database_setup.sql` file to create the required tables and populate them        with data.
3. **Run the Queries**: After the database setup is complete, run the SQL queries available in the `analysis_queries.sql` file. These queries perform data exploration, cleaning,     and business analysis on the `sql_project_p1` database.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.


This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles.


This project is inspired by Youtuber: Zero Analyst (git:https://github.com/najirh)
