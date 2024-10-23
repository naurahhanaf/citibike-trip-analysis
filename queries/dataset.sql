-- get the dataset with this query and explore it with looker studio to make data viz or report
SELECT DISTINCT
  *
FROM
  bigquery-public-data.new_york_citibike.citibike_trips
WHERE
  tripduration < 86400 AND
  starttime IS NOT NULL AND
  birth_year IS NOT NULL AND
  gender != 'unknown' AND
  EXTRACT(YEAR FROM starttime) = 2017
ORDER BY 
  starttime ASC;
