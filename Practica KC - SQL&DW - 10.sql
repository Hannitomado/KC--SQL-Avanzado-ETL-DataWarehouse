-- Crear columna info_by_dni_lg
ALTER TABLE keepcoding.ivr_detail
ADD COLUMN info_by_dni_lg INT64;

-- Poblar la columna y generar su flag
UPDATE keepcoding.ivr_detail d
SET info_by_dni_lg = 
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM keepcoding.ivr_steps s
            WHERE s.ivr_id = d.calls_ivr_id
            AND s.step_name = 'CUSTOMERINFOBYDNI.TX'
            AND s.step_result = 'OK'
        ) THEN 1
        ELSE 0
    END
WHERE d.calls_ivr_id IS NOT NULL;