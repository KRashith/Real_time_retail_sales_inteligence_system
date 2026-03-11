/* TRANSFORM (SQL Cleaning & Processing) */

/*Fix Data Types*/
ALTER TABLE orders MODIFY total_amount DECIMAL(10,2);
ALTER TABLE order_items MODIFY item_price DECIMAL(10,2);

/*Remove Duplicate Emails*/
DELETE c1 FROM customers c1
JOIN customers c2
ON c1.email = c2.email
AND c1.customer_id > c2.customer_id;

/*Add Year, Month Columns for Power BI*/
ALTER TABLE orders
ADD order_year INT,
ADD order_month INT;

UPDATE orders
SET order_year = YEAR(order_date),
    order_month = MONTH(order_date);
    
  /*Create a Clean Date Table*/  
  CREATE TABLE calendar AS
SELECT 
    DATE(order_date) AS calendar_date,
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    DAY(order_date) AS day,
    QUARTER(order_date) AS quarter
FROM orders
GROUP BY calendar_date;

/*Create View for Sales Summary (for Power BI)*/
CREATE VIEW sales_summary AS
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    c.city,
    c.state,
    o.payment_method
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;