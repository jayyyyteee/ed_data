-- models/staging/stg_school_district_characteristics.sql

{{ config(
    materialized='view' 
) }}

SELECT
    CAST("OBJECTID" AS INTEGER) AS objectid,
    "SURVYEAR"::TEXT AS survyear,
    "STATENAME"::TEXT AS statename,
    "LEAID"::TEXT AS leaid,
    "ST_LEAID"::TEXT AS st_leaid,
    "LEA_NAME"::TEXT AS lea_name,
    "LSTREET1"::TEXT AS lstreet1,
    "LSTREET2"::TEXT AS lstreet2,
    "LCITY"::TEXT AS lcity,
    "LSTATE"::TEXT AS lstate,
    "LZIP"::TEXT AS lzip,
    "LZIP4"::TEXT AS lzip4,
    "LEA_TYPE_TEXT"::TEXT AS lea_type_text,
    CAST("LEA_TYPE" AS NUMERIC) AS lea_type,
    "GSLO"::TEXT AS gslo,
    "GSHI"::TEXT AS gshi,
    "SY_STATUS_TEXT"::TEXT AS sy_status_text,
    CAST("SCH" AS INTEGER) AS sch,
    CAST("MEMBER" AS NUMERIC) AS member,
    CAST("TOTTCH" AS NUMERIC) AS tottch,
    CAST("STUTERATIO" AS NUMERIC) AS stuteratio,
    "LOCALE_TEXT"::TEXT AS locale_text,
    "CONAME"::TEXT AS coname,
    "COID"::TEXT AS coid,
    "PHONE"::TEXT AS phone,
    CAST("Lat" AS NUMERIC) AS lat,
    CAST("Long" AS NUMERIC) AS long,
    CAST("Shape__Area" AS NUMERIC) AS shape__area,
    CAST("Shape__Length" AS NUMERIC) AS shape__length
FROM {{ source('public', 'school_district_characteristics') }}
