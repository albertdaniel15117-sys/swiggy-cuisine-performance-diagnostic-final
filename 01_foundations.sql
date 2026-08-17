-- 01_foundations.sql
-- Foundational SELECT / filtering practice

-- 1) SELECT + WHERE: restaurants in a specific city
SELECT restaurant_id, name, cuisine, city
FROM restaurants
WHERE city = 'Mumbai';

-- 2) DISTINCT: every distinct cuisine
SELECT DISTINCT cuisine
FROM restaurants
ORDER BY cuisine;

-- 3) ORDER BY + LIMIT: 5 highest-value orders
SELECT order_id, order_date, amount_inr, status
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;

-- 4) LIKE + %: restaurant name contains a keyword
SELECT restaurant_id, name, cuisine, city
FROM restaurants
WHERE name LIKE '%Spice%';

-- 5) IN: customers in a 2-city list
SELECT customer_id, name, city
FROM customers
WHERE city IN ('Mumbai', 'Bengaluru');

-- 6) BETWEEN: orders in a stated amount range
SELECT order_id, amount_inr, status
FROM orders
WHERE amount_inr BETWEEN 1000 AND 2000
ORDER BY amount_inr;

-- 7) NOT BETWEEN: orders outside that stated amount range
SELECT order_id, amount_inr, status
FROM orders
WHERE amount_inr NOT BETWEEN 1000 AND 2000
ORDER BY amount_inr;

-- 8) IS NULL: orders with no rating (Cancelled / Pending)
SELECT order_id, status, rating
FROM orders
WHERE rating IS NULL
ORDER BY order_id;
