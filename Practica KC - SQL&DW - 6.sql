-- Actualizar el campo customer_phone 
UPDATE keepcoding.ivr_detail d
SET customer_phone = COALESCE(lp.customer_phone, 'UNKNOWN')
FROM (
    SELECT 
        CAST(ivr_id AS STRING) AS ivr_id,
        customer_phone
    FROM (
        SELECT 
            CAST(ivr_id AS STRING) AS ivr_id, 
            customer_phone, 
            ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY step_sequence DESC) AS rn
        FROM keepcoding.ivr_steps
        WHERE customer_phone IS NOT NULL AND customer_phone != 'UNKNOWN'
    ) t
    WHERE rn = 1
) lp
WHERE CAST(d.calls_ivr_id AS STRING) = lp.ivr_id;

