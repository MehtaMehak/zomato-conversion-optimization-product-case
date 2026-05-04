-- =========================================================
-- ZOMATO PRODUCT ANALYSIS PROJECT
-- FILE: 04_pricing_market_analysis.sql
-- AUTHOR: Mehak Mehta
-- PURPOSE:
-- Analyze restaurant pricing, ratings, votes, cuisine,
-- and market distribution to understand what users see
-- while comparing options on Zomato.
-- =========================================================


-- =========================================================
-- Q21. TOTAL RESTAURANT RECORDS
-- Business Question:
-- How large is the restaurant dataset?
-- =========================================================

SELECT 
    COUNT(*) AS total_restaurant_records
FROM zomato_restaurants;

-- Insight:
-- This gives the scale of the external restaurant dataset used for market context.

-- Product Interpretation:
-- Restaurant-side data helps explain the supply environment users compare within.

-- Dashboard Usage:
-- Used as a documentation metric, not necessarily as a front-page KPI.



-- =========================================================
-- Q22. CREATE PRICE BANDS
-- Business Question:
-- How should restaurants be segmented by affordability?
-- =========================================================

SELECT
    CASE
        WHEN approx_cost_for_two_people < 300 THEN 'Budget'
        WHEN approx_cost_for_two_people BETWEEN 300 AND 700 THEN 'Mid Range'
        ELSE 'Premium'
    END AS price_band,
    COUNT(*) AS restaurant_count
FROM zomato_restaurants
GROUP BY price_band
ORDER BY restaurant_count DESC;

-- Insight:
-- Price bands help identify whether the market is budget-heavy,
-- mid-range-heavy, or premium-heavy.

-- Product Interpretation:
-- This connects restaurant-side pricing with user price sensitivity found in survey data.

-- Dashboard Usage:
-- Used for pricing segmentation and market affordability analysis.



-- =========================================================
-- Q23. PRICE BAND VS RATING AND VOTES
-- Business Question:
-- Do higher-priced restaurants have better ratings and stronger trust signals?
-- =========================================================

SELECT
    CASE
        WHEN approx_cost_for_two_people < 300 THEN 'Budget'
        WHEN approx_cost_for_two_people BETWEEN 300 AND 700 THEN 'Mid Range'
        ELSE 'Premium'
    END AS price_band,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rate), 2) AS avg_rating,
    ROUND(AVG(votes), 0) AS avg_votes
FROM zomato_restaurants
GROUP BY price_band
ORDER BY avg_rating DESC;

-- Insight:
-- This tests whether higher price is associated with better ratings and higher engagement.

-- Product Interpretation:
-- If premium pricing does not strongly improve rating or votes, users may judge value
-- based on quality and trust rather than price alone.

-- Dashboard Usage:
-- Supports the Pricing & Trust Analysis page.



-- =========================================================
-- Q24. RATING BUCKET ANALYSIS
-- Business Question:
-- How many restaurants are high-rated, average-rated, or low-rated?
-- =========================================================

SELECT
    CASE
        WHEN rate >= 4.0 THEN 'High Rated'
        WHEN rate >= 3.0 THEN 'Average Rated'
        ELSE 'Low Rated'
    END AS rating_bucket,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(approx_cost_for_two_people), 2) AS avg_cost_for_two,
    ROUND(AVG(votes), 0) AS avg_votes
FROM zomato_restaurants
GROUP BY rating_bucket
ORDER BY restaurant_count DESC;

-- Insight:
-- This shows the trust landscape available to users.

-- Product Interpretation:
-- Rating buckets help identify whether users have enough reliable high-rated options
-- or whether trust signals are limited.

-- Dashboard Usage:
-- Used to discuss restaurant quality and trust signals.



-- =========================================================
-- Q25. TOP CUISINES BY RESTAURANT COUNT
-- Business Question:
-- Which cuisines dominate restaurant options?
-- =========================================================

SELECT
    cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rate), 2) AS avg_rating,
    ROUND(AVG(approx_cost_for_two_people), 2) AS avg_cost_for_two
FROM zomato_restaurants
GROUP BY cuisine
ORDER BY restaurant_count DESC
LIMIT 10;

-- Insight:
-- This identifies the most common cuisine options available to users.

-- Product Interpretation:
-- Cuisine concentration can explain user choice overload and competition
-- within popular food categories.

-- Dashboard Usage:
-- Used as a top cuisines chart on the market overview page.



-- =========================================================
-- Q26. RESTAURANT TYPE ANALYSIS
-- Business Question:
-- Which restaurant types dominate and how do they differ by cost/rating?
-- =========================================================

SELECT
    restaurant_type,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rate), 2) AS avg_rating,
    ROUND(AVG(approx_cost_for_two_people), 2) AS avg_cost_for_two
FROM zomato_restaurants
GROUP BY restaurant_type
ORDER BY restaurant_count DESC
LIMIT 15;

-- Insight:
-- This shows whether the market is driven by casual dining, quick bites,
-- cafes, delivery formats, or other restaurant types.

-- Product Interpretation:
-- Restaurant type impacts user expectations around price, speed, and experience.

-- Dashboard Usage:
-- Used in restaurant market and rating-by-type analysis.



-- =========================================================
-- Q27. LOCATION-LEVEL RESTAURANT PRICING
-- Business Question:
-- Which locations have higher average food cost?
-- =========================================================

SELECT
    location,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(approx_cost_for_two_people), 2) AS avg_cost_for_two,
    ROUND(AVG(rate), 2) AS avg_rating
FROM zomato_restaurants
GROUP BY location
HAVING COUNT(*) >= 10
ORDER BY avg_cost_for_two DESC
LIMIT 15;

-- Insight:
-- This highlights locations where food ordering may be relatively expensive.

-- Product Interpretation:
-- Location pricing differences can influence affordability perception
-- and user sensitivity to delivery/platform charges.

-- Dashboard Usage:
-- Used as optional location-level pricing analysis.



-- =========================================================
-- Q28. ONLINE ORDERING AVAILABILITY
-- Business Question:
-- How many restaurants support online ordering?
-- =========================================================

SELECT
    online_order,
    COUNT(*) AS restaurant_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato_restaurants), 2) AS restaurant_percent,
    ROUND(AVG(rate), 2) AS avg_rating,
    ROUND(AVG(approx_cost_for_two_people), 2) AS avg_cost_for_two
FROM zomato_restaurants
GROUP BY online_order;

-- Insight:
-- This checks how widely online ordering is available in the restaurant dataset.

-- Product Interpretation:
-- Online-order availability affects convenience and platform usability.
-- If online-enabled restaurants differ in price or rating, that can affect conversion.

-- Dashboard Usage:
-- Used as supporting analysis for restaurant supply and convenience.
