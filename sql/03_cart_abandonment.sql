-- =========================================================
-- ZOMATO PRODUCT ANALYSIS PROJECT
-- FILE: 02_cart_abandonment.sql
-- AUTHOR: Mehak Mehta
-- PURPOSE:
-- Identify where users drop after showing purchase intent
-- and understand the behavioral drivers behind cart abandonment.
-- =========================================================


-- =========================================================
-- Q8. OVERALL CART ABANDONMENT RATE
-- Business Question:
-- What percentage of users added items to cart but did not complete the order?
-- =========================================================

SELECT
    COUNT(*) AS total_users,
    SUM(CASE WHEN cart_abandonment = 'Yes' THEN 1 ELSE 0 END) AS abandoned_users,
    ROUND(
        SUM(CASE WHEN cart_abandonment = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS abandonment_rate_percent
FROM survey_data;

-- Insight:
-- This is the core metric of the project. A high abandonment rate confirms
-- that users are reaching a high-intent stage but still not completing orders.

-- Product Interpretation:
-- The issue is not lack of demand. Users are interested enough to add items
-- to cart, but something in the checkout or value perception stage stops them.

-- Dashboard Usage:
-- Used as the main KPI card: Cart Drop-off Rate.



-- =========================================================
-- Q9. CART ABANDONMENT BY DECISION STYLE
-- Business Question:
-- Which decision style has the highest abandonment rate?
-- =========================================================

SELECT
    decision_style,
    COUNT(*) AS total_users,
    SUM(CASE WHEN cart_abandonment = 'Yes' THEN 1 ELSE 0 END) AS abandoned_users,
    ROUND(
        SUM(CASE WHEN cart_abandonment = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS abandonment_rate_percent
FROM survey_data
GROUP BY decision_style
ORDER BY abandonment_rate_percent DESC;

-- Insight:
-- This shows whether users who compare options are more likely to abandon
-- compared to users who decide quickly.

-- Product Interpretation:
-- If comparison-driven users show higher abandonment, the product issue is
-- not only price. It also reflects decision fatigue and uncertainty before checkout.

-- Dashboard Usage:
-- Used as a clustered bar chart: Cart Drop-off by Decision Behavior.



-- =========================================================
-- Q10. CART ABANDONMENT BY INTENT GROUP
-- Business Question:
-- Are high-intent users also dropping after cart?
-- =========================================================

SELECT
    intent_group,
    COUNT(*) AS total_users,
    SUM(CASE WHEN cart_abandonment = 'Yes' THEN 1 ELSE 0 END) AS abandoned_users,
    ROUND(
        SUM(CASE WHEN cart_abandonment = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS abandonment_rate_percent
FROM survey_data
GROUP BY intent_group
ORDER BY abandonment_rate_percent DESC;

-- Insight:
-- This identifies whether users who came with ordering intent still drop
-- before completing the transaction.

-- Product Interpretation:
-- If high-intent users abandon, checkout friction becomes a serious product
-- and revenue problem because users already intended to place an order.

-- Dashboard Usage:
-- Used to support the insight: intent exists, but conversion breaks later.
