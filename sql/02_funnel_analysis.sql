-- =========================================================
-- Q6. DECISION STYLE DISTRIBUTION
-- Business Question:
-- Do users decide quickly or compare multiple options?
-- =========================================================

SELECT
    decision_style,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent
FROM survey_data
GROUP BY decision_style
ORDER BY users DESC;

-- Insight:
-- This shows how users behave before placing an order: quick decision,
-- comparison, or browsing.

-- Product Interpretation:
-- If comparison behavior dominates, the issue is not only pricing.
-- It also indicates decision friction, where users need clearer value signals
-- before moving forward.

-- Dashboard Usage:
-- Used as one of the key visuals on the User Behavior & Intent page.



-- =========================================================
-- Q7. DECISION FACTORS SELECTED BY USERS
-- Business Question:
-- What matters most while choosing a restaurant?
-- =========================================================

SELECT 'Price' AS decision_factor, SUM(factor_price) AS users FROM survey_data
UNION ALL
SELECT 'Ratings & Reviews', SUM(factor_rating_reviews) FROM survey_data
UNION ALL
SELECT 'Delivery Time', SUM(factor_delivery_time) FROM survey_data
UNION ALL
SELECT 'Discounts/Offers', SUM(factor_discounts_offers) FROM survey_data
UNION ALL
SELECT 'Cuisine Preference', SUM(factor_cuisine_preference) FROM survey_data
ORDER BY users DESC;

-- Insight:
-- This query uses binary factor flags to handle multi-select responses cleanly.

-- Product Interpretation:
-- Users evaluate restaurants based on value, trust, speed, and food preference.
-- This supports the need for better pricing clarity, stronger trust signals,
-- and faster decision support.

-- Dashboard Usage:
-- Used as a horizontal bar chart: Key Decision Drivers for Restaurant Selection.
