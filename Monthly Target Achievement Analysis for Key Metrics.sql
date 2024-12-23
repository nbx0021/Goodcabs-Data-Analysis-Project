
-- Total Trips vs Target Trips

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
    (COUNT(t.trip_id) - at.total_target_trips) AS variance,
    CASE 
        WHEN COUNT(t.trip_id) >= at.total_target_trips THEN 'Met/Exceeded'
        ELSE 'Missed'
    END AS target_status,
    ROUND(((COUNT(t.trip_id) - at.total_target_trips) * 100.0) / at.total_target_trips, 2) AS percentage_difference
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
JOIN AggregatedTargets at 
    ON t.city_id = at.city_id
GROUP BY c.city_name, at.total_target_trips
ORDER BY variance DESC;




-- New Passengers vs Target New Passengers

WITH AggregatedTargets AS (
    SELECT 
        city_id,
        SUM(target_new_passengers) AS total_target_new_passengers -- Aggregate target new passengers for each city
    FROM targets_db.monthly_target_new_passengers
    GROUP BY city_id
)
SELECT 
    c.city_name,
    SUM(fps.new_passengers) AS actual_new_passengers,
    at.total_target_new_passengers,
    (SUM(fps.new_passengers) - at.total_target_new_passengers) AS variance,
    CASE 
        WHEN SUM(fps.new_passengers) >= at.total_target_new_passengers THEN 'Met/Exceeded'
        ELSE 'Missed'
    END AS target_status,
    ROUND(((SUM(fps.new_passengers) - at.total_target_new_passengers) * 100.0) / at.total_target_new_passengers, 2) AS percentage_difference
FROM trips_db.fact_passenger_summary fps
JOIN trips_db.dim_city c 
    ON fps.city_id = c.city_id
JOIN AggregatedTargets at 
    ON fps.city_id = at.city_id
GROUP BY c.city_name, at.total_target_new_passengers
ORDER BY variance DESC;


-- Average Passenger Ratings vs Target Ratings

WITH AggregatedTargets AS (
    SELECT 
        city_id,
        AVG(target_avg_passenger_rating) AS total_target_avg_passenger_rating -- Aggregate target average passenger rating for each city
    FROM targets_db.city_target_passenger_rating
    GROUP BY city_id
)
SELECT 
    c.city_name,
    ROUND(AVG(t.passenger_rating), 2) AS actual_avg_passenger_rating,
    at.total_target_avg_passenger_rating,
    (AVG(t.passenger_rating) - at.total_target_avg_passenger_rating) AS variance,
    CASE 
        WHEN AVG(t.passenger_rating) >= at.total_target_avg_passenger_rating THEN 'Met/Exceeded'
        ELSE 'Missed'
    END AS target_status,
    ROUND(((AVG(t.passenger_rating) - at.total_target_avg_passenger_rating) * 100.0) / at.total_target_avg_passenger_rating, 2) AS percentage_difference
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
JOIN AggregatedTargets at 
    ON t.city_id = at.city_id
WHERE t.passenger_rating IS NOT NULL
GROUP BY c.city_name, at.total_target_avg_passenger_rating
ORDER BY percentage_difference DESC;
