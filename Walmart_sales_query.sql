CREATE DATABASE walmart_data;

select * from [Walmart Sales Data]

-- Add the time_of_day column
ALTER TABLE [Walmart Sales Data] 
ADD time_of_day VARCHAR(20);

UPDATE [Walmart Sales Data]
SET time_of_day = (
	CASE
	WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
    END
);

EXEC sp_rename '[Walmart Sales Data].[sale_date]', 'date', 'COLUMN';

-- Add day_name column
ALTER TABLE [Walmart Sales Data] 
ADD day_name VARCHAR(10);

UPDATE [Walmart Sales Data]
SET day_name = DATENAME(weekday, date)

-- Add month_name column
ALTER TABLE [Walmart Sales Data] 
ADD month_name VARCHAR(10);

UPDATE [Walmart Sales Data]
SET month_name = datename(MONTH, Date);

-- How many unique product lines does the data have?
SELECT Count(DISTINCT product_line)
FROM [Walmart Sales Data];

-- Which is the most common payment method?
SELECT TOP 1 Payment, COUNT(*) AS PaymentCount
FROM [Walmart Sales Data]
GROUP BY Payment
ORDER BY PaymentCount DESC;

-- Which is the most selling product line?
SELECT TOP 1 Product_line, SUM(Quantity) AS TotalQuantity
FROM [Walmart Sales Data]
GROUP BY Product_line
ORDER BY TotalQuantity DESC;

-- What is the total revenue by month?
SELECT month_name AS month, SUM(total) AS total_revenue
FROM [Walmart Sales Data]
GROUP BY month_name 
ORDER BY total_revenue;

-- Find monthwise COGS?
SELECT  month_name AS month, SUM(cogs) AS cogs
FROM [Walmart Sales Data]
GROUP BY month_name 
ORDER BY cogs desc;

-- Which product line had the largest revenue?
SELECT TOP 1 product_line, SUM(total) as total_revenue
FROM [Walmart Sales Data]
GROUP BY product_line
ORDER BY total_revenue DESC;

-- City with the largest revenue?
SELECT TOP 5 city, SUM(total) AS total_revenue
FROM [Walmart Sales Data]
GROUP BY city 
ORDER BY total_revenue;

-- Which product line had the largest revenue?
SELECT product_line, SUM(total) as total_revenue
FROM [Walmart Sales Data]
GROUP BY product_line
ORDER BY total_revenue DESC;


-- Which product line had the largest VAT?
SELECT TOP 1 Product_line, SUM(Tax_5) AS TotalVAT
FROM [Walmart Sales Data]
GROUP BY [Product_line]
ORDER BY TotalVAT DESC;


-- Fetch each product line and its average quantity. Add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales
WITH ProductLineAverages AS (
    SELECT 
        Product_line, 
        AVG(Quantity) AS AvgQuantity,
        AVG(AVG(Quantity)) OVER () AS OverallAvgQuantity
    FROM [Walmart Sales Data]
    GROUP BY Product_line
)
SELECT 
    Product_line, 
    AvgQuantity,
    CASE
        WHEN AvgQuantity > OverallAvgQuantity THEN 'Good'
        ELSE 'Bad'
    END AS Remark
FROM ProductLineAverages;

-- Which branch sold more products than average product sold?
SELECT branch, SUM(quantity)
FROM [Walmart Sales Data]
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM [Walmart Sales Data]);

-- Which is the most common product line by gender?
SELECT product_line, gender, COUNT(gender) AS total_cnt
FROM [Walmart Sales Data]
GROUP BY product_line, gender
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 2) as avg_rating
FROM [Walmart Sales Data]
GROUP BY product_line
ORDER BY avg_rating DESC;

-- How many unique customer types does the data have?
SELECT DISTINCT customer_type
FROM [Walmart Sales Data];

-- How many unique payment methods does the data have?
SELECT DISTINCT payment
FROM [Walmart Sales Data];

-- Which is the most common customer type?
SELECT customer_type, count(*) as cnt
FROM [Walmart Sales Data]
GROUP BY customer_type
ORDER BY cnt DESC;

-- Which customer type buys the most?
SELECT customer_type, COUNT(*)
FROM [Walmart Sales Data]
GROUP BY customer_type;


-- What is the gender of most of the customers?
SELECT gender, COUNT(*) as gender_cnt
FROM [Walmart Sales Data]
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution for branch C?
SELECT gender, COUNT(*) as gender_cnt
FROM [Walmart Sales Data]
WHERE branch = 'C'
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT time_of_day, AVG(rating) AS avg_rating
FROM [Walmart Sales Data]
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings for branch A?
SELECT time_of_day, AVG(rating) AS avg_rating
FROM [Walmart Sales Data]
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg ratings?
SELECT day_name, AVG(rating) AS avg_rating
FROM [Walmart Sales Data]
GROUP BY day_name 
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings for branch C?
SELECT day_name, AVG(rating) AS avg_rating
FROM [Walmart Sales Data]
WHERE branch = 'C'
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Number of sales made in each time of the day on Sunday?
SELECT time_of_day, COUNT(*) AS total_sales
FROM [Walmart Sales Data]
WHERE day_name = 'Sunday'
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT customer_type, SUM(total) AS total_revenue
FROM [Walmart Sales Data]
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT city, ROUND(AVG(Tax_5),2) AS avg_tax_pct
FROM [Walmart Sales Data]
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT customer_type, AVG(Tax_5) AS total_tax
FROM [Walmart Sales Data]
GROUP BY customer_type
ORDER BY total_tax;


