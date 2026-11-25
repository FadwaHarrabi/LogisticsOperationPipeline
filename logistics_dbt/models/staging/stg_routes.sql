{{config(materialized='table')}}
SELECT
   CAST(route_id AS VARCHAR(255)) AS route_id,
   CAST(origin_city AS VARCHAR(255)) AS origin_city,
   CAST(origin_state AS VARCHAR(255)) AS origin_state,
   CAST(destination_city AS VARCHAR(255)) AS destination_city,
   CAST(destination_state AS VARCHAR(255)) AS destination_state,
   distance_miles,
   typical_transit_days,
   base_rate_per_mile,
   fuel_surcharge_rate


FROM {{source('logistics','routes')}}