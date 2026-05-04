-- =========================================================
-- ZOMATO PRODUCT ANALYSIS PROJECT
-- FILE: 01_funnel_analysis.sql
-- AUTHOR: Mehak Mehta
-- PURPOSE:
-- Understand who the users are, how often they use Zomato,
-- and whether they enter the app with strong purchase intent.
-- =========================================================


-- =========================================================
-- Q1. TOTAL SURVEY RESPONDENTS
-- Business Question:
-- How many valid users are included in the primary research sample?
-- =========================================================

SELECT 
    COUNT(*) AS total_users
FROM survey_data;

-- Insight:
-- This confirms the base sample size used for the user behavior analysis.

-- Product Interpretation:
-- Before analyzing funnel behavior, it is important to understand the size
-- of the primary research sample supporting the analysis.

-- Dashboard Usage:
-- Used as the first KPI card: Total Survey Respondents.



-- =========================================================
-- Q2. USER PROFILE BY AGE GROUP
-- Business Question:
-- Which age group dominates the survey sample?
-- =========================================================

SELECT
    age_group,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent
FROM survey_data
GROUP BY age_group
ORDER BY users DESC;

-- Insight:
-- This helps identify the primary user segment in the survey sample.

-- Product Interpretation:
-- If a specific age group dominates, product recommendations should consider
-- the behavior and expectations of that user segment.

-- Dashboard Usage:
-- Used as a donut chart/bar chart under User Profile.



-- =========================================================
-- Q3. USER PROFILE BY OCCUPATION
-- Business Question:
-- Which occupation group is most represented?
-- =========================================================

SELECT
    occupation,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent
FROM survey_data
GROUP BY occupation
ORDER BY users DESC;

-- Insight:
-- This shows whether the sample is driven more by working professionals,
-- students, or other groups.

-- Product Interpretation:
-- Occupation helps explain ordering motivations. For example, working users
-- may value speed and convenience, while students may be more price-sensitive.

-- Dashboard Usage:
-- Used in dashboard to explain who the project is mainly analyzing.



-- =========================================================
-- Q4. USAGE FREQUENCY DISTRIBUTION
-- Business Question:
-- How often do users use Zomato?
-- =========================================================

SELECT
    usage_frequency,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent
FROM survey_data
GROUP BY usage_frequency
ORDER BY users DESC;

-- Insight:
-- This explains whether Zomato usage is frequent, occasional, or rare
-- within the sample.

-- Product Interpretation:
-- Usage frequency helps separate habit-driven users from occasional users.
-- Occasional users may need stronger nudges, offers, or trust signals to convert.

-- Dashboard Usage:
-- Used as a frequency bar chart and slicer for behavior analysis.



-- =========================================================
-- Q5. INTENT GROUP DISTRIBUTION
-- Business Question:
-- Do users open Zomato with high purchase intent or low browsing intent?
-- =========================================================

SELECT
    intent_group,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_data), 2) AS user_percent
FROM survey_data
GROUP BY intent_group
ORDER BY users DESC;

-- Insight:
-- If many users are high-intent, cart drop-off becomes more serious because
-- users already came with the purpose of ordering.

-- Product Interpretation:
-- High intent but low conversion indicates that the problem is not demand.
-- The issue lies in friction during decision-making, pricing, or checkout.

-- Dashboard Usage:
-- Used as a KPI/visual to show high-intent traffic.
