{{config(materialized='table')}}
SELECT  
     CAST(maintenance_id AS VARCHAR(255)) AS maintenance_id,
     CAST(truck_id AS VARCHAR(255)) AS truck_id,
     maintenance_date,
     CAST(maintenance_type AS VARCHAR(255)) AS maintenance_type,
     odometer_reading,
     labor_hours,
     labor_cost,
     parts_cost,
     total_cost,
     CAST(facility_location AS VARCHAR(255)) AS facility_location,
     downtime_hours,
     CAST(service_description AS VARCHAR(4000)) AS service_description

FROM {{source('logistics','maintenance_records')}}