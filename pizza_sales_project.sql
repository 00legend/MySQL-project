create database pizza_sales_project;
use pizza_sales_project;

select * from pizzas;
select * from pizza_types;
select * from orders;
select * from order_details;

-- retrive total number order placed

select count(quantity) as total_order FROM order_details;

select count(order_id) as total_no_order FROM orders;

-- calculate total revenue generted from pizzas sales

select sum(od.quantity*p.price) as revenue
FROM pizzas as p
JOIN order_details as od 
ON p.pizza_id = od.pizza_id;

-- identitfy the heighest priced pizza

select max(price) as heighest_price
FROM pizzas;
-- or
select pt.name,count(p.price) as total_price
FROM pizzas as p
JOIN pizza_types as pt 
ON p.pizza_type = ot.pizza_type
GROUP BY pt.name,price;


-- identify the most common pizza size orderd

select p.size, count(od.order_details_id) 
FROM pizzas as p
JOIN order_details as od
ON p.pizza_id = od.pizza_id
GROUP BY size;

-- list by top 5 orderd pizza by quantity

select pt.name,sum(od.quantity) as TOTAL_QUANTITY
FROM pizzas as p
JOIN pizza_types as pt
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details as od
ON p.pizza_id= od.pizza_id
GROUP BY pt.name
ORDER BY TOTAL_QUANTITY DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pt.name,pt.category,sum(od.quantity) as quantity
FROM pizza_types as pt 
JOIN pizzas  as p 
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details as od
ON od.pizza_id = p.pizza_id
GROUP BY pt.name,pt.category;

-- Determine the distribution of orders by hour of the day.

select HOUR(o.time) as hour,count(*) as total_orders
FROM orders as o
GROUP BY hour
ORDER BY hour;

-- Category-wise Distribution of Pizzas

select pt.category , count(p.pizza_id) as total_pizzas
FROM pizza_types as pt
JOIN pizzas as p
ON pt.pizza_type_id = p.pizza_type_id
GROUP BY category;

-- Avergae number of pizzas orderd per day 

select o.date, avg(od.quantity) as total_average
FROM orders as o
JOIN order_details as od
ON o.order_id = od.order_id
GROUP BY o.date
ORDER BY o.date;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select o.date, avg(od.quantity) as average_number,sum(od.quantity)
FROM orders as o
JOIN order_details as od
ON o.order_id = od.order_id
GROUP BY o.date;

-- Top 3 Most Ordered Pizza Types Based on Revenue

select pt.name,SUM(od.quantity * p.price) as total_revenue
FROM pizza_types as pt
JOIN pizzas as p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details as od ON p.pizza_id = od.pizza_id
GROUP BY name
ORDER BY total_revenue DESC
LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

select pt.name , sum(od.quantity * p.price) as revenue,
                 (select (SUM(od2departmentcustomertaskcustomer.quantity * p.price) / SUM(od.quantity * p.price)) * 100 ) as total_percentage
FROM pizzas as p 
JOIN pizza_types as pt ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details as od ON p.pizza_id = p.pizza_id
GROUP BY pt.name;             
				

