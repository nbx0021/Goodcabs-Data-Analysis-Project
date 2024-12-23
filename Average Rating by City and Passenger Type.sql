-- Average Rating by City and Passenger Type
SELECT 
    c.city_name,
    t.passenger_type,
    ROUND(AVG(t.passenger_rating), 2) AS avg_passenger_rating
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
WHERE t.passenger_rating IS NOT NULL  
GROUP BY c.city_name, t.passenger_type
ORDER BY c.city_name, avg_passenger_rating DESC;



SELECT 
    c.city_name,
    t.passenger_type,
    ROUND(AVG(t.passenger_rating), 2) AS avg_passenger_rating,
    COUNT(t.trip_id) AS trip_count
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
WHERE t.passenger_rating IS NOT NULL
GROUP BY c.city_name, t.passenger_type
ORDER BY c.city_name, avg_passenger_rating DESC;
