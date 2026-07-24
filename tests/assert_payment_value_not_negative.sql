SELECT payment_value
FROM {{ ref('stg_olist__order_payments') }}
WHERE payment_value < 0