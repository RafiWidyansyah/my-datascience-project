-- highest_donation_assignments
SELECT a.assignment_name,
	   a.region,
	   ROUND(SUM(d1.amount),2) AS rounded_total_donation_amount,
	   d2.donor_type
FROM donations AS d1
JOIN assignments AS a
ON d1.assignment_id = a.assignment_id
JOIN donors AS d2
ON d1.donor_id = d2.donor_id
GROUP BY a.assignment_name, a.region, d2.donor_type
ORDER BY rounded_total_donation_amount DESC
LIMIT 5;

-- top_regional_impact_assignments

-- CTE total number of donation received for each assignment
WITH no_of_donations AS (
	SELECT assignment_id,
		   COUNT(donation_id) AS num_total_donations
	FROM donations
	GROUP BY assignment_id
),
-- CTE ranked assignments
ranked_assignments AS ( 
	SELECT a.assignment_name,
		   a.region,
		   a.impact_score,
		   nd.num_total_donations,
		   ROW_NUMBER() OVER (PARTITION BY a.region ORDER BY a.impact_score DESC) AS rank_in_region
	FROM assignments AS a
	JOIN no_of_donations AS nd
	ON a.assignment_id = nd.assignment_id
	WHERE nd.num_total_donations > 0
)

SELECT assignment_name,
	   region,
	   impact_score,
	   num_total_donations
FROM ranked_assignments
WHERE rank_in_region = 1
ORDER BY region ASC;
