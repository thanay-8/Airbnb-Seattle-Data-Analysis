-- AIRBNB SEATTLE - IMPORT-SAFE MYSQL TABLE SETUP
-- Run this before importing the cleaned CSV files.
-- This drops and recreates the three tables, so use it only while they are empty.
CREATE DATABASE IF NOT EXISTS airbnb_seattle;
USE airbnb_seattle;


DROP TABLE IF EXISTS `listings_clean`;
CREATE TABLE `listings_clean` (
    `id` LONGTEXT NULL,
    `name` LONGTEXT NULL,
    `summary` LONGTEXT NULL,
    `space` LONGTEXT NULL,
    `description` LONGTEXT NULL,
    `neighborhood_overview` LONGTEXT NULL,
    `notes` LONGTEXT NULL,
    `transit` LONGTEXT NULL,
    `host_id` LONGTEXT NULL,
    `host_name` LONGTEXT NULL,
    `host_since` LONGTEXT NULL,
    `host_location` LONGTEXT NULL,
    `host_about` LONGTEXT NULL,
    `host_response_time` LONGTEXT NULL,
    `host_response_rate` LONGTEXT NULL,
    `host_acceptance_rate` LONGTEXT NULL,
    `host_is_superhost` LONGTEXT NULL,
    `host_neighbourhood` LONGTEXT NULL,
    `host_listings_count` LONGTEXT NULL,
    `host_total_listings_count` LONGTEXT NULL,
    `host_verifications` LONGTEXT NULL,
    `host_has_profile_pic` LONGTEXT NULL,
    `host_identity_verified` LONGTEXT NULL,
    `street` LONGTEXT NULL,
    `neighbourhood` LONGTEXT NULL,
    `neighbourhood_cleansed` LONGTEXT NULL,
    `neighbourhood_group_cleansed` LONGTEXT NULL,
    `city` LONGTEXT NULL,
    `state` LONGTEXT NULL,
    `zipcode` LONGTEXT NULL,
    `market` LONGTEXT NULL,
    `smart_location` LONGTEXT NULL,
    `country_code` LONGTEXT NULL,
    `country` LONGTEXT NULL,
    `latitude` LONGTEXT NULL,
    `longitude` LONGTEXT NULL,
    `is_location_exact` LONGTEXT NULL,
    `property_type` LONGTEXT NULL,
    `room_type` LONGTEXT NULL,
    `accommodates` LONGTEXT NULL,
    `bathrooms` LONGTEXT NULL,
    `bedrooms` LONGTEXT NULL,
    `beds` LONGTEXT NULL,
    `bed_type` LONGTEXT NULL,
    `amenities` LONGTEXT NULL,
    `price` LONGTEXT NULL,
    `weekly_price` LONGTEXT NULL,
    `monthly_price` LONGTEXT NULL,
    `security_deposit` LONGTEXT NULL,
    `cleaning_fee` LONGTEXT NULL,
    `guests_included` LONGTEXT NULL,
    `extra_people` LONGTEXT NULL,
    `minimum_nights` LONGTEXT NULL,
    `maximum_nights` LONGTEXT NULL,
    `calendar_updated` LONGTEXT NULL,
    `has_availability` LONGTEXT NULL,
    `availability_30` LONGTEXT NULL,
    `availability_60` LONGTEXT NULL,
    `availability_90` LONGTEXT NULL,
    `availability_365` LONGTEXT NULL,
    `number_of_reviews` LONGTEXT NULL,
    `first_review` LONGTEXT NULL,
    `last_review` LONGTEXT NULL,
    `review_scores_rating` LONGTEXT NULL,
    `review_scores_accuracy` LONGTEXT NULL,
    `review_scores_cleanliness` LONGTEXT NULL,
    `review_scores_checkin` LONGTEXT NULL,
    `review_scores_communication` LONGTEXT NULL,
    `review_scores_location` LONGTEXT NULL,
    `review_scores_value` LONGTEXT NULL,
    `jurisdiction_names` LONGTEXT NULL,
    `instant_bookable` LONGTEXT NULL,
    `cancellation_policy` LONGTEXT NULL,
    `require_guest_profile_picture` LONGTEXT NULL,
    `require_guest_phone_verification` LONGTEXT NULL,
    `calculated_host_listings_count` LONGTEXT NULL,
    `reviews_per_month` LONGTEXT NULL
);


DROP TABLE IF EXISTS `calendar_clean`;
CREATE TABLE `calendar_clean` (
    `listing_id` LONGTEXT NULL,
    `date` LONGTEXT NULL,
    `available` LONGTEXT NULL,
    `price` LONGTEXT NULL,
    `year` LONGTEXT NULL,
    `month` LONGTEXT NULL,
    `month_name` LONGTEXT NULL,
    `day_of_week` LONGTEXT NULL
);


DROP TABLE IF EXISTS `reviews_clean`;
CREATE TABLE `reviews_clean` (
    `listing_id` LONGTEXT NULL,
    `id` LONGTEXT NULL,
    `date` LONGTEXT NULL,
    `reviewer_id` LONGTEXT NULL,
    `reviewer_name` LONGTEXT NULL,
    `comments` LONGTEXT NULL
);


-- Verify row counts AFTER importing all three CSV files:
SELECT COUNT(*) AS listings_rows FROM listings_clean;
SELECT COUNT(*) AS calendar_rows FROM calendar_clean;
SELECT COUNT(*) AS reviews_rows FROM reviews_clean;


SELECT COUNT(*) AS total_rows
FROM airbnb_seattle.listings_clean;
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
USE airbnb_seattle;
TRUNCATE TABLE listings_clean;

-- THESE QUERIES ARE FOR IMPORTING LOCAL CSV FILES TO MYSQL WORKBENCH
-- LOCAL_INFILE-- USED FOR IMPORTING LOCAL FILES FROM PC/ LAPTOP
SHOW variables LIKE 'LOCAL_INFILE';

-- LOCAL_INFILE = OFF-- IF OFF, WE CAN'T IMPORT LOCAL FILES
-- LOCAL_INFILE = ON-- IF ON, WE CAN IMPORT LOCAL FILES
SET GLOBAL local_infile = ON;
USE airbnb_seattle;

-- "LOAD DATA LOCAL INFILE", A COMMAND FOR IMPORTING LOCAL FILES
LOAD DATA LOCAL INFILE 
'C:/Users/gannu/OneDrive/Documents/Data_Analytics_related/Excel/DONE PROJECTS/listings_clean.csv'
INTO TABLE listings_clean
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows
FROM listings_clean;


LOAD DATA LOCAL INFILE
'C:/Users/gannu/OneDrive/Documents/Data_Analytics_related/Excel/DONE PROJECTS/reviews_clean.csv'
INTO TABLE reviews_clean
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows
FROM reviews_clean;

LOAD DATA LOCAL INFILE
'C:/Users/gannu/OneDrive/Documents/Data_Analytics_related/Excel/DONE PROJECTS/calendar_clean.csv'
INTO TABLE calendar_clean
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows
FROM calendar_clean;