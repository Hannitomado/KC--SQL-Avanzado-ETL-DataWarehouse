-- Actualizar document_type y document_identification
UPDATE keepcoding.ivr_detail d
SET document_type = COALESCE(ld.document_type, 'UNKNOWN'),
    document_identification = COALESCE(ld.document_identification, 'UNKNOWN')
FROM (
    SELECT 
        CAST(ivr_id AS STRING) AS ivr_id,
        document_type,
        document_identification
    FROM keepcoding.ivr_steps
    WHERE (document_type IS NOT NULL AND document_type != 'UNKNOWN')
       OR (document_identification IS NOT NULL AND document_identification != 'UNKNOWN')
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY step_sequence DESC) = 1
) ld
WHERE CAST(d.calls_ivr_id AS STRING) = ld.ivr_id;
