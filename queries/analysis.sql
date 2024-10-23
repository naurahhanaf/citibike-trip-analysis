--analyze the data for 2017 only
SELECT
  *
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  EXTRACT(YEAR FROM starttime) = 2017
ORDER BY 
  starttime ASC;


--DATA CLEANING
--1) Remove duplicates
--2) Handling missing values
SELECT DISTINCT
  *
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  EXTRACT(YEAR FROM starttime) = 2017
ORDER BY 
  starttime ASC;

--3) Check the column
-- tripduration must be less than 24 hour
SELECT DISTINCT
  *
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  EXTRACT(YEAR FROM starttime) = 2017
ORDER BY 
  starttime ASC;

-- check gender column
SELECT DISTINCT
  gender,
  COUNT(*) AS number_of_trips
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  EXTRACT(YEAR FROM starttime) = 2017
GROUP BY
  gender
ORDER BY 
  number_of_trips ASC;
-- because there is "unknown", so we must filter it

-- check usertype colum (must be Customer and Suscriber only)
SELECT DISTINCT
  usertype,
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
  usertype
ORDER BY 
  number_of_trips ASC;


--EXPLORATORY DATA ANALYSIS (EDA)
--analysis descriptive for age
SELECT DISTINCT
  AVG(EXTRACT(YEAR FROM starttime) - birth_year) AS mean_age,
  MIN(EXTRACT(YEAR FROM starttime) - birth_year) AS max_age,
  MAX(EXTRACT(YEAR FROM starttime) - birth_year) AS min_age,
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  gender != 'unknown' AND 
  EXTRACT(YEAR FROM starttime) = 2017;

--count number_of_trips for each age
SELECT DISTINCT
  EXTRACT(YEAR FROM starttime) - birth_year AS age,
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
  age
ORDER BY 
  age ASC;

--grouping the age so we can easily know the number_of_trips
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
  age_group
ORDER BY 
  age_group ASC;

--analysis descriptive for age by gender
SELECT DISTINCT
  gender,
  AVG(EXTRACT(YEAR FROM starttime) - birth_year) AS mean_age,
  MIN(EXTRACT(YEAR FROM starttime) - birth_year) AS max_age,
  MAX(EXTRACT(YEAR FROM starttime) - birth_year) AS min_age,
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  gender != 'unknown' AND 
  EXTRACT(YEAR FROM starttime) = 2017
GROUP BY
  gender;

--count total number of trips by gender and usertype
SELECT DISTINCT
  usertype,
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
  usertype, gender;

--analysis descriptive for trip duration in minutes by usertype
SELECT DISTINCT
  usertype,
  AVG(tripduration/60) AS trip_mean,
  MIN(tripduration/60) AS trip_min,
  MAX(tripduration/60) AS trip_max,
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <= 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  gender != 'unknown' AND
  EXTRACT(YEAR FROM starttime) = 2017
GROUP BY
  usertype;

--count the average trip duration by usertype and gender
SELECT DISTINCT
  usertype,
  gender,
  AVG(tripduration/60) AS trip_mean,
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

--analyze the average trip duration for usertype by day of week
SELECT DISTINCT
  usertype,
  EXTRACT(DAYOFWEEK FROM starttime) AS day_order,
  FORMAT_TIMESTAMP('%A', starttime) AS day_of_week,
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
