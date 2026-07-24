WITH deduped AS(
    SELECT 
        order_id,
        order_item_id,
        product_id,
        seller_id,
        CAST(shipping_limit_date AS TIMESTAMP) AS shipping_limit_date,
        CAST(price AS NUMERIC) AS price,
        CAST(freight_value AS NUMERIC) AS freight_value,
        ROW_NUMBER() OVER (PARTITION BY order_id, order_item_id ORDER BY _loaded_at DESC) AS row_num
        FROM {{source('olist', 'raw_order_items')}}
)

SELECT 
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
FROM deduped
WHERE row_num = 1