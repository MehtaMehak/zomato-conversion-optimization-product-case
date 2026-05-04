-- =========================================================
-- ZOMATO PRODUCT ANALYSIS PROJECT
-- FILE: 03_experience_competition.sql
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




-- =========================================================
-- Q17. COMPETITOR USAGE RATE
-- Business Question:
-- How many users also use competitors such as Swiggy or others?
-- =========================================================

SELECT
    COUNT(*) AS total_users,
    SUM(competitor_usage_flag) AS competitor_users,
    ROUND(SUM(competitor_usage_flag) * 100.0 / COUNT(*), 2) AS competitor_usage_percent
FROM survey_data;

-- Insight:
-- This measures how many users are not exclusive to Zomato and actively use competitors.

-- Product Interpretation:
-- High competitor usage indicates weak platform loyalty and high switching risk.
-- Users are likely comparing value, pricing, and delivery experience across platforms.

-- Dashboard Usage:
-- Used as a KPI card: Competitor Usage %



-- =========================================================
-- Q18. SATISFACTION VS COMPETITOR USAGE
-- Business Question:
-- Are less satisfied users more likely to use competitors?
-- =========================================================

SELECT
    satisfaction,
    COUNT(*) AS total_users,
    SUM(competitor_usage_flag) AS competitor_users,
    ROUND(SUM(competitor_usage_flag) * 100.0 / COUNT(*), 2) AS competitor_usage_percent
FROM survey_data
GROUP BY satisfaction
ORDER BY competitor_usage_percent DESC;

-- Insight:
-- This shows whether dissatisfaction is linked with higher competitor usage.

-- Product Interpretation:
-- If lower satisfaction groups show higher competitor usage,
-- it confirms that poor experience directly drives switching behavior.

-- Dashboard Usage:
-- Used as a cross-analysis chart linking satisfaction and competitor risk.



-- =========================================================
-- Q19. COMPETITOR PRIMARY SPLIT
-- Business Question:
-- Which competitor platform is most commonly used?
-- =========================================================

SELECT
    competitor_primary,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent
FROM survey_data
GROUP BY competitor_primary
ORDER BY users DESC;

-- Insight:
-- This identifies the most dominant competitor in the user's consideration set.

-- Product Interpretation:
-- Helps benchmark Zomato against key competitors (e.g., Swiggy)
-- and understand where users may be getting better value or experience.

-- Dashboard Usage:
-- Used as a competitor distribution chart.



-- =========================================================
-- Q20. IMPROVEMENT CATEGORY ANALYSIS
-- Business Question:
-- What do users most want Zomato to improve?
-- =========================================================

SELECT
    improvement_category,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent
FROM survey_data
GROUP BY improvement_category
ORDER BY users DESC;

-- Insight:
-- Converts open-ended feedback into structured product improvement themes.

-- Product Interpretation:
-- This directly reflects the voice of the customer and highlights
-- priority areas such as pricing, delivery, or app experience.

-- Dashboard Usage:
-- Used as a “Voice of Customer” chart on the experience page.
