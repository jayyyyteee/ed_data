-- models/staging/stg_public_school_locations.sql

{{ config(
    materialized='view'
) }}

SELECT
    CAST("OBJECTID" AS INTEGER) AS objectid,
    "NCESSCH"::TEXT AS ncessch,
    "LEAID"::TEXT AS leaid,
    "NAME"::TEXT AS name,
    "OPSTFIPS"::TEXT AS opstfips,
    "STREET"::TEXT AS street,
    "CITY"::TEXT AS city,
    "STATE"::TEXT AS state,
    "ZIP"::TEXT AS zip,
    "STFIP"::TEXT AS stfip,
    "CNTY"::TEXT AS cnty,
    "NMCNTY"::TEXT AS nmcnty,
    "LOCALE"::TEXT AS locale,
    CAST("LAT" AS NUMERIC) AS lat,
    CAST("LON" AS NUMERIC) AS lon,
    "CBSA"::TEXT AS cbsa,
    "NMCBSA"::TEXT AS nmcbsa,
    "CBSATYPE"::TEXT AS cbsatype,
    "CSA"::TEXT AS csa,
    "NMCSA"::TEXT AS nmcsa,
    "NECTA"::TEXT AS necta,
    "NMNECTA"::TEXT AS nmnecta,
    "CD"::TEXT AS cd,
    "SLDL"::TEXT AS sldl,
    "SLDU"::TEXT AS sldu,
    "SCHOOLYEAR"::TEXT AS schoolyear
FROM {{ source('public', 'public_school_locations') }}
