-- models/staging/stg_district_funding.sql

{{ config(
    materialized='view'
) }}

SELECT
    "SVY_COMP"::TEXT AS svy_comp,
    "GOVTYPE"::TEXT AS govtype,
    "AGG_DESC_LABEL"::TEXT AS agg_desc_label,
    "AGG_DESC"::TEXT AS agg_desc,
    "FINSRC"::TEXT AS finsrc,
    "ENROLLSZE"::TEXT AS enrollsze,
    "NAME"::TEXT AS name,
    "EXPENDTYPE"::TEXT AS expendtype,
    CAST("AMOUNT_PUPIL" AS NUMERIC) AS amount_pupil,
    CAST("AMOUNT" AS NUMERIC) AS amount,
    CAST("AMOUNT_CHANGE" AS NUMERIC) AS amount_change,
    "YEAR"::TEXT AS year,
    "time"::TEXT AS time,
    "state"::TEXT AS state,
    "school district (unified)"::TEXT AS school_district_unified
FROM {{ source('public', 'district_funding') }}
