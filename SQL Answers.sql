-- Questions Set A

-- 1.How many pizzas were ordered?

SELECT COUNT(*) as total_num_pizzas_ordered
FROM customer_orders;

-- 2.How many unique customer orders were made?

SELECT COUNT(DISTINCT order_id) as unique_customer_orders
FROM customer_orders; 

-- 3.How many successful orders were delivered by each runner?

SELECT r.runner_id,
COUNT(DISTINCT c.order_id) as delivered_count
FROM customer_orders as c
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
WHERE  r.pickup_time != 'null'
GROUP BY r.runner_id;

-- 4.How many of each type of pizza was delivered?

SELECT p.pizza_name,
COUNT(c.order_id) as pizza_count
FROM customer_orders as c
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
INNER JOIN pizza_names as p
ON c.pizza_id = p.pizza_id
WHERE  r.pickup_time != 'null'
GROUP BY p.pizza_name;


-- 5.How many Vegetarian and Meatlovers were ordered by each customer?

SELECT c.customer_id,
p.pizza_name,
COUNT(c.order_id) as pizza_count
FROM customer_orders as c
INNER JOIN pizza_names as p
ON c.pizza_id = p.pizza_id
GROUP BY c.customer_id, p.pizza_name;

-- 6.What was the maximum number of pizzas delivered in a single order?

SELECT c.order_id,
COUNT(c.pizza_id) as Pizzas_delivered
FROM customer_orders as c
INNER JOIN pizza_names as p
ON c.pizza_id = p.pizza_id
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
WHERE  r.pickup_time != 'null'
GROUP BY c.order_id,r.pickup_time
ORDER BY Pizzas_delivered DESC
LIMIT 1;


-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT c.customer_id,
SUM(CASE WHEN c.exclusions IS NOT NULL AND c.exclusions != 'null' AND c.exclusions > 0 THEN 1 
WHEN c.extras IS NOT NULL AND c.extras != 'null' AND c.extras > 0 THEN 1 ELSE 0 END) AS Changes,
SUM(CASE WHEN c.exclusions IS NOT NULL AND c.exclusions != 'null' AND c.exclusions > 0 THEN 0 
WHEN c.extras IS NOT NULL AND c.extras != 'null' AND c.extras > 0 THEN 0 ELSE 1 END) AS No_Changes
FROM customer_orders as c
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
WHERE  r.pickup_time != 'null'
GROUP BY c.customer_id;

-- 8. How many pizzas were delivered that had both exclusions and extras?

SELECT 
COUNT(pizza_id) as pizza
FROM customer_orders as c
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
WHERE  r.pickup_time != 'null' 
AND (c.exclusions IS NOT NULL AND c.exclusions != 'null' AND c.exclusions)
AND (c.extras IS NOT NULL AND c.extras != 'null' AND c.extras > 0)
GROUP BY customer_id;

-- 9.What was the total volume of pizzas ordered for each hour of the day?

SELECT
COUNT(pizza_id) as pizza_volume,
extract(HOUR FROM order_time) as Hour_of_day
FROM customer_orders as c
GROUP BY Hour_of_day
Order BY Hour_of_day;



-- 10.What was the volume of orders for each day of the week?

SELECT
COUNT(pizza_id) as pizza_volume,
WEEKDAY(order_time) as Day_of_week
FROM customer_orders as cz
GROUP BY Day_of_week
Order BY Day_of_week;


