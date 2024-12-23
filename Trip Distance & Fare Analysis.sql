

-- Trip Distance & Fare Analysis

SELECT 
    c.city_name,
    COUNT(t.trip_id) AS actual_trip_count,
    ROUND(AVG(t.distance_travelled_km), 2) AS avg_distance_km,
    ROUND(AVG(t.fare_amount), 2) AS avg_fare_amount
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
GROUP BY c.city_name
ORDER BY avg_distance_km DESC;



-- Higest revenue month for each city  

WITH CityRevenue AS (
    -- Calculate total revenue by city and month from fact_trips
    SELECT 
        c.city_name,
        d.month_name,
        d.start_of_month AS month_start, 
        SUM(f.fare_amount) AS total_revenue
    FROM trips_db.fact_trips f
    JOIN trips_db.dim_city c ON f.city_id = c.city_id
    JOIN trips_db.dim_date d ON f.date = d.date
    GROUP BY c.city_name, d.month_name, d.start_of_month
),
MaxRevenueMonth AS (
    -- Identify the highest revenue month for each city
    SELECT 
        city_name,
        month_name AS highest_revenue_month,
        month_start,
        total_revenue,
        RANK() OVER (PARTITION BY city_name ORDER BY total_revenue DESC) AS revenue_rank
    FROM CityRevenue
),
CityTarget AS (
    -- Retrieve the target values from targets_db
    SELECT 
        c.city_name,
        t.month AS target_month,
        t.total_target_trips,
        nt.target_new_passengers,
        rt.target_avg_passenger_rating
    FROM targets_db.monthly_target_trips t
    JOIN trips_db.dim_city c ON t.city_id = c.city_id
    LEFT JOIN targets_db.monthly_target_new_passengers nt 
        ON t.city_id = nt.city_id AND t.month = nt.month
    LEFT JOIN targets_db.city_target_passenger_rating rt 
        ON t.city_id = rt.city_id
),
CityContribution AS (
    -- Filter to get the highest revenue month for each city and calculate contribution
    SELECT 
        city_name,
        highest_revenue_month,
        month_start,
        total_revenue,
        ROUND(total_revenue * 100.0 / SUM(total_revenue) OVER (), 2) AS percentage_contribution
    FROM MaxRevenueMonth
    WHERE revenue_rank = 1
)
SELECT 
    cc.city_name,
    cc.highest_revenue_month,
    cc.total_revenue AS revenue,
    cc.percentage_contribution,
    ct.total_target_trips,
    ct.target_new_passengers,
    ct.target_avg_passenger_rating
FROM CityContribution cc
LEFT JOIN CityTarget ct 
    ON cc.city_name = ct.city_name AND cc.month_start = ct.target_month
ORDER BY cc.total_revenue DESC;
