WITH deduped AS (
    SELECT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY _loaded_at DESC) AS row_num
    FROM {{ source('olist', 'raw_customers') }}
)

SELECT 
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM deduped
WHERE row_num = 1 