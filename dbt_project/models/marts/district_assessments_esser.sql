{{ config(materialized='view') }}

WITH source_data AS (
    SELECT
        LPAD("state", 2, '0') || LPAD("school_district_unified", 5, '0') AS LEAID1,
        "name",
        "agg_desc_label",
        "amount"
    FROM {{ ref('stg_district_funding') }}
),
pivoted_data AS (
    SELECT
        LEAID1,
        name,
        MAX(CASE WHEN agg_desc_label = 'Total expenditure' THEN amount END) AS total_expenditure,
        MAX(CASE WHEN agg_desc_label = 'Total revenue' THEN amount END) AS total_revenue,
        MAX(CASE WHEN agg_desc_label = 'Total current spending' THEN amount END) AS total_current_spending,
        MAX(CASE WHEN agg_desc_label = 'Total revenue from federal sources' THEN amount END) AS total_revenue_from_federal_sources,
        MAX(CASE WHEN agg_desc_label = 'Total revenue from local sources' THEN amount END) AS total_revenue_from_local_sources,
        MAX(CASE WHEN agg_desc_label = 'Total revenue from state sources' THEN amount END) AS total_revenue_from_state_sources
    FROM source_data
    GROUP BY LEAID1, name
),
characteristics AS (
    SELECT
        *
    FROM {{ ref('stg_school_district_characteristic') }}
),
esser_cares AS (
    SELECT
        nces_number,
        esser1_sea_reserve_awarded,
        esser1_sea_reserve_expended_prior,
        esser1_sea_reserve_expended_current,
        esser1_sea_reserve_remaining,
        esser1_mandatory_subgrant_awarded,
        esser1_mandatory_expended_prior,
        esser1_mandatory_expended_current,
        esser1_mandatory_remaining
    FROM {{ ref('stg_esser_cares') }}
    WHERE is_lea = True
),
esser_crssa AS (
    SELECT
        nces_number,
        esser2_sea_reserve_awarded,
        esser2_sea_reserve_expended_prior,
        esser2_sea_reserve_expended_current,
        esser2_sea_reserve_remaining,
        esser2_mandatory_subgrant_awarded,
        esser2_mandatory_expended_prior,
        esser2_mandatory_expended_current,
        esser2_mandatory_remaining
    FROM {{ ref('stg_esser_crrsa') }}
    WHERE is_lea = True
),
esser_arp AS (
    SELECT
        nces_number,
        esser3_sea_reserve_total_awarded,
        esser3_sea_reserve_total_expended_current,
        esser3_sea_reserve_lost_time_awarded,
        esser3_sea_reserve_summer_awarded,
        esser3_sea_reserve_aft_sch_awarded,
        esser3_sea_reserve_other_awarded,
        esser3_sea_reserve_other_expended_current,
        esser3_sea_reserve_remaining,
        esser3_mandatory_subgrant_awarded,
        esser3_mandatory_expended_prior,
        esser3_mandatory_expended_current,
        esser3_mandatory_remaining
    FROM {{ ref('stg_esser_arp') }}
    WHERE is_lea = True
),
assessments AS (
    SELECT
        LPAD(leaid::TEXT, 7, '0') AS leaid_7,
        leaid_num,
        read_test_pct_prof_low,
        read_test_pct_prof_high,
        read_test_pct_prof_midpt,
        math_test_num_valid,
        math_test_pct_prof_low,
        math_test_pct_prof_high,
        math_test_pct_prof_midpt
    FROM {{ ref('stg_district_assessment') }}
    ) 


SELECT
    pivot.*,
    char.*,
    cares.esser1_sea_reserve_awarded,
    cares.esser1_sea_reserve_expended_prior,
    cares.esser1_sea_reserve_expended_current,
    cares.esser1_sea_reserve_remaining,
    cares.esser1_mandatory_subgrant_awarded,
    cares.esser1_mandatory_expended_prior,
    cares.esser1_mandatory_expended_current,
    cares.esser1_mandatory_remaining,
    crssa.esser2_sea_reserve_awarded,
    crssa.esser2_sea_reserve_expended_prior,
    crssa.esser2_sea_reserve_expended_current,
    crssa.esser2_sea_reserve_remaining,
    crssa.esser2_mandatory_subgrant_awarded,
    crssa.esser2_mandatory_expended_prior,
    crssa.esser2_mandatory_expended_current,
    crssa.esser2_mandatory_remaining,
    arp.esser3_sea_reserve_total_awarded,
    arp.esser3_sea_reserve_total_expended_current,
    arp.esser3_sea_reserve_lost_time_awarded,
    arp.esser3_sea_reserve_summer_awarded,
    arp.esser3_sea_reserve_aft_sch_awarded,
    arp.esser3_sea_reserve_other_awarded,
    arp.esser3_sea_reserve_other_expended_current,
    arp.esser3_sea_reserve_remaining,
    arp.esser3_mandatory_subgrant_awarded,
    arp.esser3_mandatory_expended_prior,
    arp.esser3_mandatory_expended_current,
    arp.esser3_mandatory_remaining,
    a.read_test_pct_prof_low,
    a.read_test_pct_prof_high,
    a.read_test_pct_prof_midpt,
    a.math_test_num_valid,
    a.math_test_pct_prof_low,
    a.math_test_pct_prof_high,
    a.math_test_pct_prof_midpt,
    -- New column: Combined Test Score Proficiency Level
    CASE 
        WHEN a.read_test_pct_prof_midpt IS NOT NULL AND a.math_test_pct_prof_midpt IS NOT NULL THEN 
            (a.read_test_pct_prof_midpt + a.math_test_pct_prof_midpt) / 2
        WHEN a.read_test_pct_prof_midpt IS NOT NULL THEN 
            a.read_test_pct_prof_midpt
        WHEN a.math_test_pct_prof_midpt IS NOT NULL THEN 
            a.math_test_pct_prof_midpt
        ELSE NULL
    END AS combined_test_score_prof,
    (
    -- New Column: Total Mandatory Remaining
    COALESCE(cares.esser1_mandatory_remaining, 0) + 
    COALESCE(crssa.esser2_mandatory_remaining, 0) + 
    COALESCE(arp.esser3_mandatory_remaining, 0)
     )
      AS total_mandatory_remaining
    
FROM pivoted_data pivot
LEFT JOIN characteristics char
    ON pivot.LEAID1 = char.leaid
LEFT JOIN esser_cares cares
    ON pivot.LEAID1 = cares.nces_number
LEFT JOIN esser_crssa crssa
    ON pivot.LEAID1 = crssa.nces_number
LEFT JOIN esser_arp arp
    ON pivot.LEAID1 = arp.nces_number
LEFT JOIN assessments a
    ON pivot.LEAID1 = a.leaid_7

