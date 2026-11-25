{{config(materialized='table')}}
SELECT   
        CAST(incident_id AS VARCHAR(255)) AS incident_id,
        CAST(truck_id  AS VARCHAR(255)) AS truck_id,
        CAST(trip_id  AS VARCHAR(255)) AS trip_id,
        CAST(driver_id  AS VARCHAR(255)) AS driver_id,
        incident_date,
        CAST(incident_type  AS VARCHAR(255)) AS incident_type,
        CAST(location_city  AS VARCHAR(255)) AS location_city,
        CAST(location_state  AS VARCHAR(255)) AS location_state,
        at_fault_flag,
        injury_flag,
        vehicle_damage_cost,
        cargo_damage_cost,
        claim_amount,
        preventable_flag,
        CAST(description  AS VARCHAR(255)) AS description

FROM {{source('logistics','safety_incidents')}}