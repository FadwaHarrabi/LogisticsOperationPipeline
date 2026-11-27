{{config(materialized='table')}}

SELECT  
     CAST(truck_id AS VARCHAR(255)) AS truck_id,
     CAST(unit_number AS VARCHAR(255)) AS unit_number,
     CAST(make AS VARCHAR(255)) AS make,
     CAST(model_year AS INTEGER) AS model_year,
     CAST(vin AS VARCHAR(255)) AS vin,
     acquisition_date,
     acquisition_mileage,
     CAST(fuel_type AS VARCHAR(255)) AS fuel_type,
     CAST(tank_capacity_gallons AS VARCHAR(255)) AS tank_capacity_gallons,
     CAST(status AS VARCHAR(255)) AS status,
     CAST(home_terminal AS VARCHAR(255)) AS home_terminal
FROM {{source('logistics','trucks')}}