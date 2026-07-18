# Airbnb Seattle Data Analysis & Interactive Dashboard

## Project Overview

This project presents an end-to-end data analysis of the **Seattle
Airbnb market** using listing, review, and calendar datasets. The
project involves data cleaning and exploratory data analysis using
Python and Pandas, SQL-based analysis using MySQL, and interactive
dashboard development using Power BI.

The analysis focuses on identifying patterns related to Airbnb
**pricing, availability, neighbourhoods, room types, property types,
guest capacity, reviews, ratings, seasonality, and Superhost status**.

## Project Objectives

-   Clean and preprocess raw Airbnb datasets for analysis.
-   Perform Exploratory Data Analysis (EDA) to understand data quality
    and important patterns.
-   Use SQL queries to perform structured analysis on the cleaned
    datasets.
-   Analyze factors associated with Airbnb listing prices.
-   Examine seasonal pricing and availability trends.
-   Compare listings across neighbourhoods, room types, and property
    types.
-   Analyze guest ratings, reviews, and Superhost characteristics.
-   Build an interactive Power BI dashboard to communicate key findings.

## Tools & Technologies

  Tool               Purpose
  ------------------ ----------------------------------------------
  Python             Data cleaning and EDA
  Pandas             Data manipulation and preprocessing
  Jupyter Notebook   Python analysis environment
  MySQL              Database management
  SQL                Data querying and analysis
  Power Query        Data transformation in Power BI
  Power BI           Data visualization and dashboard development
  DAX                KPI and analytical measure creation

## Dataset Overview

The project uses three Airbnb datasets:

-   **Listings:** Contains listing-level information such as
    neighbourhood, room type, property type, price, guest capacity, host
    information, ratings, and reviews.
-   **Reviews:** Contains individual guest review records associated
    with Airbnb listings.
-   **Calendar:** Contains date-level pricing and availability
    information used for seasonal analysis.

The cleaned datasets contain approximately:

-   **3,818 listings**
-   **84,849 review records**
-   **1,393,570 calendar records**

## Project Workflow

    Raw Airbnb Data
           ↓
    Data Understanding
           ↓
    Data Cleaning & Preprocessing
           ↓
    Exploratory Data Analysis (EDA)
           ↓
    Cleaned CSV Files
           ↓
    MySQL Database
           ↓
    SQL Analysis
           ↓
    Power BI & Power Query
           ↓
    Data Modelling
           ↓
    DAX Measures
           ↓
    Interactive Dashboard
           ↓
    Insights & Conclusion

## Data Cleaning & EDA

The raw Airbnb datasets were examined and prepared for analysis using
Python and Pandas.

The data preparation process included:

-   Removing columns that were not relevant to the analytical
    requirements.
-   Handling missing and empty values based on column relevance.
-   Correcting inconsistent data types.
-   Preparing price and numerical columns for analysis.
-   Examining dataset structure and distributions.
-   Creating analysis-ready datasets.

The resulting cleaned files were:

-   `listings_clean.csv`
-   `reviews_clean.csv`
-   `calendar_clean.csv`

## SQL Analysis

The cleaned datasets were imported into MySQL as separate tables for
Listings, Reviews, and Calendar data.

SQL queries were used to analyze:

-   Listing distribution
-   Average pricing
-   Neighbourhood-level patterns
-   Room and property types
-   Reviews and ratings
-   Availability patterns
-   Other relevant Airbnb listing characteristics

## Power BI Data Model

The cleaned datasets were imported into Power BI and connected using the
Airbnb listing ID.

    listings_clean[id]
            |
            +---- 1 : * ---- calendar_clean[listing_id]
            |
            +---- 1 : * ---- reviews_clean[listing_id]

The Listings table acts as the primary listing-level table.

### DAX Measures

Key DAX measures created include:

-   Total Listings
-   Average Price
-   Average Rating
-   Total Reviews
-   Available Days
-   Availability Rate

## Power BI Dashboard

The final dashboard consists of **three interactive pages**.

### Page 1 --- Airbnb Seattle Market Overview

Provides an overview of the Seattle Airbnb market using KPI cards and
visualizations for:

-   Total Listings
-   Average Price
-   Average Rating
-   Total Reviews
-   Availability Rate
-   Top neighbourhoods by average price
-   Listings by room type
-   Average price by room type

### Page 2 --- Pricing & Seasonal Analysis

Focuses on pricing and availability patterns using:

-   Monthly average price trends
-   Average price by day of week
-   Availability rate by month
-   Top property types by average price
-   Average price by guest capacity

### Page 3 --- Reviews & Host Analysis

Focuses on guest satisfaction and host characteristics using:

-   Average rating by Superhost status
-   Average price by Superhost status
-   Top 10 most reviewed listings
-   Average rating by neighbourhood group
-   Average rating by room type

Interactive slicers allow users to dynamically explore different
segments of the data.

## Key Insights

-   The dataset contains **3,818 listings** with an average listing
    price of approximately **\$127.98**.
-   The overall average guest rating is approximately **95/100**.
-   The analysis includes approximately **84,849 reviews**.
-   The overall availability rate is approximately **67.06%**.
-   Listing prices vary considerably across neighbourhoods, showing the
    importance of location.
-   Entire homes/apartments dominate the listing market and generally
    command higher prices than private and shared rooms.
-   Property type and guest capacity are associated with differences in
    average listing prices.
-   Pricing and availability show seasonal variation throughout the
    year.
-   Superhost listings generally demonstrate stronger guest ratings.
-   Guest satisfaction remains relatively high across neighbourhood
    groups and room types.

## Conclusion

This project demonstrates an end-to-end data analytics workflow, from
raw data preparation and exploratory analysis to SQL querying and
interactive business intelligence reporting.

The project highlights practical skills in **Python, Pandas, SQL, MySQL,
Power Query, Power BI, DAX, data cleaning, EDA, data modelling,
visualization, and insight generation**.

The final dashboard enables users to interactively explore Seattle
Airbnb market trends and better understand the factors associated with
pricing, availability, listing characteristics, and guest satisfaction.
