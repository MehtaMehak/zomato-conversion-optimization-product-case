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


-- =========================================================
-- Q11. TOP CART ABANDONMENT REASONS
-- Business Question:
-- What are the leading reasons users abandon the cart?
-- =========================================================

SELECT 'High Delivery Charges' AS reason, SUM(reason_high_delivery_charges) AS users FROM survey_data
UNION ALL
SELECT 'Long Delivery Time', SUM(reason_long_delivery_time) FROM survey_data
UNION ALL
SELECT 'Changed Mind', SUM(reason_changed_mind) FROM survey_data
UNION ALL
SELECT 'Found Better Option', SUM(reason_found_better_option) FROM survey_data
ORDER BY users DESC;

-- Insight:
-- This approach uses binary flags instead of raw text, allowing accurate counting
-- even when users select multiple abandonment reasons.

-- Product Interpretation:
-- Cart abandonment is not random — it is driven by clear factors such as
-- price shock (delivery charges), delays, and better alternatives.

-- Dashboard Usage:
-- Used as the main root-cause chart on the Cart Abandonment page.



-- =========================================================
-- Q12. HIGH DELIVERY CHARGE IMPACT
-- Business Question:
-- How many abandoned users mentioned high delivery charges?
-- =========================================================

SELECT
    COUNT(*) AS total_abandoned_users,
    SUM(reason_high_delivery_charges) AS users_mentioning_high_delivery_charges,
    ROUND(SUM(reason_high_delivery_charges) * 100.0 / COUNT(*), 2) AS percent_of_abandoned_users
FROM survey_data
WHERE cart_abandonment = 'Yes';

-- Insight:
-- This directly quantifies how strong the delivery charge factor is among
-- users who dropped off.

-- Product Interpretation:
-- A high percentage confirms that pricing transparency and perceived value
-- at checkout are critical to conversion.

-- Dashboard Usage:
-- Used as an insight card: "High Delivery Charges = Top Drop-off Driver"



-- =========================================================
-- Q13. ABANDONMENT REASON BY DECISION STYLE
-- Business Question:
-- Do compare users abandon for different reasons than quick decision users?
-- =========================================================

SELECT
    decision_style,
    SUM(reason_high_delivery_charges) AS high_delivery_charges,
    SUM(reason_long_delivery_time) AS long_delivery_time,
    SUM(reason_changed_mind) AS changed_mind,
    SUM(reason_found_better_option) AS found_better_option
FROM survey_data
WHERE cart_abandonment = 'Yes'
GROUP BY decision_style
ORDER BY decision_style;

-- Insight:
-- This connects decision behavior with specific abandonment triggers.

-- Product Interpretation:
-- If compare users abandon more due to price or better options,
-- it highlights decision friction + value comparison as key problems.

-- Dashboard Usage:
-- Used as a matrix/stacked chart for deeper behavioral analysis.

-- Product Interpretation:
-- If high-intent users abandon, checkout friction becomes a serious product
-- and revenue problem because users already intended to place an order.

-- Dashboard Usage:
-- Used to support the insight: intent exists, but conversion breaks later.
