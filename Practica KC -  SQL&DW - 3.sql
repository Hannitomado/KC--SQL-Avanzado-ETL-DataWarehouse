CREATE OR REPLACE TABLE keepcoding.ivr_detail AS
WITH calls AS (
    SELECT
        ivr_id AS calls_ivr_id,
        phone_number AS calls_phone_number,
        ivr_result AS calls_ivr_result,
        vdn_label AS calls_vdn_label,
        start_date AS calls_start_date,
        FORMAT_DATE('%Y%m%d', DATE(start_date)) AS calls_start_date_id,
        end_date AS calls_end_date,
        FORMAT_DATE('%Y%m%d', DATE(end_date)) AS calls_end_date_id,
        total_duration AS calls_total_duration,
        customer_segment AS calls_customer_segment,
        ivr_language AS calls_ivr_language,
        steps_module AS calls_steps_module,
        module_aggregation AS calls_module_aggregation
    FROM keepcoding.ivr_calls
),
modules AS (
    SELECT
        ivr_id,
        module_sequece,
        module_name,
        module_duration,
        module_result
    FROM keepcoding.ivr_modules
),
steps AS (
    SELECT
        ivr_id,
        module_sequece,
        step_sequence,
        step_name,
        step_result,
        step_description_error,
        document_type,
        document_identification,
        customer_phone,
        billing_account_id
    FROM keepcoding.ivr_steps
)
SELECT
    c.calls_ivr_id,
    c.calls_phone_number,
    c.calls_ivr_result,
    c.calls_vdn_label,
    c.calls_start_date,
    c.calls_start_date_id,
    c.calls_end_date,
    c.calls_end_date_id,
    c.calls_total_duration,
    c.calls_customer_segment,
    c.calls_ivr_language,
    c.calls_steps_module,
    c.calls_module_aggregation,
    m.module_sequece,
    m.module_name,
    m.module_duration,
    m.module_result,
    s.step_sequence,
    s.step_name,
    s.step_result,
    s.step_description_error,
    s.document_type,
    s.document_identification,
    s.customer_phone,
    s.billing_account_id
FROM calls c
LEFT JOIN modules m
    ON c.calls_ivr_id = m.ivr_id
LEFT JOIN steps s
    ON c.calls_ivr_id = s.ivr_id AND m.module_sequece = s.module_sequece;
