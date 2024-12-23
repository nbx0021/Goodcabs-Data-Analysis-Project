

-- City Performance Overview

SELECT 
    c.city_name,
    DATE_FORMAT(fps.month, '%Y-%m-%d') AS formatted_month,
    SUM(fps.total_passengers) AS total_passengers,
    SUM(fps.new_passengers) AS new_passengers,
    SUM(fps.repeat_passengers) AS repeat_passengers,
    ROUND((SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers), 2) AS repeat_passenger_percentage
FROM trips_db.fact_passenger_summary fps
JOIN trips_db.dim_city c 
    ON fps.city_id = c.city_id
GROUP BY c.city_name, fps.month
ORDER BY fps.month, total_passengers DESC;

