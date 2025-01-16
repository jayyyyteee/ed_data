{{ config(
    materialized='view'
) }}

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
        -- Pivoting each agg_desc_label into separate columns
        MAX(CASE WHEN agg_desc_label = 'Total expenditure' THEN amount END) AS total_expenditure,
        MAX(CASE WHEN agg_desc_label = 'Total revenue' THEN amount END) AS total_revenue,
        MAX(CASE WHEN agg_desc_label = 'Total current spending' THEN amount END) AS total_current_spending,
        MAX(CASE WHEN agg_desc_label = 'Total revenue from federal sources' THEN amount END) AS total_revenue_from_federal_sources,
        MAX(CASE WHEN agg_desc_label = 'Total revenue from local sources' THEN amount END) AS total_revenue_from_local_sources,
        MAX(CASE WHEN agg_desc_label = 'Total revenue from state sources' THEN amount END) AS total_revenue_from_state_sources,
        MAX(CASE WHEN agg_desc_label = 'Current spending - All functions - Employee benefits' THEN amount END) AS current_spending_all_functions_employee_benefits,
        MAX(CASE WHEN agg_desc_label = 'Current spending - All functions - Salaries and wages' THEN amount END) AS current_spending_all_functions_salaries_and_wages,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Instruction - Employee benefits' THEN amount END) AS current_spending_instruction_employee_benefits,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Instruction - Salaries and wages' THEN amount END) AS current_spending_instruction_salaries_and_wages,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Instruction - Total' THEN amount END) AS current_spending_instruction_total,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Other current spending' THEN amount END) AS current_spending_other_current_spending,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Support services - General administration' THEN amount END) AS current_spending_support_services_general_administration,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Support services - Instructional staff support services' THEN amount END) AS current_spending_support_services_instructional_staff_support_services,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Support services - Other and nonspecified support services' THEN amount END) AS current_spending_support_services_other_and_nonspecified_support_services,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Support services - Pupil support services' THEN amount END) AS current_spending_support_services_pupil_support_services,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Support services - School administration' THEN amount END) AS current_spending_support_services_school_administration,
        MAX(CASE WHEN agg_desc_label = 'Current spending - Support services - Total' THEN amount END) AS current_spending_support_services_total,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - All functions - Employee benefits' THEN amount END) AS current_spending_per_pupil_all_functions_employee_benefits,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - All functions - Salaries and wages' THEN amount END) AS current_spending_per_pupil_all_functions_salaries_and_wages,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Instruction - Employee benefits' THEN amount END) AS current_spending_per_pupil_instruction_employee_benefits,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Instruction - Salaries and wages' THEN amount END) AS current_spending_per_pupil_instruction_salaries_and_wages,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Instruction - Total' THEN amount END) AS current_spending_per_pupil_instruction_total,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Support services - General administration' THEN amount END) AS current_spending_per_pupil_support_services_general_administration,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Support services - Instructional staff support' THEN amount END) AS current_spending_per_pupil_support_services_instructional_staff_support,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Support services - Pupil support services' THEN amount END) AS current_spending_per_pupil_support_services_pupil_support_services,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Support services - School administration' THEN amount END) AS current_spending_per_pupil_support_services_school_administration,
        MAX(CASE WHEN agg_desc_label = 'Current spending per pupil - Support services - Total' THEN amount END) AS current_spending_per_pupil_support_services_total,
        MAX(CASE WHEN agg_desc_label = 'Revenue from federal sources - Distributed through the state - Child nutrition' THEN amount END) AS revenue_federal_sources_child_nutrition,
        MAX(CASE WHEN agg_desc_label = 'Revenue from federal sources - Distributed through the state - Other and nonspecified' THEN amount END) AS revenue_federal_sources_other_and_nonspecified,
        MAX(CASE WHEN agg_desc_label = 'Revenue from federal sources - Distributed through the state - Special Education' THEN amount END) AS revenue_federal_sources_special_education,
        MAX(CASE WHEN agg_desc_label = 'Revenue from federal sources - Distributed through the state - Title I' THEN amount END) AS revenue_federal_sources_title_i,
        MAX(CASE WHEN agg_desc_label = 'Revenue from local sources - Current charges' THEN amount END) AS revenue_local_sources_current_charges,
        MAX(CASE WHEN agg_desc_label = 'Revenue from local sources - Other local revenue' THEN amount END) AS revenue_local_sources_other_local_revenue,
        MAX(CASE WHEN agg_desc_label = 'Revenue from local sources - Parent government contributions' THEN amount END) AS revenue_local_sources_parent_government_contributions,
        MAX(CASE WHEN agg_desc_label = 'Revenue from local sources - Property taxes' THEN amount END) AS revenue_local_sources_property_taxes,
        MAX(CASE WHEN agg_desc_label = 'Revenue from local sources - Revenue from cities and counties' THEN amount END) AS revenue_local_sources_revenue_from_cities_and_counties,
        MAX(CASE WHEN agg_desc_label = 'Revenue from local sources - Revenue from other school systems' THEN amount END) AS revenue_local_sources_revenue_from_other_school_systems,
        MAX(CASE WHEN agg_desc_label = 'Revenue from local sources - Total taxes' THEN amount END) AS revenue_local_sources_total_taxes,
        MAX(CASE WHEN agg_desc_label = 'Revenue from state sources - General formula assistance' THEN amount END) AS revenue_state_sources_general_formula_assistance,
        MAX(CASE WHEN agg_desc_label = 'Revenue from state sources - Other and nonspecified state aid' THEN amount END) AS revenue_state_sources_other_and_nonspecified_state_aid,
        MAX(CASE WHEN agg_desc_label = 'Revenue from state sources - Special education' THEN amount END) AS revenue_state_sources_special_education,
        MAX(CASE WHEN agg_desc_label = 'Revenue from state sources - Transportation programs' THEN amount END) AS revenue_state_sources_transportation_programs
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
        esser1_mandatory_expended_current
    FROM {{ref ('stg_esser_cares')}}
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
        esser2_mandatory_expended_current
    FROM {{ref ('stg_esser_crrsa')}}
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
    FROM {{ref ('stg_esser_arp')}}
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
    crssa.esser2_sea_reserve_awarded,
    crssa.esser2_sea_reserve_expended_prior,
    crssa.esser2_sea_reserve_expended_current,
    crssa.esser2_sea_reserve_remaining,
    crssa.esser2_mandatory_subgrant_awarded,
    crssa.esser2_mandatory_expended_prior,
    crssa.esser2_mandatory_expended_current,
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
    arp.esser3_mandatory_remaining
FROM pivoted_data pivot
LEFT JOIN characteristics char
    ON pivot.LEAID1 = char.leaid
LEFT JOIN esser_cares cares
    ON pivot.LEAID1 = cares.nces_number
LEFT JOIN esser_crssa crssa
    ON pivot.LEAID1 = crssa.nces_number
LEFT JOIN esser_arp arp
    ON pivot.LEAID1 = arp.nces_number

