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
