"""
extraction.py

ELT Extraction Script - Olist Brazilian E-Commerce Dataset
-----------------------------------------------------------
This script extracts data from local CSV files and loads them into
BigQuery as raw tables, following an ELT architecture.

This script extracts all the data from the CSV files located in data/raw and loads them into BigQuery as raw tables.
The format is the following: "raw_(filename).csv". 
This supports both full load and incremental loading via a --limit parameter.
The --limit parameter acts as a watermark for incremental loads. 
This is not necessary for static data but has been done in preparation for handling modular, production ready data.

The incremental load has been simulated by loading half of the data first and then loading everything after the watermark.

Usage:
    Initial load (50%):     python extraction/extraction.py --limit 0.5
    Incremental load (100%): python extraction/extraction.py --limit 1.0

Arguments:
    --limit: float between 0.0 and 1.0, proportion of rows to load (default: 1.0)
"""

import glob
import os
import argparse
import pandas as pd
from datetime import datetime, timezone
from dotenv import load_dotenv
from google.cloud import bigquery


def create_dataset(client: bigquery.Client, dataset_id: str) -> None:
    """
    Creates the BigQuery dataset if it does not already exist.

    Args:
        client: Authenticated BigQuery client
        dataset_id: Full dataset ID in format 'project.dataset'
    """
    dataset = bigquery.Dataset(dataset_id)
    dataset.location = "US"
    client.create_dataset(dataset, exists_ok=True)
    print(f"Dataset ready: {dataset_id}")


def derive_table_name(filepath: str) -> str:
    """
    Derives the BigQuery table name from a CSV filepath.

    Strips the 'olist_' prefix and '_dataset' suffix where present,
    then prepends 'raw_' to standardise all raw table names.

    Examples:
        olist_customers_dataset.csv     -> raw_customers
        olist_orders_dataset.csv        -> raw_orders
        product_category_name_translation.csv -> raw_product_category_name_translation

    Args:
        filepath: Full or relative path to the CSV file

    Returns:
        Standardised BigQuery table name
    """
    filename = os.path.basename(filepath).replace('.csv', '')

    if filename.startswith('olist_'):
        table_name = 'raw_' + filename.replace('olist_', '').replace('_dataset', '')
    else:
        table_name = 'raw_' + filename

    return table_name


def get_watermark(client: bigquery.Client, table_id: str):
    """
    Queries the maximum _loaded_at timestamp from an existing BigQuery table.
    This value is used as the watermark for incremental loading.

    Args:
        client: Authenticated BigQuery client
        table_id: Full table ID in format 'project.dataset.table'

    Returns:
        Maximum _loaded_at timestamp, or None if table is empty
    """
    query = f"SELECT MAX(_loaded_at) as max_loaded_at FROM `{table_id}`"
    result = client.query(query).result()
    return list(result)[0].max_loaded_at


def table_exists(client: bigquery.Client, table_id: str) -> bool:
    """
    Checks whether a table already exists in BigQuery.

    Args:
        client: Authenticated BigQuery client
        table_id: Full table ID in format 'project.dataset.table'

    Returns:
        True if the table exists, False otherwise
    """
    try:
        client.get_table(table_id)
        return True
    except Exception:
        return False


def load_to_bigquery(client: bigquery.Client, df: pd.DataFrame, table_id: str) -> None:
    """
    Loads a pandas DataFrame into a BigQuery table.
    Appends to the table if it already exists.

    Args:
        client: Authenticated BigQuery client
        df: DataFrame to load
        table_id: Full table ID in format 'project.dataset.table'
    """
    job_config = bigquery.LoadJobConfig(
        write_disposition=bigquery.WriteDisposition.WRITE_APPEND
    )
    job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
    job.result()


def process_file(client: bigquery.Client, filepath: str, limit: float) -> None:
    """
    Processes a single CSV file and loads it into BigQuery.

    Reads the file, applies the row limit, adds a _loaded_at timestamp,
    then performs either an initial load or incremental load depending
    on whether the target table already exists in BigQuery.

    Args:
        client: Authenticated BigQuery client
        filepath: Path to the CSV file
        limit: Proportion of rows to consider (0.0 to 1.0)
    """
    df = pd.read_csv(filepath)
    df = df.head(int(len(df) * limit))
    df['_loaded_at'] = datetime.now(timezone.utc)

    table_name = derive_table_name(filepath)
    table_id = f"olist-dbt-analytics.raw.{table_name}"

    if not table_exists(client, table_id):
        load_to_bigquery(client, df, table_id)
        print(f"Initial load  | {table_id} | Rows: {len(df)}")
    else:
        watermark = get_watermark(client, table_id)

        if watermark is None:
            load_to_bigquery(client, df, table_id)
            print(f"Initial load  | {table_id} | Rows: {len(df)}")
        else:
            new_rows = df[df['_loaded_at'] > watermark]

            if len(new_rows) > 0:
                load_to_bigquery(client, new_rows, table_id)
                print(f"Incremental   | {table_id} | New rows: {len(new_rows)}")
            else:
                print(f"No new rows   | {table_id} | Skipped")


def main():
    """
    Main entry point. Parses arguments, initialises BigQuery client,
    creates the raw dataset, and processes all CSV files in data/raw/.
    """
    parser = argparse.ArgumentParser(
        description="Load Olist CSV data into BigQuery with incremental support"
    )
    parser.add_argument(
        '--limit',
        type=float,
        default=1.0,
        help='Proportion of rows to load per file (0.0 to 1.0). Default: 1.0'
    )
    args = parser.parse_args()

    load_dotenv()
    client = bigquery.Client(project="olist-dbt-analytics")

    create_dataset(client, "olist-dbt-analytics.raw")

    files = glob.glob('data/raw/*.csv')

    for file in files:
        process_file(client, file, args.limit)


if __name__ == "__main__":
    main()