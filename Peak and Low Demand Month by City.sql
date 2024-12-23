-- Peak and Low Demand Month by City

WITH monthly_trip_counts AS (
    SELECT 
        c.city_name,
        DATE_FORMAT(t.date, '%Y-%m') AS month,  
        COUNT(t.trip_id) AS total_trips
    FROM trips_db.fact_trips t
    JOIN trips_db.dim_city c 
        ON t.city_id = c.city_id
    GROUP BY c.city_name, DATE_FORMAT(t.date, '%Y-%m')
)
SELECT 
    city_name,
    MAX(CASE WHEN total_trips = max_trips THEN month END) AS peak_demand_month,
    MAX(total_trips) AS peak_demand_trips,
    MIN(CASE WHEN total_trips = min_trips THEN month END) AS low_demand_month,
    MIN(total_trips) AS low_demand_trips
FROM (
    SELECT 
        city_name,
        month,
        total_trips,
        MAX(total_trips) OVER (PARTITION BY city_name) AS max_trips,
        MIN(total_trips) OVER (PARTITION BY city_name) AS min_trips
    FROM monthly_trip_counts
) ranked_data
GROUP BY city_name;
