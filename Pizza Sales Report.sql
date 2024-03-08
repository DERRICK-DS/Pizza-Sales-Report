--

SELECT *
FROM dbo.pizza_sales

-- 1.Total Revenue

SELECT 
     SUM(total_price) as Total_Revenue
FROM pizza_sales

-- 2.Average Order Value

SELECT 
     SUM(total_price)/ COUNT(DISTINCT order_id) as Avg_order_value
FROM pizza_sales

-- 3.Total Pizzas Sold

SELECT 
     SUM(quantity) as Total_pizzas_sold
FROM dbo.pizza_sales

-- 4.Total Orders

SELECT 
     COUNT(DISTINCT(order_id)) as Total_orders
FROM pizza_sales

-- 5. Average Pizzas Per Order


SELECT 
   CAST(CAST(SUM(quantity) AS DECIMAL (10,2))/ CAST(COUNT(DISTINCT(order_id)) AS DECIMAL (10,2)) AS DECIMAL (10,2)) as Avg_pizzas_per_order
FROM dbo.pizza_sales


-- CHARTS REQUIREMENTS
-- 1.Daily Trend for Total Orders.

SELECT 
     DATENAME(DW, order_date) as order_day,
	 COUNT(DISTINCT(order_id)) as Total_orders
FROM dbo.pizza_sales
GROUP BY  DATENAME(DW, order_date)
ORDER BY 2 DESC

-- 2. Monthly/Hourly Trend for Orders.
--Monthly Trend

SELECT 
     DATENAME(MONTH, order_date) AS order_month,
     COUNT(DISTINCT(order_id)) as Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY 2 DESC

--Hourly Trend

SELECT 
     DATEPART(HOUR, order_time) as order_hour,
	 COUNT(DISTINCT(order_id)) as Total_orders
FROM dbo.pizza_sales
GROUP BY   DATEPART(HOUR, order_time)
ORDER BY 2 

-- 3.Percentage of Sales by Pizza Category.

SELECT 
    pizza_category,
	SUM(total_price),
	ROUND(SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizza_sales), 2)  as pct_total_sales
FROM dbo.pizza_sales
GROUP BY pizza_category
ORDER BY 2 DESC

-- 4.Percentage of Sales by Pizza Size.

SELECT 
    pizza_size,
	CAST(SUM(total_price)AS DECIMAL (10,2)) as total_price_per_size,
	ROUND(SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizza_sales), 2)  as pct_total_sales
FROM dbo.pizza_sales
--WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY 2 DESC

-- 5.Total Pizzas Sold by Pizza Category

SELECT 
     SUM(quantity) as qty_by_category,
	 pizza_category
FROM dbo.pizza_sales
GROUP BY  pizza_category

-- 6.Top 5 Pizzas by Revenue, Total Quantity and Total Orders.
-- by Revenue

SELECT TOP 5
     pizza_name,
	 SUM(total_price) as top5_pizza_Rev
FROM dbo.pizza_sales
GROUP BY  pizza_name
ORDER BY 2 DESC


-- by Quantity

SELECT TOP 10
     pizza_name,
	 SUM(quantity) as top5_pizza_qty
FROM dbo.pizza_sales
GROUP BY  pizza_name
ORDER BY 2 DESC

-- by orders
-- BOTTOM 5...
SELECT TOP 5
     pizza_name,
	 COUNT(DISTINCT order_id) as top5_pizza_orders
FROM dbo.pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY  pizza_name
ORDER BY 2 ASC

SELECT 
      pizza_size,
	  SUM(quantity)
FROM pizza_sales
GROUP BY pizza_size








     




