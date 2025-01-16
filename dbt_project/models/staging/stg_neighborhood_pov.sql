-- models/staging/stg_neighborhood_pov.sql

{{ config(
    materialized='view'
) }}

SELECT
    CAST("OBJECTID" AS INTEGER) AS objectid,
    "NAME"::TEXT AS name,
    "NCESSCH"::TEXT AS ncessch,
    CAST("IPR_EST" AS INTEGER) AS ipr_est,
    CAST("IPR_SE" AS INTEGER) AS ipr_se,
    "SCHOOLYEAR"::TEXT AS schoolyear,
    CAST("LAT" AS NUMERIC) AS lat,
    CAST("LON" AS NUMERIC) AS lon
FROM {{ source('public', 'neighborhood_pov') }}

