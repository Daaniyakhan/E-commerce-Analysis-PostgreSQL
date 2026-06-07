-- 1. Top Customers by Revenue
-- Who spent the most, on completed orders only?
SELECT
  c.name,
  c.city,
  COUNT(DISTINCT o.order_id)        AS total_orders,
  SUM(oi.quantity * oi.unit_price)  AS total_spent
FROM customers c
JOIN orders o     ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC
LIMIT 5;
--Concepts used: Multi-table JOIN, GROUP BY, SUM, COUNT DISTINCT, WHERE filter



-- 2. Best-Selling Products
-- Which products generate the most revenue?
SELECT
  p.name                             AS product,
  p.category,
  SUM(oi.quantity)                   AS units_sold,
  SUM(oi.quantity * oi.unit_price)   AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o       ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.name, p.category
ORDER BY revenue DESC;
--Concepts used: JOIN across 3 tables, aggregation, filtering on status


-- 3. Monthly Revenue Trend
-- How is revenue growing month over month?
SELECT
  TO_CHAR(o.order_date, 'YYYY-MM') AS month,
  COUNT(DISTINCT o.order_id)        AS orders,
  SUM(oi.quantity * oi.unit_price)  AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month;
--Concepts used: Date formatting, time-series aggregation


-- 4. Revenue Share by Category
-- Which product category drives the most revenue, and what % of the total?
SELECT
  p.category,
  SUM(oi.quantity * oi.unit_price)  AS revenue,
  ROUND(
    100.0 * SUM(oi.quantity * oi.unit_price)
    / SUM(SUM(oi.quantity * oi.unit_price)) OVER ()
  , 1)                                 AS pct_of_total
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o       ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.category
ORDER BY revenue DESC;
--Concepts used: Window functions (OVER()), percentage calculation, ROUND


-- 5. Customer Return Rate
-- Which customers return the most orders?
SELECT
  c.name,
  COUNT(o.order_id) AS total_orders,
  SUM(CASE WHEN o.status = 'returned'
            THEN 1 ELSE 0 END)  AS returns,
  ROUND(
    100.0 * SUM(CASE WHEN o.status = 'returned'
                      THEN 1 ELSE 0 END)
    / COUNT(o.order_id)
  , 1)     AS return_rate_pct
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1
ORDER BY return_rate_pct DESC;
--Concepts used: CASE WHEN, HAVING clause, conditional aggregation 