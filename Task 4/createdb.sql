CREATE TABLE ecomm.categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    status VARCHAR(50),
    description TEXT
);
CREATE TABLE ecomm.items (
    item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    amount DECIMAL(10, 2),
    status VARCHAR(50),
    item_timestamp TIMESTAMP
);
CREATE TABLE ecomm.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    status VARCHAR(50),
    order_timestamp TIMESTAMP,
    total_amount DECIMAL(10, 2)
);
CREATE TABLE ecomm.products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    supplier_id INT,
    category_id INT,
    price DECIMAL(10, 2),
    stock_available INT,
    status VARCHAR(50),
    product_create_timestamp TIMESTAMP
);
CREATE TABLE ecomm.suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(50),
    location VARCHAR(255),
    status VARCHAR(50),
    category_id INT
);
CREATE TABLE ecomm.cities (
    city_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    province VARCHAR(255),
    country VARCHAR(255),
    status VARCHAR(50)
);




