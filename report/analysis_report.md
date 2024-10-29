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

**3. Average Trip Duration of Riders per Day**
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

**4. Total Number of Trips by Day**
```sql
SELECT DISTINCT
  usertype,
  EXTRACT(DAYOFWEEK FROM starttime) AS day_order,
  FORMAT_TIMESTAMP('%A', starttime) AS day_of_week, --Sunday, Monday, etc
  COUNT(*) as number_of_trips
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
![image](https://github.com/user-attachments/assets/5b535bed-0472-42e9-b457-1c462d039ae9)

## Visualization in Looker Studio
**1. Age Distribution by Trip**

![image](https://github.com/user-attachments/assets/a537319a-7974-4955-ad62-c41bacd6dfcb)

**2. Average Trips by Riders or User Type**

![image](https://github.com/user-attachments/assets/6ccdfb34-0826-4c51-b834-5b2c688df043)

**3. Average Trip Duration of Riders per Day**

![image](https://github.com/user-attachments/assets/2626d056-345d-42e2-b310-631ca0ca30ee)

**4. Total Number of Trips per Day**

![image](https://github.com/user-attachments/assets/30229952-c5b2-48b4-8ecb-566fab4c88e2)

## Conclution
1. **Dominance of Subscribers**
- Subscribers (annual members) significantly dominate the total number of trips compared to Customers (24-hour or 7-day pass users). There are around 12.2 million trips by subscribers, compared to 305.6 thousand trips by customers.
- In terms of gender, male subscribers far exceed female subscribers (approximately 9.3 million trips for males and 3.2 million for females).

2. **Age Distribution of Riders**
- The majority of trips are made by users aged 25-34 years, followed by those aged 35-44 years.
- Most users in the 25-34 and 35-44 age groups are male.
- Female users are more common in younger age groups, but they still represent a smaller proportion compared to males in all age categories.

3. **Average Trip Duration by Gender and User Type**
- Female customers have a longer average trip duration (28.6 minutes) compared to male customers (27 minutes).
- Subscribers tend to have shorter average trip durations. Female subscribers ride for an average of 14.3 minutes, slightly longer than male subscribers, who average 12.4 minutes.

4. **User Type Trip Pattern per Day**
- The average trip duration for Customers is consistently higher than that for Subscribers across all days of the week.
- Subscribers make up the majority of trips on every day of the week, averaging around 2 million trips on weekdays, with slightly lower numbers on weekends.
