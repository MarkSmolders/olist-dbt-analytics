SELECT 
    DC.customer_unique_id,
    MIN(FO.order_purchase_timestamp) AS first_purchase_date,
    MAX(FO.order_purchase_timestamp) AS last_purchase_date,
    COALESCE(SUM(FP.payment_value), 0) AS customer_lifetime_value,
    COUNT(DISTINCT FO.order_id) AS total_orders,
    COALESCE(SUM(FP.payment_value), 0) / COUNT(DISTINCT FO.order_id) AS average_order_value,
    DATE_DIFF(CURRENT_DATE(), CAST(MAX(FO.order_purchase_timestamp) AS DATE), DAY) AS days_since_last_purchase
FROM {{ref('dim_customers')}} AS DC
LEFT JOIN {{ref('fct_orders')}} AS FO ON DC.customer_id = FO.customer_id
LEFT JOIN {{ref('fct_order_payments')}} AS FP ON FO.order_id = FP.order_id
GROUP BY customer_unique_id

