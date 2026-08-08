WITH deduped AS(
    SELECT 
        geolocation_zip_code_prefix,
        geolocation_lat,
        geolocation_lng,
        geolocation_city,
        geolocation_state,
        ROW_NUMBER() OVER (PARTITION BY geolocation_zip_code_prefix ORDER BY _loaded_at DESC) AS row_num
        FROM {{source('olist', 'raw_geolocation')}}
)

SELECT 
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
FROM deduped
WHERE row_num = 1