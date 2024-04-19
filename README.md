## Data-With-Danny-SQL-Challenge
This is a case study from the 8 Week SQL Challenge by Data with Danny.

This case study is done on the Pizza Runner Data set and below is the answers for Question Set A.

## Case Study 1                                                                                                                                       
[Case Study 2 - Pizza Runner](https://8weeksqlchallenge.com/case-study-2/) 

## SQL Soultions  (Case Statements,Date Functions,Joins)

[SQL Soultions]()

## Introduction

Did you know that over 115 million kilograms of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.


## Case Study Questions

-- -- 1.How many pizzas were ordered?
```sql  
SELECT COUNT(*) as total_num_pizzas_ordered
FROM customer_orders;
```


-- 2.How many unique customer orders were made?
```sql 
SELECT COUNT(DISTINCT order_id) as unique_customer_orders
FROM customer_orders; 
```


-- 3. 3.How many successful orders were delivered by each runner?
```sql  
SELECT r.runner_id,
COUNT(DISTINCT c.order_id) as delivered_count
FROM customer_orders as c
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
WHERE  r.pickup_time != 'null'
GROUP BY r.runner_id;
```
-- 4.How many of each type of pizza was delivered?
```sql
SELECT p.pizza_name,
COUNT(c.order_id) as pizza_count
FROM customer_orders as c
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
INNER JOIN pizza_names as p
ON c.pizza_id = p.pizza_id
WHERE  r.pickup_time != 'null'
GROUP BY p.pizza_name;
```
-- 5.How many Vegetarian and Meatlovers were ordered by each customer?
```sql
SELECT c.customer_id,
p.pizza_name,
COUNT(c.order_id) as pizza_count
FROM customer_orders as c
INNER JOIN pizza_names as p
ON c.pizza_id = p.pizza_id
GROUP BY c.customer_id, p.pizza_name;
```

-- 6.What was the maximum number of pizzas delivered in a single order?
```sql
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
```
-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
```sql
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
```

-- 8. How many pizzas were delivered that had both exclusions and extras?
```sql
SELECT 
COUNT(pizza_id) as pizza
FROM customer_orders as c
INNER JOIN runner_orders as r
ON c.order_id = r.order_id
WHERE  r.pickup_time != 'null' 
AND (c.exclusions IS NOT NULL AND c.exclusions != 'null' AND c.exclusions)
AND (c.extras IS NOT NULL AND c.extras != 'null' AND c.extras > 0)
GROUP BY customer_id;
```

-- 9.What was the total volume of pizzas ordered for each hour of the day?
```sql
SELECT
COUNT(pizza_id) as pizza_volume,
extract(HOUR FROM order_time) as Hour_of_day
FROM customer_orders as c
GROUP BY Hour_of_day
Order BY Hour_of_day;
```


-- 10.What was the volume of orders for each day of the week?
```sql
SELECT
COUNT(pizza_id) as pizza_volume,
WEEKDAY(order_time) as Day_of_week
FROM customer_orders as cz
GROUP BY Day_of_week
Order BY Day_of_week;
```




