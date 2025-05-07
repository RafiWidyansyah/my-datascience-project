-- Average Final Exam Score by Study Hours and Extracurricular Activities --
SELECT
	hours_studied,
	AVG(exam_score) AS avg_exam_score
FROM student_performance
WHERE hours_studied > 10 AND CAST(extracurricular_activities AS BOOLEAN) = TRUE
GROUP BY hours_studied
ORDER BY hours_studied DESC;

-- Average Final Exam Score by Range of Study Hours --
SELECT
	    CASE WHEN hours_studied >= 1 AND hours_studied <= 5 THEN '1-5 hours'
		  WHEN hours_studied >= 6 AND hours_studied <= 10 THEN '6-10 hours'
		  WHEN hours_studied >= 11 AND hours_studied <= 15 THEN '11-15 hours'
		  ELSE '16+ hours' END AS hours_studied_range,
	 AVG(exam_score) AS avg_exam_score
FROM student_performance
GROUP BY hours_studied_range
ORDER BY avg_exam_score DESC;

-- Rank of Students' Final Exam Score --
SELECT
	 attendance,
	 hours_studied,
	 sleep_hours,
	 tutoring_sessions,
	 DENSE_RANK() OVER(ORDER BY exam_score DESC) AS exam_rank
FROM student_performance
ORDER BY exam_rank ASC
LIMIT 30; -- List Top 30 students 
