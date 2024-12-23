-- RPR% by City and Month

WITH CityRPR AS (
    SELECT 
        c.city_name,
        DATE_FORMAT(fps.month, '%Y-%m') AS month,
        SUM(fps.repeat_passengers) AS total_repeat_passengers,
        SUM(fps.total_passengers) AS total_passengers,
        ROUND((SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers), 2) AS rpr_percentage
    FROM trips_db.fact_passenger_summary fps
    JOIN trips_db.dim_city c 
        ON fps.city_id = c.city_id
    GROUP BY c.city_name, fps.month
)
SELECT 
     city_name,
    month,
    rpr_percentage
FROM CityRPR
WHERE rpr_percentage IS NOT NULL
ORDER BY rpr_percentage 
-- Top 2 Cities
DESC 
-- Bottom 2 Cities
-- ASC
LIMIT 5; 




-- Month with Highest RPR%

WITH MonthlyRPR AS (
    SELECT 
        DATE_FORMAT(fps.month, '%Y-%m') AS month, -- Extract year and month
        SUM(fps.repeat_passengers) AS total_repeat_passengers,
        SUM(fps.total_passengers) AS total_passengers,
        ROUND((SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers), 2) AS rpr_percentage
    FROM trips_db.fact_passenger_summary fps
    GROUP BY DATE_FORMAT(fps.month, '%Y-%m')  -- Grouping by month
)
SELECT 
    month,
    total_repeat_passengers,
    total_passengers,
    rpr_percentage
FROM MonthlyRPR
ORDER BY rpr_percentage DESC;

-- Overall RPR% by City

SELECT 
    c.city_name,
    SUM(fps.repeat_passengers) AS total_repeat_passengers,
    SUM(fps.total_passengers) AS total_passengers,
    ROUND((SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers), 2) AS rpr_percentage
FROM trips_db.fact_passenger_summary fps
JOIN trips_db.dim_city c 
    ON fps.city_id = c.city_id
GROUP BY c.city_name
ORDER BY rpr_percentage DESC;


-- Top and Bottom 5 Cities Based on RPR% 6 Months period

WITH RPR_City AS (
    SELECT 
        c.city_name,
        SUM(fps.repeat_passengers) AS total_repeat_passengers,
        SUM(fps.total_passengers) AS total_passengers,
        ROUND((SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers), 2) AS rpr_percentage
    FROM trips_db.fact_passenger_summary fps
    JOIN trips_db.dim_city c 
        ON fps.city_id = c.city_id
    WHERE fps.month >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 6 MONTH), '%Y-%m-01') -- Last 6 months dynamically
    GROUP BY c.city_name
)
SELECT 
    city_name,
    rpr_percentage
FROM RPR_City
ORDER BY rpr_percentage DESC
LIMIT 5; -- Top 2 cities

-- For Bottom 2 Cities:
SELECT 
    city_name,
    rpr_percentage
FROM RPR_City
ORDER BY rpr_percentage ASC
LIMIT 5; -- Bottom 2 cities



-- Month with Highest and Lowest RPR% RPR% 6 Months period
WITH RPR_Monthly AS (
    SELECT 
        c.city_name,
        DATE_FORMAT(fps.month, '%Y-%m') AS month,
        SUM(fps.repeat_passengers) AS total_repeat_passengers,
        SUM(fps.total_passengers) AS total_passengers,
        ROUND(
            (SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers),
            2
        ) AS rpr_percentage
    FROM trips_db.fact_passenger_summary fps
    JOIN trips_db.dim_city c ON fps.city_id = c.city_id
    WHERE fps.month >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 6 MONTH), '%Y-%m-01') -- Last 6 months dynamically
    GROUP BY c.city_name, DATE_FORMAT(fps.month, '%Y-%m')
)
SELECT 
    city_name,
    month,
    rpr_percentage
FROM RPR_Monthly
ORDER BY rpr_percentage DESC
LIMIT 5;

-- Month with the highest RPR%
-- For the month with the lowest RPR%:
SELECT
city_name, 
month,
    rpr_percentage
FROM RPR_Monthly
ORDER BY rpr_percentage ASC
LIMIT 5;
-- Month with the lowest RPR%