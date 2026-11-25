{{config(materialized='table')}}
SELECT 

    fuel_purchase_id,
    CAST(trip_id AS VARCHAR(255)) AS trip_id,
    CAST(truck_id AS VARCHAR(255)) AS truck_id,
    CAST(driver_id AS VARCHAR(255)) AS driver_id,
    purchase_date,
    CAST(location_city AS VARCHAR(255)) AS location_city,
    CAST(location_state AS VARCHAR(255)) AS location_state,
    gallons,
    price_per_gallon,
    total_cost,
    CAST(fuel_card_number AS VARCHAR(255)) AS fuel_card_number
FROM {{source('logistics', 'fuel_purchases')}}