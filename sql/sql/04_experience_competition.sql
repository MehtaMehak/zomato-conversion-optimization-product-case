-- =========================================================
-- ZOMATO PRODUCT ANALYSIS PROJECT
-- FILE: 04_experience_competition.sql
-- AUTHOR: Mehak Mehta
-- PURPOSE:
-- Analyze delivery experience, satisfaction levels,
-- and their impact on user behavior and switching.
-- =========================================================


-- =========================================================
-- Q14. DELIVERY DELAY DISTRIBUTION
-- Business Question:
-- How often do users experience delivery delays?
-- =========================================================

SELECT
    delivery_delay,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent,
    ROUND(AVG(delivery_delay_score), 2) AS avg_delay_score
FROM survey_data
GROUP BY delivery_delay
ORDER BY avg_delay_score DESC;

-- Insight:
-- This shows how frequently delivery delays occur across users.

-- Product Interpretation:
-- Delivery delay is a key operational friction that directly impacts
-- satisfaction and repeat usage.

-- Dashboard Usage:
-- Used as a bar chart on the Experience & Satisfaction page.



-- =========================================================
-- Q15. SATISFACTION DISTRIBUTION
-- Business Question:
-- How satisfied are users with the delivery experience?
-- =========================================================

SELECT
    satisfaction,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent,
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction_score
FROM survey_data
GROUP BY satisfaction
ORDER BY avg_satisfaction_score DESC;

-- Insight:
-- This measures whether users feel satisfied, neutral, or dissatisfied.

-- Product Interpretation:
-- Satisfaction reflects overall experience quality and directly impacts
-- retention and loyalty.

-- Dashboard Usage:
-- Used as a satisfaction chart + KPI.



-- =========================================================
-- Q16. DELIVERY DELAY VS SATISFACTION
-- Business Question:
-- Does delivery delay appear to reduce satisfaction?
-- =========================================================

SELECT
    delivery_delay,
    COUNT(*) AS users,
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction_score
FROM survey_data
GROUP BY delivery_delay
ORDER BY avg_satisfaction_score ASC;

-- Insight:
-- Lower satisfaction for delayed deliveries confirms operational impact.

-- Product Interpretation:
-- Delays are not just logistics issues — they directly reduce user trust
-- and increase the likelihood of switching to competitors.

-- Dashboard Usage:
-- Used to connect operational performance with user experience.
