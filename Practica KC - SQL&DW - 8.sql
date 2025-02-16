-- Generamos el campo masiva_lg
ALTER TABLE keepcoding.ivr_detail
ADD COLUMN masiva_lg INT64;

-- Creamos la flag de masiva_lg
UPDATE keepcoding.ivr_detail d
SET masiva_lg = 
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM keepcoding.ivr_modules m
            WHERE m.ivr_id = d.calls_ivr_id 
            AND m.module_name = 'AVERIA_MASIVA'
        ) THEN 1 
        ELSE 0 
    END
WHERE d.calls_ivr_id IS NOT NULL;
