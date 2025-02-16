-- Crear la tabla ivr_summary
CREATE OR REPLACE TABLE keepcoding.ivr_summary AS
SELECT
    calls_ivr_id AS ivr_id,
    calls_phone_number AS phone_number,
    calls_ivr_result AS ivr_result,
    vdn_aggregation,
    calls_start_date AS start_date,
    calls_end_date AS end_date,
    calls_total_duration AS total_duration,
    calls_customer_segment AS customer_segment,
    calls_ivr_language AS ivr_language,
    COUNT(DISTINCT module_sequece) AS steps_module,
    STRING_AGG(DISTINCT module_name, ', ') AS module_aggregation,
    document_type,
    document_identification,
    customer_phone,
    billing_account_id,
    masiva_lg,
    info_by_phone_lg,
    info_by_dni_lg,
    repeated_phone_24H,
    cause_recall_phone_24H
FROM keepcoding.ivr_detail
GROUP BY 
    calls_ivr_id, calls_phone_number, calls_ivr_result, vdn_aggregation, 
    calls_start_date, calls_end_date, calls_total_duration, 
    calls_customer_segment, calls_ivr_language, document_type, 
    document_identification, customer_phone, billing_account_id, 
    masiva_lg, info_by_phone_lg, info_by_dni_lg, repeated_phone_24H, cause_recall_phone_24H;