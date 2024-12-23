

-- New Passengers vs Target
SELECT 
    c.city_name,
    DATE_FORMAT(fps.month, '%Y-%m') AS month,
    SUM(fps.new_passengers) AS actual_new_passengers,
    mtnp.target_new_passengers,
    (SUM(fps.new_passengers) - mtnp.target_new_passengers) AS new_passenger_variance
FROM trips_db.fact_passenger_summary fps
JOIN trips_db.dim_city c 
    ON fps.city_id = c.city_id
JOIN targets_db.monthly_target_new_passengers mtnp 
    ON fps.city_id = mtnp.city_id AND fps.month = mtnp.month
GROUP BY c.city_name, fps.month, mtnp.target_new_passengers
ORDER BY fps.month, c.city_name;
