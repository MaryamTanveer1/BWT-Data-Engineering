-- Retrieve All Orders Placed by Customers
SELECT c.phone_number AS customer_phone, o.order_id, o.order_timestamp, i.product_id, p.name AS product_name, i.amount
FROM ecomm.customers c
JOIN ecomm.orders o ON c.customer_id = o.customer_id
JOIN ecomm.items i ON o.order_id = i.order_id
JOIN ecomm.products p ON i.product_id = p.product_id;

-- Fetch All Products Along with Their Suppliers' Details and the Corresponding Category Name
SELECT p.product_id, p.name AS product_name, p.price, s.name AS supplier_name, s.phone AS supplier_phone, c.name AS category_name
FROM ecomm.products p
JOIN ecomm.suppliers s ON p.supplier_id = s.supplier_id
JOIN ecomm.categories c ON p.category_id = c.category_id;

-- Retrieve Details of All Orders Including the Product Name and Amount Ordered for Each Item
SELECT  o.order_id, o.order_timestamp, i.product_id, p.name AS product_name, i.amount
FROM ecomm.orders o
JOIN ecomm.items i ON o.order_id = i.order_id
JOIN ecomm.products p ON i.product_id = p.product_id;

-- Retrieve All Suppliers Along with the City and Country Where They Are Located and the Products They Supply
SELECT  s.supplier_id, s.name AS supplier_name, s.phone AS supplier_phone, ci.name AS city_name, ci.country AS country_name, p.product_id, p.name AS product_name
FROM ecomm.suppliers s
JOIN ecomm.cities ci ON ci.city_id = ci.city_id
JOIN ecomm.products p ON s.supplier_id = p.supplier_id;

-- Fetch Details of the Most Recent Order Placed by Each Customer, Including the Product Details for Each Item
WITH RecentOrders AS ( SELECT  o.customer_id, o.order_id, o.order_timestamp, ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_timestamp DESC) AS rn
FROM ecomm.orders o
)	
SELECT c.phone_number AS customer_phone, ro.order_id, ro.order_timestamp, i.product_id, p.name AS product_name, i.amount
FROM ecomm.customers c
JOIN RecentOrders ro ON c.customer_id = ro.customer_id AND ro.rn = 1
JOIN ecomm.items i ON ro.order_id = i.order_id
JOIN ecomm.products p ON i.product_id = p.product_id;
