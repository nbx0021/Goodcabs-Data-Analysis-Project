
-- Passenger Satisfaction vs Target Ratings
SELECT 
    c.city_name,
    ROUND(AVG(t.passenger_rating), 2) AS actual_avg_rating,
    ctpr.target_avg_passenger_rating,
    (ROUND(AVG(t.passenger_rating), 2) - ctpr.target_avg_passenger_rating) AS rating_variance
FROM trips_db.fact_trips t
JOIN trips_db.dim_city c 
    ON t.city_id = c.city_id
JOIN targets_db.city_target_passenger_rating ctpr 
    ON t.city_id = ctpr.city_id
GROUP BY c.city_name, ctpr.target_avg_passenger_rating
ORDER BY rating_variance DESC;
