SELECT 
    DP.product_id,
    DP.product_category_name_english,
    DP.product_name_length,
    DP.product_description_length,
    DP.product_photos_qty,
    DP.product_weight_g,
    DP.product_length_cm,
    DP.product_height_cm,
    ROUND(AVG(FR.review_score), 1) AS average_review_score,
    COUNT(FR.review_score) AS total_reviews,
    SUM(FO.price) AS total_revenue,
    COUNT(DISTINCT FO.order_id) AS total_orders,
    COUNT(FO.order_item_id) AS total_units_sold
FROM {{ref('dim_products')}} AS DP
LEFT JOIN {{ref('fct_order_items')}} AS FO ON DP.product_id = FO.product_id
LEFT JOIN {{ref('fct_order_reviews')}} AS FR ON FO.order_id = FR.order_id
GROUP BY 
    DP.product_id,
    DP.product_category_name_english,
    DP.product_name_length,
    DP.product_description_length,
    DP.product_photos_qty,
    DP.product_weight_g,
    DP.product_length_cm,
    DP.product_height_cm