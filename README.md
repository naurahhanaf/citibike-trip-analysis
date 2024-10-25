# Citibike User Demographics by Trip in 2017
This repository contains an analysis of user demographics and trip behaviors of Citibike users in New York City for the year 2017. 

## Project Overview
This project is part of a portfolio aimed at showcasing skills in data exploration, cleaning, analysis, and visualization. This project aims to analyze Citibike trip data to understand the demographic characteristics of its users based on the number of trips taken.

## Dataset
* **Source:** New York City Bike dataset on BigQuery
* **Description:** The dataset contains information about individual bike trips, including start time, end time, start station, end station, bike id, user type, gender, birth year, and more. The analysis focuses on the year 2017.

## Tools Used
* **SQL (BigQuery):** For data exploration, cleaning, and analysis.
* **Looker Studio:** For data visualization and reporting.

## Repository Structure
```graphql
citibike-trip-analysis/
│
├── query/
│   ├── dataset.sql           # SQL file to query the full dataset for Looker Studio
│   └── analysis.sql          # SQL file containing data cleaning and EDA queries
│
├── report/
│   ├── analysis_report.md    # Documentation of analysis and insights from the EDA
│   └── visualization.png     # Screenshot of Looker Studio visualization report
│
├── url.txt                   # URL link to the Looker Studio project
└── README.md                 # Project overview and guide
```

## Key Insights
The analysis provided insights into:
1. User Demographics: Breakdown of user types, age, and gender distribution.
2. Trip Pattern: Analysis of trip durations taken by users.

## Report and Visualization
For a comprehensive view of the analysis and visual insights, please refer to the Looker Studio report [here](https://lookerstudio.google.com/s/hIg4Hdu6-fs).
