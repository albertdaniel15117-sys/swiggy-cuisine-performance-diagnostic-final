-- 02_aggregation_joins.sql

-- A) INNER JOIN + GROUP BY + HAVING for Delivered orders
SELECT
    r.cuisine,
    COUNT(*) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders AS o
INNER JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine
HAVING total_revenue > 40000
ORDER BY total_revenue DESC;

-- B) LEFT JOIN preserves restaurants with zero matching orders
SELECT
    r.restaurant_id,
    r.name AS restaurant,
    r.cuisine,
    COUNT(o.order_id) AS total_orders
FROM restaurants AS r
LEFT JOIN orders AS o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name, r.cuisine
ORDER BY total_orders ASC, r.name ASC;
