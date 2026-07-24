WITH deduped AS (
    SELECT
        order_id,
        CAST(payment_sequential AS INT64) AS payment_sequential,
        payment_type,
        CAST(payment_installments AS INT64) AS payment_installments,
        CAST(payment_value AS NUMERIC) AS payment_value,
        ROW_NUMBER() OVER(PARTITION BY order_id, payment_sequential ORDER BY _loaded_at DESC) AS row_num
    FROM {{source('olist', 'raw_order_payments')}}
)

SELECT 
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM deduped
WHERE row_num = 1 