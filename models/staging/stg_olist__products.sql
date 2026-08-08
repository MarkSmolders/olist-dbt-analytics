WITH deduped AS(
    SELECT 
        product_id,
        product_category_name,
        product_name_lenght AS product_name_length,
        product_description_lenght AS product_description_length,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY _loaded_at DESC) AS row_num
    FROM {{source('olist', 'raw_products')}} 
)

SELECT 
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM deduped
WHERE row_num = 1
    


