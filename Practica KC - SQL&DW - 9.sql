-- Crear el campo flag info_by_phone_lg 
CREATE OR REPLACE TABLE keepcoding.ivr_detail AS
WITH flagged_calls AS (
    SELECT DISTINCT 
        CAST(ivr_id AS STRING) AS calls_ivr_id,
        1 AS info_by_phone_lg
    FROM keepcoding.ivr_steps
    WHERE step_name = 'CUSTOMERINFOBYPHONE.TX'
    AND step_result = 'OK'
)
SELECT 
    d.*,
    COALESCE(f.info_by_phone_lg, 0) AS info_by_phone_lg
FROM keepcoding.ivr_detail d
LEFT JOIN flagged_calls f
ON CAST(d.calls_ivr_id AS STRING) = f.calls_ivr_id;
