{{config(materialized='table')}}

SELECT 
     CAST(trip_id  AS VARCHAR(255)) AS trip_id,
     CAST(load_id AS VARCHAR(255)) AS load_id,
     CAST(driver_id AS VARCHAR(255)) AS driver_id,
     CAST(truck_id AS VARCHAR(255)) AS truck_id,
     CAST(trailer_id AS VARCHAR(255)) AS trailer_id,
     dispatch_date,
     actual_distance_miles,
     actual_duration_hours,
     fuel_gallons_used,
     average_mpg,
     idle_time_hours,
     CAST(trip_status AS VARCHAR(255)) AS trip_status
FROM {{source('logistics','trips')}}