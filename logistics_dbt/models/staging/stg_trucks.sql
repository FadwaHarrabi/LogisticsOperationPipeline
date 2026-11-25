{{config(materialized='table')}}

SELECT  
     CAST(truck_id AS VARCHAR(255)) AS truck_id,
     CAST(unit_number AS VARCHAR(255)) AS unit_number,
     CAST(make AS VARCHAR(255)) AS make,
     CAST(model AS VARCHAR(255)) AS model,
     CAST(model_year AS VARCHAR(255)) AS model_year,
     CAST(vin AS VARCHAR(255)) AS vin,
     acquisition_date,
     CAST(acquisition_cost AS VARCHAR(255)) AS acquisition_cost,
     CAST(fuel_type AS VARCHAR(255)) AS fuel_type,
     CAST(tank_capacity_gallons AS VARCHAR(255)) AS tank_capacity_gallons,
     CAST(status AS VARCHAR(255)) AS status
FROM {{source('logistics','trucks')}}