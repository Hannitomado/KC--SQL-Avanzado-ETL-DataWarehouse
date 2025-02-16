-- Crear las columnas repeated_phone_24h y cause_recall_phone_24h
ALTER TABLE keepcoding.ivr_detail
ADD COLUMN repeated_phone_24H INT64,
ADD COLUMN cause_recall_phone_24H INT64;

-- Generar las flag para las columnas, y poblarlas
UPDATE keepcoding.ivr_detail d
SET repeated_phone_24H = 
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM keepcoding.ivr_detail d2
            WHERE d2.calls_phone_number = d.calls_phone_number
            AND d2.calls_start_date BETWEEN TIMESTAMP_SUB(d.calls_start_date, INTERVAL 24 HOUR) 
                                      AND d.calls_start_date
            AND d2.calls_ivr_id != d.calls_ivr_id
        ) THEN 1
        ELSE 0
    END,
    cause_recall_phone_24H = 
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM keepcoding.ivr_detail d3
            WHERE d3.calls_phone_number = d.calls_phone_number
            AND d3.calls_start_date BETWEEN d.calls_start_date 
                                      AND TIMESTAMP_ADD(d.calls_start_date, INTERVAL 24 HOUR)
            AND d3.calls_ivr_id != d.calls_ivr_id
        ) THEN 1
        ELSE 0
    END
WHERE d.calls_phone_number IS NOT NULL;
