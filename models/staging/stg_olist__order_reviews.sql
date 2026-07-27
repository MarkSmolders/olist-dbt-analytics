WITH deduped AS(
    SELECT
        review_id,
        order_id,
        CAST(review_score AS INT64) AS review_score,
        review_comment_title,
        review_comment_message,
        CAST(review_creation_date AS TIMESTAMP) AS review_creation_date,
        CAST(review_answer_timestamp AS TIMESTAMP) AS review_answer_timestamp,
        ROW_NUMBER() OVER(PARTITION BY review_id ORDER BY _loaded_at DESC) AS row_num
    FROM {{source('olist', 'raw_order_reviews')}}
)

SELECT 
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM deduped
WHERE row_num = 1 