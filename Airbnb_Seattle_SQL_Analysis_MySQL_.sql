-- AIRBNB SEATTLE DATA ANALYSIS - MYSQL (IMPORT-SAFE LONGTEXT TABLES)
-- Run after importing listings_clean, reviews_clean, and calendar_clean.
USE airbnb_seattle;

-- 1. Total number of Airbnb listings
SELECT COUNT(DISTINCT CAST(id AS UNSIGNED)) AS total_listings
FROM listings_clean;

-- 2. Overall listing price summary
SELECT
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price,
    MIN(CAST(NULLIF(price, '') AS DECIMAL(10,2))) AS minimum_price,
    MAX(CAST(NULLIF(price, '') AS DECIMAL(10,2))) AS maximum_price
FROM listings_clean
WHERE NULLIF(price, '') IS NOT NULL;

-- 3. Average price by room type
SELECT
    room_type,
    COUNT(*) AS total_listings,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price
FROM listings_clean
WHERE NULLIF(price, '') IS NOT NULL
GROUP BY room_type
ORDER BY average_price DESC;

-- 4. Neighbourhood groups by average listing price
SELECT
    neighbourhood_group_cleansed AS neighbourhood_group,
    COUNT(*) AS total_listings,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price
FROM listings_clean
WHERE NULLIF(price, '') IS NOT NULL
GROUP BY neighbourhood_group_cleansed
HAVING COUNT(*) >= 20
ORDER BY average_price DESC;

-- 5. Property types by average price
SELECT
    property_type,
    COUNT(*) AS total_listings,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price
FROM listings_clean
WHERE NULLIF(price, '') IS NOT NULL
GROUP BY property_type
HAVING COUNT(*) >= 10
ORDER BY average_price DESC;

-- 6. Guest capacity vs average price
SELECT
    CAST(accommodates AS UNSIGNED) AS accommodates,
    COUNT(*) AS total_listings,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price
FROM listings_clean
WHERE NULLIF(accommodates, '') IS NOT NULL
  AND NULLIF(price, '') IS NOT NULL
GROUP BY CAST(accommodates AS UNSIGNED)
HAVING COUNT(*) >= 10
ORDER BY accommodates;

-- 7. Top-rated listings with at least 20 reviews
SELECT
    CAST(id AS UNSIGNED) AS listing_id,
    name,
    neighbourhood_group_cleansed AS neighbourhood_group,
    room_type,
    CAST(NULLIF(price, '') AS DECIMAL(10,2)) AS price,
    CAST(NULLIF(review_scores_rating, '') AS DECIMAL(10,2)) AS review_score,
    CAST(NULLIF(number_of_reviews, '') AS UNSIGNED) AS number_of_reviews
FROM listings_clean
WHERE NULLIF(review_scores_rating, '') IS NOT NULL
  AND CAST(NULLIF(number_of_reviews, '') AS UNSIGNED) >= 20
ORDER BY review_score DESC, number_of_reviews DESC
LIMIT 10;

-- 8. Superhost vs non-superhost performance
SELECT
    host_is_superhost,
    COUNT(*) AS total_listings,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price,
    ROUND(AVG(CAST(NULLIF(review_scores_rating, '') AS DECIMAL(10,2))), 2) AS average_rating,
    ROUND(AVG(CAST(NULLIF(number_of_reviews, '') AS DECIMAL(10,2))), 2) AS average_reviews
FROM listings_clean
GROUP BY host_is_superhost;

-- 9. Monthly seasonal pricing for available listing-days
SELECT
    CAST(month AS UNSIGNED) AS month_number,
    month_name,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price,
    COUNT(*) AS available_listing_days
FROM calendar_clean
WHERE LOWER(available) IN ('true', '1', 't')
  AND NULLIF(price, '') IS NOT NULL
GROUP BY CAST(month AS UNSIGNED), month_name
ORDER BY month_number;

-- 10. Monthly availability rate
SELECT
    CAST(month AS UNSIGNED) AS month_number,
    month_name,
    ROUND(
        100.0 * SUM(CASE WHEN LOWER(available) IN ('true','1','t') THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS availability_rate_pct
FROM calendar_clean
GROUP BY CAST(month AS UNSIGNED), month_name
ORDER BY month_number;

-- 11. Weekday vs weekend pricing
SELECT
    CASE
        WHEN day_of_week IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_category,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price,
    COUNT(*) AS available_listing_days
FROM calendar_clean
WHERE LOWER(available) IN ('true','1','t')
  AND NULLIF(price, '') IS NOT NULL
GROUP BY day_category
ORDER BY average_price DESC;

-- 12. Listings with the highest number of guest reviews
SELECT
    CAST(l.id AS UNSIGNED) AS listing_id,
    l.name,
    l.neighbourhood_group_cleansed AS neighbourhood_group,
    COUNT(r.id) AS total_reviews
FROM listings_clean l
JOIN reviews_clean r
    ON CAST(l.id AS UNSIGNED) = CAST(r.listing_id AS UNSIGNED)
GROUP BY CAST(l.id AS UNSIGNED), l.name, l.neighbourhood_group_cleansed
ORDER BY total_reviews DESC
LIMIT 10;

-- 13. Average price and rating by neighbourhood
SELECT
    neighbourhood_group_cleansed AS neighbourhood_group,
    COUNT(*) AS total_listings,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price,
    ROUND(AVG(CAST(NULLIF(review_scores_rating, '') AS DECIMAL(10,2))), 2) AS average_rating
FROM listings_clean
WHERE NULLIF(price, '') IS NOT NULL
GROUP BY neighbourhood_group_cleansed
HAVING COUNT(*) >= 20
ORDER BY average_price DESC;

-- 14. Potential value-for-money neighbourhoods
SELECT
    neighbourhood_group_cleansed AS neighbourhood_group,
    COUNT(*) AS total_listings,
    ROUND(AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))), 2) AS average_price,
    ROUND(AVG(CAST(NULLIF(review_scores_rating, '') AS DECIMAL(10,2))), 2) AS average_rating
FROM listings_clean
WHERE NULLIF(price, '') IS NOT NULL
  AND NULLIF(review_scores_rating, '') IS NOT NULL
GROUP BY neighbourhood_group_cleansed
HAVING COUNT(*) >= 20
   AND AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2))) <
       (SELECT AVG(CAST(NULLIF(price, '') AS DECIMAL(10,2)))
        FROM listings_clean
        WHERE NULLIF(price, '') IS NOT NULL)
   AND AVG(CAST(NULLIF(review_scores_rating, '') AS DECIMAL(10,2))) >= 90
ORDER BY average_price ASC, average_rating DESC;

-- 15. Available daily price by room type and neighbourhood
SELECT
    l.room_type,
    l.neighbourhood_group_cleansed AS neighbourhood_group,
    ROUND(AVG(CAST(NULLIF(c.price, '') AS DECIMAL(10,2))), 2) AS average_available_daily_price,
    COUNT(*) AS available_listing_days
FROM calendar_clean c
JOIN listings_clean l
    ON CAST(c.listing_id AS UNSIGNED) = CAST(l.id AS UNSIGNED)
WHERE LOWER(c.available) IN ('true','1','t')
  AND NULLIF(c.price, '') IS NOT NULL
GROUP BY l.room_type, l.neighbourhood_group_cleansed
ORDER BY average_available_daily_price DESC;
