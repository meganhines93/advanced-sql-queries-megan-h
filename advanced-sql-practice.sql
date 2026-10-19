-- Create and select the online_store database
CREATE DATABASE online_store;

USE online_store;

-- Create the customers table
CREATE TABLE customers(
                          customerId INT PRIMARY KEY,
                          firstName VARCHAR(45) NOT NULL,
                          lastName VARCHAR(45) NOT NULL,
                          email VARCHAR(100) NOT NULL
);

-- Create the orders table
CREATE TABLE orders (
                        orderId INT PRIMARY KEY,
                        customerId INT,
                        artSupplyName VARCHAR(100) NOT NULL,
                        totalAmount DECIMAL(10,2) NOT NULL,
                        FOREIGN KEY (customerId) REFERENCES customers(customerId)
);

-- Insert four customers
INSERT INTO customers
VALUES
    (1, "Maya", "Chen", "maya@example.com"),
    (2, "Jordan", "Rivera", "jordan@example.com"),
    (3, "Avery", "Brooks", "avery@example.com"),
    (4, "Sam", "Taylor", "sam@example.com");

-- Insert six orders
INSERT INTO orders
VALUES
    (1, 1, 'Watercolor', 25.99),
    (2, 2, 'Paint Brushes', 15.50),
    (3, 3, 'Sketchbook', 12.99),
    (4, NULL, 'Colored Pencils', 18.75),
    (5, 1, 'Canvas', 30.00),
    (6, NULL, 'Acrylic Paint', 22.50);

-- Display all customers and orders
select * from customers;
select * from orders;

-- Join customers with their matching order details
SELECT c.*,o.orderId,o.artSupplyName,o.totalAmount
FROM customers c
JOIN orders o ON o.customerId = c.customerId;

-- Calculate total spending for each customer ID
SELECT customerId, SUM(totalAmount) AS total_spent
FROM orders
GROUP BY customerId;

-- Calculate spending per customer ID using only orders over $25
SELECT customerId, SUM(totalAmount) AS total_spent
FROM orders
WHERE totalAmount > 25
GROUP BY customerId;

-- Display order IDs, customer names, and amounts for matching records
SELECT orderId, customers.firstName, customers.lastName,  orders.totalAmount
FROM orders
INNER JOIN customers ON orders.customerId = customers.customerId;

-- Display all orders, including those without a matching customer
SELECT orders.orderId, customers.firstName, customers.lastName, orders.totalAmount
FROM orders
LEFT JOIN customers ON orders.customerId = customers.customerId;

-- Find orders with amounts at or above the average order amount
SELECT orderId, totalAmount
FROM orders
WHERE totalAmount >= (SELECT AVG(totalAmount) FROM orders);

-- Find orders placed by customers whose last name is Brooks
SELECT orderId,totalAmount, customerId
FROM orders
WHERE customerId IN (SELECT customerId FROM customers WHERE lastName = 'Brooks');

-- Count orders for each customer ID
SELECT customerId, COUNT(*) AS order_count
FROM orders
GROUP BY customerId;

-- Show customer ID groups with total spending over $40
SELECT customerId, SUM(totalAmount) AS total_spent
FROM orders
GROUP BY customerId
HAVING SUM(totalAmount) > 40;

-- Display all customers, including those without orders
SELECT c.customerId, c.firstName, c.lastName,
       o.orderId, o.totalAmount
FROM customers c
LEFT JOIN orders o ON c.customerId = o.customerId;