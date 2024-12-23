
-- Trip Volume vs Target Trips


SELECT 
    c.city_name,
    DATE_FORMAT(d.start_of_month,'%y-%m') AS month,
    COUNT(t.trip_id) AS actual_trip_count,
    mtt.total_target_trips,
    (COUNT(t.trip_id) - mtt.total_target_trips) AS trip_variance
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
JOIN trips_db.dim_date d 
    ON t.date = d.date
JOIN targets_db.monthly_target_trips mtt 
    ON t.city_id = mtt.city_id AND d.start_of_month = mtt.month
GROUP BY c.city_name, d.start_of_month, mtt.total_target_trips
ORDER BY trip_variance DESC;



