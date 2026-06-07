CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100),
city VARCHAR(50),
signup_date DATE
);

CREATE TABLE products(
product_id INT PRIMARY KEY,
name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2)
);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
order_date DATE,
status VARCHAR(20)
);

CREATE TABLE order_items(
item_id INT PRIMARY KEY,
order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
quantity INT,
unit_price DECIMAL(10,2)
);



