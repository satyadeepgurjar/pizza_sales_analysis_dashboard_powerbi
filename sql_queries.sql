create database coffee_shop_sales_db;

SELECT * FROM coffee_shop_sales;
describe coffee_shop_sales;
UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%d-%m-%Y');
ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_date DATE;
UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');
ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_time TIME;
ALTER TABLE coffee_shop_sales
CHANGE COLUMN  ï»¿transaction_id transaction_id INT;
SELECT ROUND(sum(unit_price* transaction_qty)) AS Total_sales
from coffee_shop_sales
where 
month(transaction_date)=3 -- march Month
SELECT 
    MONTH(transaction_date) AS month,
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5) -- for months of April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);
SELECT COUNT(transaction_id) AS Total_Orders
From coffee_shop_sales
WHERE
MONTH(transaction_date)=5 -- March Month   
SELECT 
    MONTH(transaction_date) AS month,
    ROUND(COUNT(transaction_id)) AS total_orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5) -- for April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);
 SELECT SUM(transaction_qty) as Total_Quantity_Sold
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 6 -- for month of (CM-May)
 SELECT 
    MONTH(transaction_date) AS month,
    ROUND(SUM(transaction_qty)) AS total_quantity_sold,
    (SUM(transaction_qty) - LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5)   -- for April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);
SELECT 
    CONCAT(ROUND(SUM(unit_price * transaction_qty) / 1000, 1),'K') AS total_sales,
    CONCAT(ROUND(COUNT(transaction_id) / 1000, 1),'K') AS total_orders,
    CONCAT(ROUND(SUM(transaction_qty) / 1000, 1),'K') AS total_quantity_sold
FROM 
    coffee_shop_sales
WHERE 
    transaction_date = '2023-05-18';
SELECT
CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
ELSE 'Weekdays'
END AS day_type,
CONCAT(round(SUM(unit_price*transaction_qty)/1000,1),'k') AS Total_sales
FROM coffee_shop_sales
where month(transaction_date)=2 -- feb month
GROUP BY
CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
ELSE 'Weekdays'
END  
SELECT
 store_location,
 CONCAT(ROUND(sum(unit_price * transaction_qty)/1000,2),'K') AS Total_sales 
FROM coffee_shop_sales
WHERE MONTH(transaction_date)=5  -- may
GROUP BY store_location 
 ORDER BY sum(unit_price * transaction_qty) DESC
 SELECT CONCAT(ROUND(AVG(total_sales)/1000,1),'K') AS average_sales
FROM (
    SELECT 
        SUM(unit_price * transaction_qty) AS total_sales
    FROM 
        coffee_shop_sales
	WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        transaction_date
) AS internal_query;
SELECT 
day(transaction_date) AS day_of_month,
sum(unit_price *transaction_qty)AS tatal_sales
FROM coffee_shop_sales
where month(transaction_date)=5
group by day(transaction_date)
order by day(transaction_date)
SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'equal to Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)
) AS sales_data
ORDER BY 
    day_of_month;
SELECT 
product_category,
SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE month(transaction_date)=5
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) desc
SELECT 
product_type,
SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE month(transaction_date)=5 AND product_category='coffee'
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) desc
LIMIT 10
SELECT 
SUM(unit_price * transaction_qty) AS total_sales,
SUM(transaction_qty) as Total_qty_sold,
count(*) AS total_orders
FROM coffee_shop_sales
WHERE month(transaction_date)=5 -- may
AND DAYOFWEEK(transaction_date)=2 -- monday
AND hour(transaction_time)=8 -- HOUR NO 8
select 
hour(transaction_time),
sum(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
where month(transaction_date)=5
group by hour(transaction_time)
order by hour(transaction_time)
SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END;



 