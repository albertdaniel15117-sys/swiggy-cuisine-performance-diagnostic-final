-- 03_reporting.sql

-- A) Tier every restaurant by total Delivered revenue
WITH restaurant_revenue AS (
    SELECT
        r.restaurant_id,
        r.name,
        r.cuisine,
        COALESCE(SUM(CASE WHEN o.status = 'Delivered' THEN o.amount_inr END), 0) AS total_revenue
    FROM restaurants AS r
    LEFT JOIN orders AS o
        ON r.restaurant_id = o.restaurant_id
    GROUP BY r.restaurant_id, r.name, r.cuisine
)
SELECT
    restaurant_id,
    name,
    cuisine,
    total_revenue,
    CASE
        WHEN total_revenue >= 50000 THEN 'High'
        WHEN total_revenue >= 20000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM restaurant_revenue
ORDER BY total_revenue DESC;

-- B) Monthly-by-cuisine business report (Delivered only)
SELECT
    r.cuisine AS cuisine,
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(*) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders AS o
INNER JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine, strftime('%Y-%m', o.order_date)
ORDER BY r.cuisine, month;

-- C) Cuisine target variance and 3-way status
WITH cuisine_revenue AS (
    SELECT
        r.cuisine,
        SUM(o.amount_inr) AS total_revenue
    FROM orders AS o
    INNER JOIN restaurants AS r
        ON o.restaurant_id = r.restaurant_id
    WHERE o.status = 'Delivered'
    GROUP BY r.cuisine
)
SELECT
    ct.cuisine,
    ct.target_revenue_inr,
    cr.total_revenue,
    ct.target_revenue_inr - cr.total_revenue AS variance,
    ((cr.total_revenue - ct.target_revenue_inr) * 100.0) / ct.target_revenue_inr AS percentage_variance,
    CASE
        WHEN cr.total_revenue >= ct.target_revenue_inr THEN 'Above Target'
        WHEN (ct.target_revenue_inr - cr.total_revenue) <= (ct.target_revenue_inr * 0.15)
            THEN 'Below Target - Watch'
        ELSE 'Below Target - Critical'
    END AS target_status
FROM cuisine_targets AS ct
INNER JOIN cuisine_revenue AS cr
    ON ct.cuisine = cr.cuisine
ORDER BY cr.total_revenue DESC;
