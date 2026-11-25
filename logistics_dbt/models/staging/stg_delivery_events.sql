{{config(materialized='table')}}

SELECT  
  
    CAST(event_id AS VARCHAR(255)) AS event_id,
    CAST(load_id AS VARCHAR(255)) AS load_id,
    CAST(trip_id AS VARCHAR(255)) AS trup_id,
    CAST(event_type AS VARCHAR(255)) AS event_type,
    CAST(facility_id AS VARCHAR(255)) AS facility_id,
    scheduled_datetime,
    actual_datetime,
    detention_minutes,
    on_time_flag,
    CAST(location_city AS VARCHAR(255)) AS location_city,
    CAST(location_state AS VARCHAR(255)) AS location_state,

FROM {{source('logistics', 'delivery_events')}}