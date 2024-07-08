--Percentage Contribution of Each Item's Amount to Its Order's Total Amount
SELECT item_id, order_id, amount,total_amount,
    (amount / total_amount) * 100 AS percentage_contribution
FROM (
    SELECT item_id, order_id, amount,
        SUM(amount) OVER (PARTITION BY order_id) AS total_amount
    FROM ecomm.items
) subquery;

-- Rank Orders by Their Total Amount Within Each Customer
SELECT o.order_id, o.customer_id, o.total_amount, ranking.rank_within_customer
FROM ecomm.orders o
JOIN (SELECT customer_id, order_id,RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS rank_within_customer
FROM (SELECT o.order_id, o.customer_id, SUM(i.amount) AS total_amount FROM ecomm.orders o
        JOIN ecomm.items i ON o.order_id = i.order_id
        GROUP BY o.order_id, o.customer_id
    ) subquery
) ranking ON o.order_id = ranking.order_id;

-- Average Price of Products Supplied by Each Supplier
SELECT
    s.supplier_id,
    s.name AS supplier_name,
    AVG(p.price) AS average_price
FROM ecomm.suppliers s
JOIN ecomm.products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.name;

-- Count the Number of Products in Each Category
SELECT 
    c.category_id,
    c.name AS category_name,
    COUNT(p.product_id) AS product_count
FROM ecomm.categories c
LEFT JOIN ecomm.products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name;


-- Total Amount Spent by Each Customer
SELECT 
    c.customer_id,
    c.customer_name AS customer_name,
    c.phone_number AS phone_number,
    COALESCE(SUM(o.total_amount), 0) AS total_amount_spent
FROM ecomm.customers c
LEFT JOIN (
    SELECT 
        o.customer_id,
        SUM(i.amount) AS total_amount
    FROM ecomm.orders o
    JOIN ecomm.items i ON o.order_id = i.order_id
    GROUP BY o.customer_id
) o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.phone_number;






