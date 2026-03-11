SELECT COUNT(*) as customer_count FROM customers; -- Total customers --
SELECT COUNT(*) as products_count FROM products;  -- Total products
SELECT COUNT(*) as orders_count FROM orders; -- Total orders
SELECT COUNT(*) as order_items_count FROM order_items;
SELECT COUNT(*) as inventory_count FROM inventory;
SELECT COUNT(*) as delivery_count FROM delivery;

-- List of cities by customer count
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- Daily Sales
SELECT order_date, SUM(total_amount) AS revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- Top 10 Best-Selling Products
SELECT p.product_name, SUM(oi.quantity) AS qty
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY qty DESC
LIMIT 10;

-- Customer Lifetime Value (CLV)
SELECT c.customer_id, c.name,
       SUM(o.total_amount) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY lifetime_value DESC;

-- Order Delay Days
SELECT d.order_id,
       DATEDIFF(d.delivered_date, d.shipped_date) AS delay_days
FROM delivery d
WHERE d.status != 'Lost';

-- Low Stock Alert
SELECT product_id,
       SUM(stock_in - stock_out) AS current_stock
FROM inventory
GROUP BY product_id
HAVING current_stock < 50;

-- Last 24 Hours Orders
SELECT * FROM orders
WHERE order_date >= CURDATE() - INTERVAL 1 DAY;

-- Today’s Sales
SELECT SUM(total_amount)
FROM orders
WHERE order_date = CURDATE();

-- Orders Not Delivered on Time
SELECT order_id,
       shipped_date,
       delivered_date,
       DATEDIFF(delivered_date, shipped_date) AS delay
FROM delivery
WHERE DATEDIFF(delivered_date, shipped_date) > 3;