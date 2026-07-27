WITH deduped AS(
    SELECT
        product_category_name,
        product_category_name_english,
        ROW_NUMBER() OVER(PARTITION BY product_category_name ORDER BY _loaded_at DESC) AS row_num
    FROM {{source('olist', 'raw_product_category_name_translation')}}
)

SELECT 
    product_category_name,
    product_category_name_english
FROM deduped
WHERE row_num = 1