# 🛒 E-commerce Sales Analysis — SQL Portfolio Project

A beginner-to-intermediate SQL project that models a real-world e-commerce database and answers key business questions through data analysis queries.

---

## 📌 Project Overview

This project simulates an online retail store's backend database. Using raw SQL, I designed the schema, populated it with realistic data, and wrote analytical queries to surface business insights.

**Tools used:** PostgreSQL  
**Skills demonstrated:** Schema design, JOINs, aggregations, window functions, date functions, CASE WHEN logic

---

## 🗂️ Database Schema

The database contains 4 tables modelling a standard e-commerce system:

```
customers
─────────────────────────
customer_id  (PK)
name
email
city
signup_date

products
─────────────────────────
product_id   (PK)
name
category
price

orders
─────────────────────────
order_id     (PK)
customer_id  (FK → customers)
order_date
status       (completed / returned / pending)

order_items
─────────────────────────
item_id      (PK)
order_id     (FK → orders)
product_id   (FK → products)
quantity
unit_price
```

**Why this structure?**  
One order can contain multiple products, and one product can appear in many orders. The `order_items` table handles this many-to-many relationship — a common real-world pattern.

---

## 📊 Analysis Queries

### 1. Top Customers by Revenue
> Who spent the most, on completed orders only?

```sql
SELECT
  c.name,
  c.city,
  COUNT(DISTINCT o.order_id)        AS total_orders,
  SUM(oi.quantity * oi.unit_price)  AS total_spent
FROM customers c
JOIN orders o      ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC
LIMIT 5;
```

**Concepts used:** Multi-table JOIN, GROUP BY, SUM, COUNT DISTINCT, WHERE filter

---

### 2. Best-Selling Products
> Which products generate the most revenue?

```sql
SELECT
  p.name                            AS product,
  p.category,
  SUM(oi.quantity)                  AS units_sold,
  SUM(oi.quantity * oi.unit_price)  AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o       ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.name, p.category
ORDER BY revenue DESC;
```

**Concepts used:** JOIN across 3 tables, aggregation, filtering on status

---

### 3. Monthly Revenue Trend
> How is revenue growing month over month?

```sql
-- SQLite
SELECT
TO_CHAR(o.order_date, 'YYYY-MM') AS month,
  COUNT(DISTINCT o.order_id)        AS orders,
  SUM(oi.quantity * oi.unit_price)  AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month;
```

**Concepts used:** Date formatting, time-series aggregation

---

### 4. Revenue Share by Category
> Which product category drives the most revenue, and what % of the total?

```sql
SELECT
  p.category,
  SUM(oi.quantity * oi.unit_price)  AS revenue,
  ROUND(
    100.0 * SUM(oi.quantity * oi.unit_price)
    / SUM(SUM(oi.quantity * oi.unit_price)) OVER ()
  , 1)                               AS pct_of_total
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o       ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.category
ORDER BY revenue DESC;
```

**Concepts used:** Window functions (`OVER()`), percentage calculation, ROUND

---

### 5. Customer Return Rate
> Which customers return the most orders?

```sql
SELECT
  c.name,
  COUNT(o.order_id)                        AS total_orders,
  SUM(CASE WHEN o.status = 'returned'
           THEN 1 ELSE 0 END)              AS returns,
  ROUND(
    100.0 * SUM(CASE WHEN o.status = 'returned'
                     THEN 1 ELSE 0 END)
    / COUNT(o.order_id)
  , 1)                                     AS return_rate_pct
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1
ORDER BY return_rate_pct DESC;
```

**Concepts used:** CASE WHEN, HAVING clause, conditional aggregation

---

## 💡 Key Learnings

- Designing relational schemas with primary and foreign keys
- Writing multi-table JOINs to combine data across tables
- Filtering with WHERE vs HAVING (before vs after grouping)
- Using window functions for percentages without subqueries
- Applying business logic in SQL.

---

## 🚀 How to Run

1. Install [DB Browser for SQLite](https://sqlitebrowser.org/dl/) (free, no setup needed)
2. Open the app → click **New Database** → name it `ecommerce.db`
3. Open the **Execute SQL** tab
4. Run `schema.sql` first, then `data.sql`, then any query from `queries.sql`

All files are in this repo.

---

## 📁 Files

| File | Description |
|------|-------------|
| `schema.sql` | CREATE TABLE statements |
| `data.sql` | INSERT INTO statements (sample data) |
| `queries.sql` | All 5 analysis queries with comments |
| `README.md` | This file |

---

## 🙋 About

Built as my first SQL portfolio project while learning data analysis.  
Open to feedback and suggestions!
