{{ config(materialized='table',pre_hook="TRUNCATE TABLE IF EXISTS {{this}}") }}


SELECT 
    CAST(customer_id AS VARCHAR(255)) AS customer_id,
    CAST(customer_name AS VARCHAR(255)) AS customer_name,
    CAST(contract_type AS VARCHAR(255)) AS contract_type,
    CAST(account_status AS INTEGER) AS account_status,
    CAST(city AS VARCHAR(255)) AS city,
    CAST(state AS VARCHAR(255)) AS state,
    CAST(onboarding_date AS DATE) AS onboarding_date,
    annual_revenue_potential,
    CASE 
        WHEN onboarding_date IS NULL THEN NULL
        ELSE datediff('YEAR', onboarding_date, CURRENT_DATE)
    END AS customer_tenure_years
FROM {{source('logistics', 'customers')}}