-- a. SELECT, WHERE, ORDER BY, GROUP BY
SELECT product_id, name, price FROM products WHERE price > 100 ORDER BY price DESC;
SELECT p.name, SUM(oi.quantity) AS total_sold FROM order_items oi JOIN products p ON oi.product_id = p.product_id GROUP BY p.name ORDER BY total_sold DESC;

-- b. INNER, LEFT, RIGHT JOIN
SELECT c.name, o.order_id FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.name, o.order_id FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.name, o.order_id FROM customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- c. Subqueries
SELECT name, price FROM products WHERE price > (SELECT AVG(price) FROM products);
SELECT name FROM customers WHERE customer_id IN (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) > 1);

-- d. Aggregates: SUM, AVG
SELECT SUM(p.price * oi.quantity) AS total_revenue FROM order_items oi JOIN products p ON oi.product_id = p.product_id;
SELECT AVG(price) AS avg_price FROM products;

-- e. Create View
CREATE VIEW order_summary AS
SELECT o.order_id, c.name AS customer_name, p.name AS product_name, oi.quantity, p.price * oi.quantity AS total_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- f. Optimize with Indexes
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_order_id ON order_items(order_id);
CREATE INDEX idx_product_id ON order_items(product_id);
