{{ config(materialized='table') }}

WITH date_spine AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="CAST('2015-01-01' AS DATE)",
        end_date="CAST('2019-12-31' AS DATE)"
    ) }}
),

final AS (
    SELECT
        CAST(date_day AS DATE) AS date_id,
        EXTRACT(YEAR FROM date_day) AS year,
        EXTRACT(MONTH FROM date_day) AS month,
        FORMAT_DATE('%B', date_day) AS month_name,
        EXTRACT(QUARTER FROM date_day) AS quarter,
        EXTRACT(DAYOFWEEK FROM date_day) AS day_of_week,
        FORMAT_DATE('%A', date_day) AS day_name,
        CASE WHEN EXTRACT(DAYOFWEEK FROM date_day) IN (1, 7) THEN TRUE ELSE FALSE END AS is_weekend
    FROM date_spine
)

SELECT * FROM final

# Big query uses 1 for Sunday and 7 for Saturday