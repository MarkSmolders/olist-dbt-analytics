# **Olist Analytics Engineering Project**

## Project Overview
This project demonstrates an end-to-end ELT analytics engineering pipeline using the [Olist Brazilian E-Commerce Kaggle Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). 
This dataset has information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil.
The raw data is extracted and loaded into BigQuery with an extraction.py script, it is then transformed and modelled using dbt. 
This project includes automated data quality tests, full column-level documentation, and data lineage tracking.
Multiple marts have been created ready for business analysis.
This project contrasts the traditional ETL approach by loading the raw data directly into the data warehouse and performing the transformation within the cloud.

## Author
**Mark Smolders**  
[LinkedIn](https://www.linkedin.com/in/mark-smolders-231077159/) | [GitHub](https://github.com/MarkSmolders)