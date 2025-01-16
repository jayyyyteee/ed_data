{{ config(
    materialized='view'
) }}

SELECT
    "leaid"::TEXT AS leaid,
    "leaid_num"::INT AS leaid_num,
    "year"::INT AS year,
    "lea_name"::TEXT AS lea_name,
    "fips"::INT AS fips,
    "grade_edfacts"::INT AS grade_edfacts,
    "race"::INT AS race,
    "sex"::INT AS sex,
    "lep"::INT AS lep,
    "homeless"::INT AS homeless,
    "migrant"::INT AS migrant,
    "disability"::INT AS disability,
    "foster_care"::INT AS foster_care,
    "military_connected"::INT AS military_connected,
    "econ_disadvantaged"::INT AS econ_disadvantaged,
    "read_test_num_valid"::INT AS read_test_num_valid,
    CAST("read_test_pct_prof_low" AS NUMERIC) AS read_test_pct_prof_low,
    CAST("read_test_pct_prof_high" AS NUMERIC) AS read_test_pct_prof_high,
    CAST("read_test_pct_prof_midpt" AS NUMERIC) AS read_test_pct_prof_midpt,
    "math_test_num_valid"::INT AS math_test_num_valid,
    CAST("math_test_pct_prof_low" AS NUMERIC) AS math_test_pct_prof_low,
    CAST("math_test_pct_prof_high" AS NUMERIC) AS math_test_pct_prof_high,
    CAST("math_test_pct_prof_midpt" AS NUMERIC) AS math_test_pct_prof_midpt
FROM {{ source('public', 'district_assessment_results') }}
