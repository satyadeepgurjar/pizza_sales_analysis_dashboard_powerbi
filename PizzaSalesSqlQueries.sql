SELECT * from pizza_sales
-- Total revenue
Select SUM(total_price) AS Total_Revenue
from pizza_sales 

-- AverageOrderValue
Select SUM(total_price)/COUNT(DISTINCT order_id) as Avg_order_value from pizza_sales


--Total Pizza Sold

SELECT SUM(quantity) as Total_Pizza_Sold 
from pizza_sales


--Total Order Placed

Select Count(DISTINCT order_id) AS Total_orders 
from pizza_sales

-- Avergae Pizzas Per Order

Select CAST(CAST(Sum(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))as DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
from pizza_sales



-- Daily Trend for Orders

SELECT DATENAME(DW,order_date) as order_day,COUNT(DISTINCT order_id) AS Total_orders
from pizza_sales
Group by DATENAME(DW,order_date)


-- Monthly Trend for orders
SELECT DATENAME(Month,order_date) as Month_Name,COUNT(DISTINCT order_id) AS Total_orders
from pizza_sales
Group by DATENAME(Month,order_date)
Order By Total_orders Desc



--Percentage of Sales by Pizza Category
Select pizza_category,cast(Sum(total_price)AS DECIMAL(10,2)) as Total_Sales ,
CAST(sum(total_price)*100/(select Sum(total_price) from pizza_sales)AS DECIMAL(10,2)) as PCT
from pizza_sales 
group by pizza_category 



--Percentage of sales by pizza_size
Select pizza_size,cast(Sum(total_price)AS DECIMAL(10,2)) as Total_Sales ,
CASt(sum(total_price)*100/(select Sum(total_price)  from pizza_sales)as DECIMAL(10,2)) as PCT
from pizza_sales 
group by pizza_size
order by PCT Desc


--Top 5 pizzas  by Revenue
SELECT TOP 5 pizza_name,SUM(total_price) as Total_Revenue from pizza_sales
Group by pizza_name 
order by Total_Revenue DESC


--Bottom 5 Pizzas By revenue
SELECT TOP 5 pizza_name,SUM(total_price) as Total_Revenue from pizza_sales
Group by pizza_name 
order by Total_Revenue ASC


--Top 5 pizzas by quantity

SELECT TOP 5 pizza_name,SUM(quantity) as Total_Quantity from pizza_sales
Group by pizza_name 
order by Total_Quantity DESC


--Bottom 5 pizzas by quantity

SELECT TOP 5 pizza_name,SUM(quantity) as Total_Quantity from pizza_sales
Group by pizza_name 
order by Total_Quantity ASC


--Top 5 pizzas by orders

SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id)AS Total_orders from pizza_sales
Group by pizza_name 
order by Total_Orders DESC

-- Bottom 5 pizzas by orders
SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id)AS Total_orders from pizza_sales
Group by pizza_name 
order by Total_Orders ASC






















































































