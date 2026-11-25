{{config(materialized='table')}}

SELECT
    facility_id,
    CAST(facility_name AS VARCHAR(255)) AS facility_name,
    CAST(facility_type AS VARCHAR(255)) AS facility_type,
    CAST(city AS VARCHAR(255)) AS city,
    CAST(state AS VARCHAR(255)) AS state,
    latitude,
    longitude,
    dock_doors,
    CAST(capacity AS VARCHAR(255)) AS capacity

FROM {{ source('logistics', 'facilities') }}