-- Clean the data
SELECT
	  id,
	  location,
	  COALESCE(total_rooms :: INTEGER,100) AS total_rooms,
	  staff_count,
	  REPLACE (opening_date :: TEXT,'-','2023') :: INTEGER AS opening_date,
	  REPLACE(REPLACE (target_guests :: TEXT, 'Busniess','Business'),'B.','Business') AS target_guests
FROM
	branch

-- Calculate Average and Maximum Duration for Each Branch and Services
SELECT
	 service_id,
	 branch_id,
	 ROUND(AVG(time_taken), 2) AS avg_time_taken,
	 MAX(time_taken) AS max_time_taken
FROM request
GROUP BY service_id, branch_id

-- Following the results query before, management team want to target improvement in Meal and Laundry service in Europe and Latin America
SELECT
	  s.description,
	  b.id AS id,
	  location,
	  r.id AS request_id,
	  rating
FROM
	request AS r
INNER JOIN service AS s
		 ON r.service_id = s.id
INNER JOIN branch AS b
		 ON r.branch_id = b.id
WHERE (description IN ('Meal', 'Laundry')) AND
	  (location IN ('EMEA', 'LATAM'))

-- Looking for service_id and branch_id with average rating < 4.5
SELECT
	  service_id,
	  branch_id,
	  ROUND(AVG(rating), 2) AS avg_rating
FROM
	request
GROUP BY service_id, branch_id
HAVING ROUND(AVG(rating), 2) < 4.5
