-- =========================================
-- CREATE DATABASE
-- =========================================

CREATE DATABASE companydb;

USE companydb;

-- =========================================
-- DEPARTMENTS TABLE
-- =========================================

CREATE TABLE departments (
department_id INT PRIMARY KEY AUTO_INCREMENT,
department_name VARCHAR(100)
);

INSERT INTO departments (department_name) VALUES
('HR'),
('IT'),
('Finance'),
('Sales'),
('Marketing');

-- =========================================
-- EMPLOYEES TABLE
-- =========================================

CREATE TABLE employees (
employee_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
salary DECIMAL(10,2),
hire_date DATE,
department_id INT,
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
);

INSERT INTO employees
(first_name,last_name,email,salary,hire_date,department_id)
VALUES
('John','Smith','[john@gmail.com](mailto:john@gmail.com)',60000,'2023-01-10',2),
('Alice','Brown','[alice@gmail.com](mailto:alice@gmail.com)',55000,'2022-06-15',1),
('David','Wilson','[david@gmail.com](mailto:david@gmail.com)',75000,'2021-03-20',3),
('Emma','Taylor','[emma@gmail.com](mailto:emma@gmail.com)',50000,'2024-02-01',4),
('Chris','Lee','[chris@gmail.com](mailto:chris@gmail.com)',67000,'2020-09-17',2);

-- =========================================
-- CUSTOMERS TABLE
-- =========================================

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(100),
email VARCHAR(100),
city VARCHAR(100),
country VARCHAR(100)
);

INSERT INTO customers
(customer_name,email,city,country)
VALUES
('Raj Sharma','[raj@gmail.com](mailto:raj@gmail.com)','Delhi','India'),
('Sarah Johnson','[sarah@gmail.com](mailto:sarah@gmail.com)','New York','USA'),
('Mohit Verma','[mohit@gmail.com](mailto:mohit@gmail.com)','Mumbai','India'),
('Lisa White','[lisa@gmail.com](mailto:lisa@gmail.com)','London','UK'),
('Ahmed Ali','[ahmed@gmail.com](mailto:ahmed@gmail.com)','Dubai','UAE');

-- =========================================
-- PRODUCTS TABLE
-- =========================================

CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100),
category VARCHAR(100),
price DECIMAL(10,2),
stock_quantity INT
);

INSERT INTO products
(product_name,category,price,stock_quantity)
VALUES
('Laptop','Electronics',75000,10),
('Phone','Electronics',30000,20),
('Keyboard','Accessories',1500,50),
('Mouse','Accessories',800,100),
('Monitor','Electronics',12000,15);

-- =========================================
-- ORDERS TABLE
-- =========================================

CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2),
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

INSERT INTO orders
(customer_id,order_date,total_amount)
VALUES
(1,'2025-01-10',75800),
(2,'2025-01-12',30000),
(3,'2025-01-15',13500),
(1,'2025-02-01',12000),
(4,'2025-02-03',800);

-- =========================================
-- ORDER ITEMS TABLE
-- =========================================

CREATE TABLE order_items (
order_item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_id INT,
quantity INT,
subtotal DECIMAL(10,2),
FOREIGN KEY (order_id)
REFERENCES orders(order_id),
FOREIGN KEY (product_id)
REFERENCES products(product_id)
);

INSERT INTO order_items
(order_id,product_id,quantity,subtotal)
VALUES
(1,1,1,75000),
(1,4,1,800),
(2,2,1,30000),
(3,5,1,12000),
(3,3,1,1500),
(4,5,1,12000),
(5,4,1,800);

-- =========================================
-- PAYMENTS TABLE
-- =========================================

CREATE TABLE payments (
payment_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
payment_method VARCHAR(50),
payment_date DATE,
amount DECIMAL(10,2),
FOREIGN KEY (order_id)
REFERENCES orders(order_id)
);

INSERT INTO payments
(order_id,payment_method,payment_date,amount)
VALUES
(1,'Credit Card','2025-01-10',75800),
(2,'UPI','2025-01-12',30000),
(3,'Net Banking','2025-01-15',13500),
(4,'Cash','2025-02-01',12000),
(5,'UPI','2025-02-03',800);

-- =========================================
-- SAMPLE QUERIES
-- =========================================

-- INNER JOIN

SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- GROUP BY

SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country;

-- HAVING

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > 50000;

-- SUBQUERY

SELECT product_name, price
FROM products
WHERE price > (
SELECT AVG(price)
FROM products
);

-- WINDOW FUNCTION

SELECT
employee_id,
first_name,
salary,
RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- VIEW

CREATE VIEW customer_orders AS
SELECT
c.customer_name,
o.order_id,
o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- INDEX

CREATE INDEX idx_customer_email
ON customers(email);

-- STORED PROCEDURE

DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
SELECT *
FROM orders
WHERE customer_id = cust_id;
END //

DELIMITER ;

----------MORE Data------

-- =========================================
-- MORE CUSTOMERS
-- =========================================

INSERT INTO customers
(customer_name,email,city,country)
VALUES
('Ravi Kumar','[ravi@gmail.com](mailto:ravi@gmail.com)','Chennai','India'),
('Anita Desai','[anita@gmail.com](mailto:anita@gmail.com)','Bangalore','India'),
('Michael Scott','[michael@gmail.com](mailto:michael@gmail.com)','Scranton','USA'),
('Pam Beesly','[pam@gmail.com](mailto:pam@gmail.com)','Scranton','USA'),
('Jim Halpert','[jim@gmail.com](mailto:jim@gmail.com)','Philadelphia','USA'),
('Dwight Schrute','[dwight@gmail.com](mailto:dwight@gmail.com)','Pennsylvania','USA'),
('Sophia Turner','[sophia@gmail.com](mailto:sophia@gmail.com)','Manchester','UK'),
('Liam Walker','[liam@gmail.com](mailto:liam@gmail.com)','Liverpool','UK'),
('Noah Garcia','[noah@gmail.com](mailto:noah@gmail.com)','Madrid','Spain'),
('Olivia Martin','[olivia@gmail.com](mailto:olivia@gmail.com)','Paris','France');

-- =========================================
-- MORE PRODUCTS
-- =========================================

INSERT INTO products
(product_name,category,price,stock_quantity)
VALUES
('Tablet','Electronics',25000,12),
('Smart Watch','Electronics',8000,25),
('Printer','Electronics',15000,8),
('USB Cable','Accessories',300,150),
('External HDD','Storage',6500,30),
('SSD 1TB','Storage',9500,20),
('Gaming Mouse','Accessories',2500,40),
('Gaming Keyboard','Accessories',4500,35),
('Office Chair','Furniture',12000,18),
('Desk Lamp','Furniture',1800,45);

-- =========================================
-- MORE ORDERS
-- =========================================

INSERT INTO orders
(customer_id,order_date,total_amount)
VALUES
(6,'2025-02-10',25000),
(7,'2025-02-11',8000),
(8,'2025-02-12',9800),
(9,'2025-02-13',15000),
(10,'2025-02-14',300),
(11,'2025-02-15',9500),
(12,'2025-02-16',7000),
(13,'2025-02-17',12000),
(14,'2025-02-18',1800),
(15,'2025-02-19',4500);

-- =========================================
-- MORE ORDER ITEMS
-- =========================================

INSERT INTO order_items
(order_id,product_id,quantity,subtotal)
VALUES
(6,6,1,25000),
(7,7,1,8000),
(8,9,1,9500),
(8,10,1,300),
(9,8,1,15000),
(10,11,1,300),
(11,12,1,9500),
(12,13,2,5000),
(13,14,1,12000),
(14,15,1,1800),
(15,13,1,4500);

-- =========================================
-- MORE PAYMENTS
-- =========================================

INSERT INTO payments
(order_id,payment_method,payment_date,amount)
VALUES
(6,'UPI','2025-02-10',25000),
(7,'Credit Card','2025-02-11',8000),
(8,'Debit Card','2025-02-12',9800),
(9,'Cash','2025-02-13',15000),
(10,'UPI','2025-02-14',300),
(11,'Net Banking','2025-02-15',9500),
(12,'Credit Card','2025-02-16',7000),
(13,'UPI','2025-02-17',12000),
(14,'Cash','2025-02-18',1800),
(15,'Debit Card','2025-02-19',4500);

-- =========================================
-- MORE EMPLOYEES
-- =========================================

INSERT INTO employees
(first_name,last_name,email,salary,hire_date,department_id)
VALUES
('Robert','King','[robert@gmail.com](mailto:robert@gmail.com)',72000,'2021-08-11',2),
('Jennifer','Miller','[jennifer@gmail.com](mailto:jennifer@gmail.com)',68000,'2020-04-21',3),
('Daniel','Clark','[daniel@gmail.com](mailto:daniel@gmail.com)',52000,'2023-07-14',1),
('Nancy','Evans','[nancy@gmail.com](mailto:nancy@gmail.com)',48000,'2024-01-10',4),
('Steven','Hill','[steven@gmail.com](mailto:steven@gmail.com)',82000,'2019-05-30',2),
('Laura','Adams','[laura@gmail.com](mailto:laura@gmail.com)',59000,'2022-09-09',5),
('Kevin','Baker','[kevin@gmail.com](mailto:kevin@gmail.com)',61000,'2023-03-17',3),
('Rachel','Green','[rachel@gmail.com](mailto:rachel@gmail.com)',53000,'2021-11-25',4),
('Monica','Geller','[monica@gmail.com](mailto:monica@gmail.com)',65000,'2020-12-01',1),
('Chandler','Bing','[chandler@gmail.com](mailto:chandler@gmail.com)',78000,'2018-06-06',2);

-- =========================================
-- ADVANCED PRACTICE QUERIES
-- =========================================

-- Top 5 highest paid employees

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- Total sales by country

SELECT
c.country,
SUM(o.total_amount) AS total_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.country;

-- Most sold products

SELECT
p.product_name,
SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- Customers who spent more than average

SELECT customer_name
FROM customers
WHERE customer_id IN (
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) >
(
SELECT AVG(total_amount)
FROM orders
)
);

-- Monthly sales report

SELECT
MONTH(order_date) AS month_no,
SUM(total_amount) AS total_sales
FROM orders
GROUP BY MONTH(order_date);

-- Employees earning above department average

SELECT e.first_name, e.salary
FROM employees e
WHERE salary >
(
SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id
);

-- Running total using window function

SELECT
order_id,
total_amount,
SUM(total_amount) OVER (ORDER BY order_date)
AS running_total
FROM orders;

-- Dense rank employees by salary

SELECT
first_name,
salary,
DENSE_RANK() OVER (ORDER BY salary DESC)
AS salary_rank
FROM employees;

-- Find products never ordered

SELECT product_name
FROM products
WHERE product_id NOT IN (
SELECT DISTINCT product_id
FROM order_items
);

-- Total orders per customer

SELECT
c.customer_name,
COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

