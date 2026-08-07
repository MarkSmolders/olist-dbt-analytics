# **Architectural Decisions**

This document covers key design decisions made in the creation of this project and the reasoning behind them.

---
### ELT over ETL
ELT was chosen over ETL since it was a large dataset and storing the raw data directly into the datawarehouse and querying it from there is cheaper and faster. This reduces infrastructure cost  and saves data team time by keeping all transformation logic in one place.

---
### Why dbt
dbt was chosen as the core tool of this project because of its software engineering practices. Combining SQL transformations with version controlling, testing, documentation and modular code are all greatly beneficial to the quality, consistency and readability of the code.

---
### Code specific decisions
- **Data types (TIMESTAMP and INT64)** — BigQuery requires explicit casting since CSV files load all columns as STRING by default. Timestamp columns were cast to TIMESTAMP and numeric columns to INT64 or NUMERIC where needed for correct aggregation and date calculations.

- **Deduplication using PARTITION BY DESC** — raw tables can contain duplicates due to the incremental loading simulation. Staging models deduplicate by partitioning on the primary key and ordering by _loaded_at DESC to keep the most recently loaded row.

- **Geolocation has no primary key** — multiple coordinate pairs exist per zip code prefix. One representative row per zip code was kept using deduplication. This is documented as a known limitation.

- **Null values in product dimension** — physical measurement columns like weight and dimensions have significant nulls as sellers do not always provide this information. These were kept as null rather than filtered out since null is a valid state.

- **Product category relationship test set to warn** — two category names (pc_gamer and portateis_cozinha_e_preparadores_de_alimentos) are missing from the translation table. The test is set to warn rather than error since this is a source data gap, not a modelling error.

- **Thin facts and dimensions** — fact and dimension tables are kept close to staging with minimal transformation. Business logic and joins are pushed to analytical marts to keep the core layer stable and reusable.

- **Hardcoded date bounds in dim_date** — the date spine covers 2015 to 2019 to fully cover the Olist dataset range with a one year buffer on each side. In production this would be derived dynamically from the data.

- **Single seller per order in delivery_performance** — orders with multiple sellers are represented by the seller with the latest shipping limit date, as this seller is most likely the delivery bottleneck. This is an approximation documented as a known limitation.
