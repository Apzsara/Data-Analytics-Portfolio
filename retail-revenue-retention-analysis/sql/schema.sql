use retail_analytics;

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    customer_id VARCHAR(50) NULL,        
    country VARCHAR(50) NOT NULL
);

select count(*) from customers;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stockcode VARCHAR(50),
    description VARCHAR(255)
);

select count(*) from products;

CREATE TABLE orders (
    invoice VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NULL,         -- nullable
    invoicedate DATE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    total_items INT NOT NULL
);

select count(*) from orders;

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice VARCHAR(50) NOT NULL,
    stockcode VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(12,2) NOT NULL,
    is_cancelled BOOLEAN NOT NULL,
    is_reconstructed BOOLEAN NOT NULL
);

select count(*) from order_items;