SELECT 
    DS.seller_id,
    DS.seller_zip_code_prefix,
    DS.seller_city,
    DS.seller_state,
    COUNT(DISTINCT FO.order_id) AS total_orders,
    SUM(FP.payment_value) AS total_payment_value,
    COUNT(FO.order_item_id) AS total_items_sold,
    AVG(FO.freight_value) AS average_freight_value,
    COUNT(CASE WHEN FR.order_status = 'cancelled' THEN FO.order_id END) AS cancelled_orders
FROM {{ref('dim_sellers')}} AS DS
LEFT JOIN {{ref('fct_order_items')}} AS FO ON DS.seller_id = FO.seller_id
LEFT JOIN {{ref('fct_order_payments')}} AS FP ON FO.order_id = FP.order_id
LEFT JOIN {{ref('fct_orders')}} AS FR ON FO.order_id = FR.order_id
GROUP BY DS.seller_id, DS.seller_zip_code_prefix, DS.seller_city, DS.seller_state
