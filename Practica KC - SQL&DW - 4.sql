-- Genera el campo vdn_aggregation para identificar a clientes

CREATE OR REPLACE TABLE keepcoding.ivr_detail AS
WITH latest_vdn AS (
    SELECT 
        CAST(calls_ivr_id AS STRING) AS calls_ivr_id,
        calls_vdn_label
    FROM keepcoding.ivr_detail
    WHERE calls_vdn_label IS NOT NULL
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_start_date DESC) = 1
),
latest_calls AS (
    SELECT *
    FROM keepcoding.ivr_detail
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_start_date DESC) = 1
)
SELECT 
    d.*, 
    CASE 
        WHEN lv.calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
        WHEN lv.calls_vdn_label LIKE 'TECH%' THEN 'TECH'
        WHEN lv.calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation
FROM latest_calls d
LEFT JOIN latest_vdn lv
ON CAST(d.calls_ivr_id AS STRING) = lv.calls_ivr_id;
