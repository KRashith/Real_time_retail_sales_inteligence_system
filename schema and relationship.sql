CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    price INT,
    cost_price INT
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(50),
    payment_method VARCHAR(50),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price INT,
    discount INT,
    profit INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE inventory (
    inv_id INT PRIMARY KEY,
    product_id INT,
    stock_in INT,
    stock_out INT,
    updated_at DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE delivery (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    shipped_date DATE,
    delivered_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);