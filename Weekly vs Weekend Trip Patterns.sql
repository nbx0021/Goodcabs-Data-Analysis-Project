

-- Weekday vs Weekend Trip Patterns

SELECT 
    d.day_type,
    COUNT(t.trip_id) AS trip_count
FROM trips_db.fact_trips t
JOIN trips_db.dim_date d 
    ON t.date = d.date
GROUP BY d.day_type
ORDER BY trip_count DESC;


-- Weekday vs Weekend Trip Demand by City

SELECT 
    c.city_name,
    d.day_type,
    COUNT(t.trip_id) AS trip_count
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
JOIN trips_db.dim_date d 
    ON t.date = d.date
GROUP BY c.city_name, d.day_type
ORDER BY c.city_name, d.day_type;
