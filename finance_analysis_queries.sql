/* =========================================================
   E-commerce Sales & Profitability Analysis — SQL Queries
   Table: ecommerce_sales
   Columns: order_id, order_date, customer_id, product_category,
            region, quantity, unit_price, discount, payment_method,
            delivery_days, customer_rating, revenue, assumed_margin_pct,
            unit_cost, total_cost, profit, profit_margin_pct,
            year, month, quarter, month_name
   ========================================================= */

-- 1. Monthly Revenue & Profit Trend
SELECT
    year,
    month,
    SUM(revenue)  AS total_revenue,
    SUM(profit)   AS total_profit,
    ROUND(SUM(profit) / SUM(revenue) * 100, 2) AS profit_margin_pct
FROM ecommerce_sales
GROUP BY year, month
ORDER BY year, month;


-- 2. Category-wise Revenue & Profit (replaces "Department-wise Expenses")
SELECT
    product_category,
    SUM(revenue)  AS total_revenue,
    SUM(total_cost) AS total_cost,
    SUM(profit)   AS total_profit,
    ROUND(SUM(profit) / SUM(revenue) * 100, 2) AS profit_margin_pct
FROM ecommerce_sales
GROUP BY product_category
ORDER BY total_revenue DESC;


-- 3. Region-wise Profit
SELECT
    region,
    SUM(revenue) AS total_revenue,
    SUM(profit)  AS total_profit,
    COUNT(order_id) AS total_orders
FROM ecommerce_sales
GROUP BY region
ORDER BY total_profit DESC;


-- 4. Payment Method Mix & Average Order Value
SELECT
    payment_method,
    COUNT(order_id) AS total_orders,
    SUM(revenue) AS total_revenue,
    ROUND(AVG(revenue), 2) AS avg_order_value
FROM ecommerce_sales
GROUP BY payment_method
ORDER BY total_revenue DESC;


-- 5. Discount Impact on Revenue (bucketed)
SELECT
    CASE
        WHEN discount < 0.10 THEN '0-10%'
        WHEN discount < 0.20 THEN '10-20%'
        WHEN discount < 0.30 THEN '20-30%'
        ELSE '30%+'
    END AS discount_band,
    COUNT(order_id) AS total_orders,
    SUM(revenue) AS total_revenue,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM ecommerce_sales
GROUP BY discount_band
ORDER BY discount_band;


-- 6. Quarterly Performance by Region
SELECT
    year,
    quarter,
    region,
    SUM(revenue) AS total_revenue,
    SUM(profit)  AS total_profit
FROM ecommerce_sales
GROUP BY year, quarter, region
ORDER BY year, quarter, total_revenue DESC;


-- 7. Delivery Speed vs Customer Rating
SELECT
    delivery_days,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    COUNT(order_id) AS total_orders
FROM ecommerce_sales
GROUP BY delivery_days
ORDER BY delivery_days;


-- 8. Top 10 Highest-Revenue Single Orders
SELECT order_id, order_date, product_category, region, revenue, profit
FROM ecommerce_sales
ORDER BY revenue DESC
LIMIT 10;


-- 9. Customers Ranked by Total Spend (Top 10)
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(revenue) AS total_spend
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;
