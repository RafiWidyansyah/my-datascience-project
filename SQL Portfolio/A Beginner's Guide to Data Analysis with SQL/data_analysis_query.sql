-- List the top 10 most reviewed private rooms
SELECT *
FROM 'airbnb_data.csv'
WHERE room_type == 'Private Room'
ORDER BY reviews_per_month DESC
LIMIT 10;

-- List the top 10 cheapest private rooms in New York
SELECT *
FROM 'airbnb_data.csv'
WHERE room_type == 'Private Room'
ORDER BY price ASC
LIMIT 10;

-- What is the average availability of a private room in New York?
SELECT AVG(availability_365) AS 'Average Availability'
FROM 'airbnb_data.csv'
WHERE room_type == 'Private Room';

-- Which listings have an availability of fewer than 30 days a year but have fewer than 10 reviews?
SELECT listing_id,
	     description,
	     availability_365,
	     number_of_reviews
FROM 'airbnb_data.csv'
WHERE availability_365 < 30 
      AND number_of_reviews < 10
ORDER BY availability_365 DESC;

-- What is the average number of reviews per room type, ordered by the average in ascending order?
SELECT room_type,
	   AVG(number_of_reviews) AS avg_reviews 
FROM 'airbnb_data.csv'
GROUP BY room_type
ORDER BY avg_reviews DESC;

-- What is the average price of listings by room type where such listings are available for more than 250 days a year? 
SELECT room_type,
	   AVG(availability_365) AS avg_availibility,
	   COUNT(listing_id) AS number_of_listings
FROM 'airbnb_data.csv'
WHERE availability_365 > 250
GROUP BY room_type
ORDER BY avg_availibility;
