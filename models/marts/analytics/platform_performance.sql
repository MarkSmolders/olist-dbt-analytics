WITH new_customer AS(
    SELECT
        COUNT(customer_unique_id) AS new_customers,
        EXTRACT(YEAR FROM first_purchase_date) AS year,
        EXTRACT(MONTH FROM first_purchase_date) AS month
    FROM {{ref('customer_behaviour')}}
    GROUP BY year, month
)

SELECT 
    DD.year,
    DD.month,
    DD.month_name,
    DD.quarter,
    SUM(FOP.payment_value) AS total_revenue,
    COUNT(DISTINCT FO.order_id) AS total_orders,
    NC.new_customers,
    COUNT(FI.order_item_id) AS items_sold,
    COUNT(DISTINCT CASE WHEN FO.order_status = 'canceled' THEN FO.order_id END) AS cancelled_orders
FROM {{ref('dim_date')}} AS DD
LEFT JOIN {{ref('fct_orders')}} AS FO ON DD.date_id = CAST(FO.order_purchase_timestamp AS DATE)
LEFT JOIN {{ref('fct_order_payments')}} AS FOP ON FO.order_id = FOP.order_id
LEFT JOIN new_customer AS NC ON DD.year = NC.year AND DD.month = NC.month
LEFT JOIN {{ref('fct_order_items')}} AS FI ON FOP.order_id = FI.order_id
GROUP BY DD.year, DD.month, DD.month_name, DD.quarter, NC.new_customers
ORDER BY DD.year, DD.month