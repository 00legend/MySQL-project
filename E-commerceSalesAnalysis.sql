create database E_commerce_Sales_Analysis;
use E_commerce_Sales_Analysis;

create table customer(
customer_id INT primary key auto_increment,
customer_name VARCHAR(50),
email varchar(50) NOT NULL,
city VARCHAR(50),
joined_date DATE
);

drop table customer;
drop table products;

create table products(
product_id INT PRIMARY KEY auto_increment,
product_name varchar(50),
category varchar(50),
price decimal(10,2)
);

create table orders(
order_id INT primary key auto_increment,
customer_id INT,
order_date date,
total_amount DECIMAL(10,2),
FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

drop table orders;

create table order_items(
order_item INT primary key auto_increment,
order_id INT ,
product_id INT ,
quaantity INT ,
price DECIMAL(10,2),
FOREIGN KEY(product_id) REFERENCES products(product_id),
FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

drop table order_items;

insert into customer(customer_name,email,city,joined_date) 
values ('John Smith', 'john.smith@example.com', 'New York', '2023-01-05'),
('Emily Davis', 'emily.davis@example.com', 'Los Angeles', '2023-02-10'),
('Michael Brown', 'michael.brown@example.com', 'Chicago', '2023-03-15'),
('Sarah Miller', 'sarah.miller@example.com', 'San Francisco', '2023-04-20'),
('David Wilson', 'david.wilson@example.com', 'Houston', '2023-05-25'),
('Jessica Taylor', 'jessica.taylor@example.com', 'Phoenix', '2023-06-30'),
('Daniel Anderson', 'daniel.anderson@example.com', 'San Diego', '2023-07-05'),
('Olivia Martinez', 'olivia.martinez@example.com', 'Dallas', '2023-08-10'),
('James Thomas', 'james.thomas@example.com', 'San Jose', '2023-09-15'),
('Sophia Jackson', 'sophia.jackson@example.com', 'Austin', '2023-10-20');

insert into products(product_name,category,price)
values('Laptop', 'Electronics', 599.99),
('Smartphone', 'Electronics', 399.50),
('Headphones', 'Accessories', 49.99),
('Coffee Maker', 'Home Appliances', 79.99),
('Running Shoes', 'Footwear', 89.99),
('Desk Chair', 'Furniture', 129.00),
('Backpack', 'Bags', 45.50),
('Wrist Watch', 'Accessories', 199.99),
('LED TV', 'Electronics', 799.99),
('Bluetooth Speaker', 'Electronics', 59.99);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-15', 200.50),
(2, '2024-01-16', 150.75),
(3, '2024-01-17',  99.99),
(4, '2024-01-18', 250.00),
(5, '2024-01-19', 300.20),
(1, '2024-01-20', 175.00),
(2, '2024-01-21', 125.50),
(3, '2024-01-22',  85.75),
(4, '2024-01-23', 210.40),
(5, '2024-01-24', 199.99);

insert into order_items(order_id,product_id,quaantity,price)
values
(1, 3, 2, 99.98),
(2, 1, 1, 599.99),
(3, 5, 3, 269.97),
(4, 7, 2, 91.00),
(5, 2, 1, 399.50),
(6, 4, 2, 159.98),
(7, 6, 1, 129.00),
(8, 8, 1, 199.99),
(9, 9, 1, 799.99),
(10, 10, 3, 179.97);

-- top 5 total customers by total spending
select c.customer_name, sum(o.total_amount) as total_spending
from customer as c
join orders as o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name
order by total_spending desc
LIMIT 5;

-- average spending per customer 
select c.customer_name, avg(o.total_amount) as avg_spendings
FROM customer c
JOIN orders o 
on c.customer_id=o.customer_id
group by customer_name;
-- OR
select avg(total_amount) as avg_spendig
FROM orders;

-- customers who have not placed any orders
select c.customer_name
FROM customer c
JOIN orders o ON c.customer_id=o.customer_id
where o.order_id IS NULL;

-- top 3 best selling products 
select p.product_name, sum(oi.quaantity) as selling_products
FROM products as p
JOIN order_items as oi
ON p.product_id = oi.product_id
group by product_name
order by selling_products DESC
LIMIT 5;

-- least selling products 
select p.product_name, sum(oi.quaantity) as least_selling
FROM products as p
JOIN order_items as oi
on p.product_id = oi.product_id
Group by p.product_name
order by least_selling ASC
LIMIT 5;

-- least selling products
select p.product_name
FROM products as p
Left join order_items as oi
on p.product_id = oi.product_id
where oi.product_id IS NULL;

-- MOnthly sales growth

select MONTH(order_date) as month,
	   YEAR(order_date) as year,
       sum(total_amount) as revenue
FROM orders
Group by year,month
order by year,month;


-- most profitable month

select MONTH(order_date) as month,
       sum(total_amonunt) as revenue
FROM orders
Group by month
order by revenue DESC
LIMIT 1;


-- total revenue by product-category

select p.product_name,p.category, sum(oi.quaantity * oi.price) as revenue
FROM product as p
join order_items as oi
ON p.product_id = oi.product_id
GROUP by p.category
Order by revenue DESC;

-- highest revenue generating category

select p.product_name,p.category  , sum(oi.quaantity * oi.price) as revenue
FROM product as p
JOIN order_items as oi
ON p.product_id = oi.product_id
Group by p.category
order by revenue DESC
LIMIT 1;
-- orders placed in last 7 days

select count(order_id) as recent_order
FROM orders
WHERE order_date >= curdate()-interval 7 DAY;

-- avergae order values

select avg(total_amount) as average_order_value
FROM orders;

-- customers who bought same product more than once

select c.customer_name,P.product_name,count(*) as purchase_count
FROM customer as c
JOIN orders as o On c.customer_id = o.order_id
JOIN products AS p On p.product_id = o.order_id
JOIN order_items as oi ON o.order_id = oi.order_id
GROUP BY c.customer_name,p.product_name;

-- high spending customers sepnding>5000

select c.customer_name, sum(o.total_amount) as total_spending
FROM customer as c
JOIN orders as o
ON c.customer_id = o.customer_id
group by c.customer_id
having total_spending >500.00;

-- out of stock products
select product_name
FROM products
WHERE product_id NOT IN (select DISTINCT product_id from order_items);

-- total orders from each city 
select c.city,c.customer_id, count(o.order_id) as total_orders
FROM customer as c
join orders as o ON c.customer_id = o.customer_id
GROUP BY city,c.customer_id;

-- average revenue per product category
select p.category, avg(oi.quaantity*oi.price) as avg_revenue
FROM products as p
JOIN order_items as oi
ON p.product_id = oi.product_id
group by p.category;

-- total revenue per year

select c.customer_name , YEAR(o.order_date) as year, sum(o.total_amount) as total_revenue
FROM customer as c
JOIN orders as o ON c.customer_id = o.customer_id
GROUP BY c.customer_name,year;
