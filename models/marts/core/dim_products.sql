SELECT 
    pr.product_id,
    tr.product_category_name_english,
    pr.product_name_length,
    pr.product_description_length,
    pr.product_photos_qty,
    pr.product_weight_g,
    pr.product_length_cm,
    pr.product_height_cm,
    pr.product_width_cm
FROM {{ ref('stg_olist__products') }} AS pr
LEFT JOIN {{ ref('stg_olist__product_category_name_translation')}} AS tr ON pr.product_category_name = tr.product_category_name