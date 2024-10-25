# Citibike User Demographics Analysis by Trip in 2017

## Analysis in SQL BigQuery
**1. Age Distribution by Trip**
```sql
SELECT DISTINCT
  CASE
    WHEN EXTRACT(YEAR FROM starttime) - birth_year BETWEEN 16 AND 24 THEN '16-24'
    WHEN EXTRACT(YEAR FROM starttime) - birth_year BETWEEN 25 AND 34 THEN '25-34'
    WHEN EXTRACT(YEAR FROM starttime) - birth_year BETWEEN 35 AND 44 THEN '35-44'
    WHEN EXTRACT(YEAR FROM starttime) - birth_year BETWEEN 45 AND 54 THEN '45-54'
    WHEN EXTRACT(YEAR FROM starttime) - birth_year BETWEEN 55 AND 64 THEN '55-64'
    WHEN EXTRACT(YEAR FROM starttime) - birth_year BETWEEN 65 AND 80 THEN '65-79'
    ELSE '80+' 
  END AS age_group,
  gender,
  COUNT(*) AS number_of_trips
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  gender != 'unknown' AND 
  EXTRACT(YEAR FROM starttime) = 2017
GROUP BY
  age_group, gender
ORDER BY 
  age_group ASC;
```
![image](https://github.com/user-attachments/assets/26397aa0-9c1c-42fe-8b8e-f37764f00d6e)

**2. Average Trips by Riders or User Type**
```sql
SELECT DISTINCT
  usertype,
  gender,
  AVG(tripduration/60) AS trip_mean, --in minute 
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  gender != 'unknown' AND
  EXTRACT(YEAR FROM starttime) = 2017
GROUP BY
  usertype, gender;
```
![image](https://github.com/user-attachments/assets/bed8b79f-86c1-4d26-9b10-fd02b85e2f4b)

**3. Trip Duration of Riders per Day**
```sql
SELECT DISTINCT
  usertype,
  EXTRACT(DAYOFWEEK FROM starttime) AS day_order,
  FORMAT_TIMESTAMP('%A', starttime) AS day_of_week, --Sunday, Monday, etc
  AVG(tripduration / 60) AS trip_mean
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL
  AND birth_year IS NOT NULL
  AND gender != 'unknown'
  AND EXTRACT(YEAR FROM starttime) = 2017
GROUP BY 
  usertype, day_order, day_of_week
ORDER BY 
  day_order ASC; 
```
![image](https://github.com/user-attachments/assets/6253bc92-67b6-4b11-9fc8-cb8235309baa)

## Visualization in Looker Studio
**1. Age Distribution by Trip**

![image](https://github.com/user-attachments/assets/eee87e06-2ee9-46db-9c63-b6966d349657)

**2. Average Trips by Riders or User Type**

![image](https://github.com/user-attachments/assets/7dd6727f-ac67-4ac8-8254-7b97a6eeb905)

**3. Trip Duration of Riders per Day**

![image](https://github.com/user-attachments/assets/d1471b51-20cb-40e9-84b6-662b4b84b7fc)

## Conclution
1. Dominance of Subscribers
- Subscribers significantly dominate the total number of trips compared to Customers (occasional users or tourists). There are around 12.2 million trips by subscribers, compared to 305.6 thousand trips by customers.
- In terms of gender, male subscribers far exceed female subscribers (approximately 9.3 million trips for males and 3.2 million for females).

2. Age Distribution of Riders
- The majority of trips are made by users aged 25-34 years, followed by those aged 35-44 years.
- Most users in the 25-34 and 35-44 age groups are male.
- Female users are more common in younger age groups, but they still represent a smaller proportion compared to males in all age categories.

3. Average Trip Duration by Gender and User Type
- Female customers have a longer average trip duration (28.6 minutes) compared to male customers (27 minutes).
- Subscribers tend to have shorter average trip durations. Female subscribers ride for an average of 14.3 minutes, slightly longer than male subscribers, who average 12.4 minutes.

4. Trip Duration by Day
- The average trip duration for Customers is consistently higher than that for Subscribers across all days of the week.
- Customer trip durations remain relatively stable throughout the week, peaking from Tuesday to Friday.
- Subscribers have the shortest trip duration on Saturdays, with the highest durations recorded during weekdays (Monday to Friday).
