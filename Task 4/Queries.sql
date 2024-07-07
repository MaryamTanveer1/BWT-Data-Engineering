-- Fetch all customer names sorted alphabetically:
SELECT customer_name
FROM ecomm.customers
ORDER BY customer_name;

-- Fetch all product names and their prices, sorted by price from low to high:
SELECT name, price
FROM ecomm.products
ORDER BY price;

--Fetch supplier names starting with 'A' sorted alphabetically:
SELECT name
FROM ecomm.suppliers
WHERE name LIKE 'A%'
ORDER BY name;

--Fetch all items sorted by their status, placing NULL values first:
SELECT item_id, status
FROM ecomm.items
ORDER BY status NULLS FIRST;

-- Fetch all products, sorted by category and then by price in descending order:
SELECT name, category_id, price
FROM ecomm.products
ORDER BY category_id ASC, price DESC;

-- Fetch customer names and phone numbers, sorted by the last four digits of phone numbers in ascending order:
SELECT customer_name, phone_number
FROM ecomm.customers
ORDER BY SUBSTRING(phone_number FROM '\d{4}$') ASC;





