{{ config(materialized='table',pre_hook="TRUNCATE TABLE IF EXISTS {{this}}") }}

SELECT 
    CAST(trailer_id AS VARCHAR(255)) AS trailer_id,
    CAST(trailer_number AS VARCHAR(255)) AS trailer_number,
    CAST(trailer_type AS VARCHAR(255)) AS trailer_type,
    length_feet,
    CAST(model_year AS INTEGER) AS model_year,
    CAST(vin AS VARCHAR(255)) AS vin,
    CAST(acquisition_date AS DATE) AS acquisition_date,
    CAST(status AS VARCHAR(255)) AS status,
    CAST(current_location AS VARCHAR(255)) AS current_location
FROM {{ source('logistics', 'trailers') }}
 