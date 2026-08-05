WITH deduplication AS(
    SELECT
        order_id,
        seller_id,
        shipping_limit_date,
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY shipping_limit_date DESC) AS row_num
    FROM {{ref('fct_order_items')}}
),

one_seller_per_order AS(
    SELECT *
    FROM deduplication
    WHERE row_num = 1
)

SELECT 
    ORD.order_id,
    ORD.customer_id,
    ORD.order_status,
    ORD.order_purchase_timestamp,
    DATE_DIFF(ORD.order_approved_at, ORD.order_purchase_timestamp, MINUTE) AS approval_time_minutes,
    ORD.order_approved_at,
    DATE_DIFF(ORD.order_delivered_carrier_date, ORD.order_purchase_timestamp, DAY) AS fulfillment_days,
    ORD.order_delivered_carrier_date,
    DATE_DIFF(ORD.order_delivered_customer_date, ORD.order_delivered_carrier_date, DAY) AS carrier_delivery_days,
    ORD.order_delivered_customer_date,
    DATE_DIFF(ORD.order_estimated_delivery_date, ORD.order_delivered_customer_date, DAY) AS delivery_delay_days,
    ORD.order_estimated_delivery_date,
    CUS.customer_city,
    SEL.seller_city,
    CUS.customer_state,
    SEL.seller_state
FROM {{ref('fct_orders')}} AS ORD
LEFT JOIN {{ ref('dim_customers') }} AS CUS ON ORD.customer_id = CUS.customer_id
LEFT JOIN one_seller_per_order AS FOI ON ORD.order_id = FOI.order_id
LEFT JOIN {{ref('dim_sellers')}} AS SEL ON SEL.seller_id = FOI.seller_id