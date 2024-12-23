-- Average Ratings and RPR% by City

WITH CityRPR AS (
    SELECT 
        fps.city_id,
        c.city_name,
        SUM(fps.repeat_passengers) AS total_repeat_passengers,
        SUM(fps.total_passengers) AS total_passengers,
        ROUND((SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers), 2) AS rpr_percentage
    FROM trips_db.fact_passenger_summary fps
    JOIN trips_db.dim_city c 
        ON fps.city_id = c.city_id
    GROUP BY fps.city_id, c.city_name
),
CityRatings AS (
    SELECT 
        t.city_id,
        ROUND(AVG(t.passenger_rating), 2) AS avg_passenger_rating
    FROM trips_db.fact_trips t
    GROUP BY t.city_id
)
SELECT 
    r.city_name,
    r.rpr_percentage,
    cr.avg_passenger_rating
FROM CityRPR r
JOIN CityRatings cr 
    ON r.city_id = cr.city_id
ORDER BY rpr_percentage DESC;



-- Average Fare vs RPR%

WITH CityRPR AS (
    SELECT 
        fps.city_id,
        c.city_name,
        SUM(fps.repeat_passengers) AS total_repeat_passengers,
        SUM(fps.total_passengers) AS total_passengers,
        ROUND((SUM(fps.repeat_passengers) * 100.0) / SUM(fps.total_passengers), 2) AS rpr_percentage
    FROM trips_db.fact_passenger_summary fps
    JOIN trips_db.dim_city c 
        ON fps.city_id = c.city_id
    GROUP BY fps.city_id, c.city_name
),
CityFares AS (
    SELECT 
        t.city_id,
        ROUND(AVG(t.fare_amount), 2) AS avg_fare_amount
    FROM trips_db.fact_trips t
    GROUP BY t.city_id
)
SELECT 
    r.city_name,
    r.rpr_percentage,
    cf.avg_fare_amount
FROM CityRPR r
JOIN CityFares cf 
    ON r.city_id = cf.city_id
ORDER BY rpr_percentage DESC;
