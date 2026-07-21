WITH deduped AS(
    SELECT
        order_id,
        customer_id,
        order_status,
        CAST(order_purchase_timestamp AS TIMESTAMP) AS order_purchase_timestamp,
        CAST(order_approved_at AS TIMESTAMP) AS order_approved_at,
        CAST(order_delivered_carrier_date AS TIMESTAMP) AS order_delivered_carrier_date,
        CAST(order_delivered_customer_date AS TIMESTAMP) AS order_delivered_customer_date,
        CAST(order_estimated_delivery_date AS TIMESTAMP) AS order_estimated_delivery_date,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY _loaded_at DESC) AS row_num
    FROM {{ source('olist', 'raw_orders') }}
)

SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM deduped
WHERE row_num = 1