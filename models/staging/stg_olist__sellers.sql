WITH deduped AS(
    SELECT
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state,
        ROW_NUMBER() OVER(PARTITION BY seller_id ORDER BY _loaded_at DESC) AS row_num
    FROM {{source('olist', 'raw_sellers')}}
)

SELECT 
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM deduped
WHERE row_num = 1 