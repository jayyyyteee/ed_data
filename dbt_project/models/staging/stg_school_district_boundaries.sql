-- models/staging/stg_school_district_boundaries.sql

{{ config(
    materialized='view'
) }}

SELECT
    CAST("OBJECTID" AS INTEGER) AS objectid,
    "STATEFP"::VARCHAR(2) AS statefp,
    "ELSDLEA"::VARCHAR(5) AS elsdlea,
    "SCSDLEA"::VARCHAR(5) AS scsdlea,
    "UNSDLEA"::VARCHAR(5) AS unsdlea,
    "SDADMLEA"::VARCHAR(5) AS sdadmlea,
    "GEOID"::VARCHAR(7) AS geoid,
    "NAME"::VARCHAR(100) AS name,
    "LSAD"::VARCHAR(2) AS lsad,
    "LOGRADE"::VARCHAR(2) AS lograde,
    "HIGRADE"::VARCHAR(2) AS higrade,
    "MTFCC"::VARCHAR(5) AS mtfcc,
    "SDTYP"::VARCHAR(1) AS sdtpy,
    "FUNCSTAT"::VARCHAR(1) AS funcstat,
    CAST("ALAND" AS DOUBLE PRECISION) AS aland,
    CAST("AWATER" AS DOUBLE PRECISION) AS awater,
    "INTPTLAT"::VARCHAR(11) AS intptlat,
    "INTPTLON"::VARCHAR(12) AS intptlon,
    "GEO_YEAR"::VARCHAR(4) AS geo_year,
    "SCHOOLYEAR"::VARCHAR(9) AS schoolyear,
    CAST("Shape__Area" AS DOUBLE PRECISION) AS shape__area,
    CAST("Shape__Length" AS DOUBLE PRECISION) AS shape__length
FROM {{ source('public', 'school_district_boundaries') }}
