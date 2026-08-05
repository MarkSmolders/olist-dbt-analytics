SELECT
    FOI.order_id,
    FOI.order_item_id,
    FOI.product_id,
    FOI.seller_id,
    DS.seller_city,
    DS.seller_state,
    FOI.price,
    FOI.freight_value,
    DP.delivery_delay_days,
    FR.review_score
FROM {{ref('fct_order_items')}} AS FOI
LEFT JOIN {{ref('delivery_performance')}} AS DP ON FOI.order_id = DP.order_id
LEFT JOIN {{ref('fct_order_reviews')}} AS FR ON FOI.order_id = FR.order_id
LEFT JOIN {{ref('dim_sellers')}} AS DS ON FOI.seller_id = DS.seller_id
