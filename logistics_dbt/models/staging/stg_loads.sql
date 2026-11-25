{{config(materialized='table')}}
SELECT 
    CAST(load_id AS VARCHAR(255)) AS load_id,
    CAST(customer_id AS VARCHAR(255)) AS customer_id,
    CAST(route_id AS VARCHAR(255)) AS route_id,
    load_date,
    CAST(load_type AS VARCHAR(255)) AS load_type,
    weight_lbs,
    pieces,
    revenue,
    fuel_surcharge,
    accessorial_charges,
    CAST(load_status AS VARCHAR(255)) AS load_status,
    CAST(booking_type AS VARCHAR(255)) AS booking_type
FROM {{source('logistics', 'loads')}}