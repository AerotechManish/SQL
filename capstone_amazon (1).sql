-- Capstone Project : 
-- Step 1 :Created database amazon 
Create database amazon;
use amazon;
-- Step 2 : create schema of 'amazon' table :
CREATE TABLE amazon (
    InvoiceID VARCHAR(20),
    branch CHAR(1),
    city VARCHAR(50),
    customer_type VARCHAR(20),
    Gender VARCHAR(10),
    Product_line VARCHAR(50),
    Unit_price DECIMAL(10, 2),
    Quantity INT,
    VAT DECIMAL(10, 4),
    Total DECIMAL(10, 4),
    purchase_date DATE,
    purchase_time TIME,
    payment_method VARCHAR(20),
    cogs DECIMAL(10, 2),
    gross_margin DECIMAL(10, 9),
    gross_income DECIMAL(10, 4),
    rating DECIMAL(3, 1)
);

-- Step 3: Imported the data from csv file using 'Table data import wizard':
select * from amazon;

-- 1. What is the count of distinct cities in the dataset?
SELECT COUNT(DISTINCT city) AS distinct_city_count
FROM amazon;

-- 2.For each branch, what is the corresponding city?
SELECT branch, MAX(city) AS corresponding_city
FROM amazon
GROUP BY branch;

-- 3..What is the count of distinct product lines in the dataset?
SELECT COUNT(DISTINCT Product_line) AS distinct_product_line_count
FROM amazon;

-- 4.Which payment method occurs most frequently?
SELECT payment_method, COUNT(*) AS frequency
FROM amazon
GROUP BY payment_method
ORDER BY frequency DESC
LIMIT 1;

-- 5. Which product line has the highest sales?
SELECT Product_line, SUM(Total) AS total_sales
FROM amazon
GROUP BY Product_line
ORDER BY total_sales DESC
LIMIT 1;

-- 6. How much revenue is generated each month?
SELECT 
    MONTH(purchase_date) AS month,
    SUM(Total) AS monthly_revenue
FROM 
    Amazon
GROUP BY 
    MONTH(purchase_date);


-- 7. In which month did the cost of goods sold reach its peak?
SELECT 
    MONTH(purchase_date) AS month,
    SUM(cogs) AS total_cogs
FROM 
    Amazon
GROUP BY 
    MONTH(purchase_date)
ORDER BY 
    total_cogs DESC
LIMIT 1;

-- 8. Which product line generated the highest revenue?
SELECT 
    Product_line,
    SUM(Total) AS total_revenue
FROM 
    amazon
GROUP BY 
    Product_line
ORDER BY 
    total_revenue DESC
LIMIT 1;

-- 9. In which city was the highest revenue recorded?
SELECT 
    city,
    SUM(Total) AS total_revenue
FROM 
    amazon
GROUP BY 
    city
ORDER BY 
    total_revenue DESC
LIMIT 1;


-- 10. Which product line incurred the highest Value Added Tax?
SELECT 
    Product_line,
    SUM(VAT) AS total_VAT
FROM 
    amazon
GROUP BY 
    Product_line
ORDER BY 
    total_VAT DESC
LIMIT 1;

-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
SELECT 
    *,
    CASE 
        WHEN Total > (SELECT AVG(Total) FROM amazon) THEN 'Good'
        ELSE 'Bad'
    END AS sales_performance
FROM 
    amazon;

-- 12 .Identify the branch that exceeded the average number of products sold.
SELECT 
    branch
FROM 
    amazon
GROUP BY 
    branch
HAVING 
    AVG(Quantity) > (SELECT AVG(Quantity) FROM amazon);

-- 13. Which product line is most frequently associated with each gender?
SELECT 
    Gender,
    Product_line,
    COUNT(*) AS frequency
FROM 
    amazon
GROUP BY 
    Gender,
    Product_line
ORDER BY 
    Gender,
    frequency DESC;

-- 14. Calculate the average rating for each product line.
SELECT 
    Product_line,
    AVG(rating) AS average_rating
FROM 
    amazon
GROUP BY 
    Product_line;

-- 15. Count the sales occurrences for each time of day on every weekday.
SELECT 
    DAYNAME(purchase_date) AS weekday,
    purchase_time,
    COUNT(*) AS sales_occurrences
FROM 
    amazon
GROUP BY 
    weekday,
    purchase_time;

-- 16.Identify the customer type contributing the highest revenue.
SELECT 
    customer_type,
    SUM(Total) AS total_revenue
FROM 
    amazon
GROUP BY 
    customer_type
ORDER BY 
    total_revenue DESC
LIMIT 1;

-- 17.Determine the city with the highest VAT percentage.
SELECT 
    city,
    MAX(VAT) AS highest_VAT
FROM 
    amazon;

-- 18.Identify the customer type with the highest VAT payments.
SELECT 
    customer_type,
    SUM(VAT) AS total_VAT_payments
FROM 
    amazon
GROUP BY 
    customer_type
ORDER BY 
    total_VAT_payments DESC
LIMIT 1;

-- 19.What is the count of distinct customer types in the dataset?
SELECT 
    COUNT(DISTINCT customer_type) AS distinct_customer_types
FROM 
    amazon;

-- 20. What is the count of distinct payment methods in the dataset?
SELECT 
    COUNT(DISTINCT payment_method) AS distinct_payment_methods
FROM 
    amazon;

-- 21. Which customer type occurs most frequently?
SELECT 
    customer_type,
    COUNT(*) AS frequency
FROM 
    amazon
GROUP BY 
    customer_type
ORDER BY 
    frequency DESC
LIMIT 1;

-- 22.Identify the customer type with the highest purchase frequency.
SELECT 
    customer_type
FROM 
    amazon
GROUP BY 
    customer_type
ORDER BY 
    COUNT(*) DESC
LIMIT 1;

-- 23. Determine the predominant gender among customers.
SELECT 
    Gender,
    COUNT(*) AS frequency
FROM 
    amazon
GROUP BY 
    Gender
ORDER BY 
    frequency DESC
LIMIT 1;

-- 24.Examine the distribution of genders within each branch.
SELECT 
    branch,
    Gender,
    COUNT(*) AS frequency
FROM 
    amazon
GROUP BY 
    branch,
    Gender;

-- 25. Identify the time of day when customers provide the most ratings.
SELECT 
    purchase_time,
    COUNT(*) AS ratings_count
FROM 
    Amazon
GROUP BY 
    purchase_time
ORDER BY 
    ratings_count DESC
LIMIT 1;

-- 26. Determine the time of day with the highest customer ratings for each branch.
SELECT 
    branch,
    purchase_time,
    AVG(rating) AS average_rating
FROM 
    Amazon
GROUP BY 
    branch, purchase_time
ORDER BY 
    branch, average_rating DESC;

-- 27. Identify the day of the week with the highest average ratings.
SELECT 
    DAYNAME(purchase_date) AS day_of_week,
    AVG(rating) AS average_rating
FROM 
    Amazon
GROUP BY 
    day_of_week
ORDER BY 
    average_rating DESC
LIMIT 1;

-- 28.Determine the day of the week with the highest average ratings for each branch.
SELECT 
    branch,
    DAYNAME(purchase_date) AS day_of_week,
    AVG(rating) AS average_rating
FROM 
    Amazon
GROUP BY 
    branch, DAYOFWEEK(purchase_date)
ORDER BY 
    branch, average_rating DESC;
