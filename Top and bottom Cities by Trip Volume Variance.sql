-- Top and Bottom Cities by Trip Volume
WITH AggregatedTargets AS (
    SELECT 
        city_id,
        SUM(total_target_trips) AS total_target_trips -- Aggregate target trips for each city
    FROM targets_db.monthly_target_trips
    GROUP BY city_id
)
SELECT 
    c.city_name,
    COUNT(t.trip_id) AS actual_trip_count,
    at.total_target_trips,
    (COUNT(t.trip_id) - at.total_target_trips) AS variance
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
JOIN AggregatedTargets at 
    ON t.city_id = at.city_id
GROUP BY c.city_name, at.total_target_trips
ORDER BY variance 
DESC;



-- Bottom Cities
WITH AggregatedTargets AS (
    SELECT 
        city_id,
        SUM(total_target_trips) AS total_target_trips -- Aggregate target trips for each city
    FROM targets_db.monthly_target_trips
    GROUP BY city_id
)
SELECT 
    c.city_name,
    COUNT(t.trip_id) AS actual_trip_count,
    at.total_target_trips,
    (COUNT(t.trip_id) - at.total_target_trips) AS variance
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
JOIN AggregatedTargets at 
    ON t.city_id = at.city_id
GROUP BY c.city_name, at.total_target_trips
ORDER BY variance 
ASC;
