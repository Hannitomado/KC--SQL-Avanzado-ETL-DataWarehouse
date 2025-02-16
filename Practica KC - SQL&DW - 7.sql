
-- Actualizar el campo billing_account_id 
UPDATE keepcoding.ivr_detail d
SET billing_account_id = COALESCE(lb.billing_account_id, 'UNKNOWN')
FROM (
    SELECT 
        CAST(ivr_id AS STRING) AS ivr_id,
        billing_account_id
    FROM (
        SELECT 
            CAST(ivr_id AS STRING) AS ivr_id, 
            billing_account_id, 
            ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY step_sequence DESC) AS rn
        FROM keepcoding.ivr_steps
        WHERE billing_account_id IS NOT NULL AND billing_account_id != 'UNKNOWN'
    ) t
    WHERE rn = 1
) lb
WHERE CAST(d.calls_ivr_id AS STRING) = lb.ivr_id;
