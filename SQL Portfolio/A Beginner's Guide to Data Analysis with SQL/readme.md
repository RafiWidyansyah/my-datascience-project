## Key session takeaways

* Learn the basics of SQL & why it's foundational for data science work.
* Filter, group by, and analyse datasets using SQL.
* Answer key business questions with SQL

## The Dataset 

The dataset to be used in this training is a CSV file named `airbnb_data.csv`, which contains data on airbnb listings in the state of New York. It contains the following columns:

* `listing_id`: The unique identifier for a listing 
* `description`: The description used on the listing 
* `host_id`: Unique identifier for a host 
* `neighbourhood_full`: Name of boroughs and neighbourhoods 
* `coordinates`: Coordinates of listing (latitude, longitude) 
* `listing_added`: Date of added listing 
* `room_type`: Type of room 
* `rating`: Rating from 0 to 5. 
* `price`: Price per night for listing 
* `number_of_reviews`: Amount of reviews received 
* `reviews_per_month`: Number of reviews per month 
* `availability_365`: Number of days available per year 
* `number_of_stays`: Total number of stays thus far

## Questions to answer 

* **Question 1**: List the top 10 most reviewed private rooms
* **Question 2**: What are the cheapest 10 private rooms in New York?
* **Question 3**: What is the average availability of a private room in New York?
* **Question 4**: Which listings have an availability of fewer than 30 days a year but have fewer than 10 reviews?
* **Question 5**: What is the average number of reviews per room type, ordered by the average in descending order?
* **Question 6**: What is the number and average price of listings by room type where such listings are available for more than 250 days a year?
