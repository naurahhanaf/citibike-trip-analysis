--data cleaning
--1) Remove duplicates
SELECT DISTINCT
  *
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  EXTRACT(YEAR FROM starttime) = 2017
ORDER BY 
  starttime ASC;

--2) Check the data and handling missing values
--tripduration less than 24 hour
SELECT DISTINCT
  *
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration <
  EXTRACT(YEAR FROM starttime) = 2017
ORDER BY 
  starttime ASC;
