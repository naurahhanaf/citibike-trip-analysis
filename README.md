# Citibike User Demographics by Trip in 2017
This repository contains an analysis of user demographics and trip behaviors of Citibike users in New York City for the year 2017. This project is part of a portfolio aimed at showcasing skills in data exploration, cleaning, analysis, and visualization with SQL and BI tools.

## Repository Structure
```graphql
citibike-trip-analysis/
│
├── queries/
│   ├── dataset.sql           # SQL file to query the full dataset for Looker Studio
│   └── analysis.sql          # SQL file containing data cleaning and EDA queries
│
├── report/
│   ├── analysis_report.md    # Documentation of analysis and insights from the EDA
│   └── visualization.png     # Screenshot of Looker Studio visualization report
│
└── README.md                 # Project overview and guide
```

## Project Overview
This project aims to analyze Citibike trip data to understand the demographic characteristics of its users based on the number of trips taken. 

## Dataset
* **Source:** [New York City Bike](https://console.cloud.google.com/bigquery?project=bigquery-public-data&p=bigquery-public-data&d=new_york_citibike&t=citibike_trips&page=table) dataset on BigQuery
* **Description:** The dataset contains information about individual bike trips, including start time, end time, start station, end station, bike id, user type, gender, birth year, and more. The analysis focuses on the year 2017.

## Tools Used
* **SQL (BigQuery):** For data exploration, cleaning, and analysis.
* **Looker Studio:** For data visualization and reporting.

## Outcome
Developed an analytic report featuring visualizations that highlight key insights on user demographics and trip behavior, providing actionable insights for stakeholders.

## Key Insights
The analysis provided insights into:
1. User Demographics: Breakdown of user types, age, and gender distribution.
2. Trip Pattern: Analysis of trip durations and total number of trips taken by users.

## Report and Visualization
![image](https://github.com/user-attachments/assets/646a9125-eb99-43ec-9451-8dd71bcc286b)

For a comprehensive view of the analysis and visual insights, please refer to the Looker Studio report [here](https://lookerstudio.google.com/s/hIg4Hdu6-fs).

## Summary
- Subscribers (annual members) dominate Citibike usage, with males representing the majority of users.
- The average trip duration for Customers (24-hour or 7-day pass users) tends to be longer than that for Subscribers, suggesting that occasional users or tourists may be using Citibike for leisure or exploration.
- Subscribers typically use the service for shorter trips, possibly related to daily commuting or routine travel.
