-- 1. Check null data in some field --
select *
from salary
where experience_level is null or
employment_type is null or
job_title is null;

-- 2. What kind of jobs that related to "Data Analyst"
select distinct job_title
from salary
where job_title like "%Data Analyst%";

-- 3. Average Salary of Data Analyst
select avg(salary_in_usd) avg_salary
from salary;

-- 4. Average Salary of Data Analyst per each Year
select work_year, avg(salary_in_usd) avg_salary
from salary
group by work_year;

-- 5. Average Salary of Data Analyst Based On Experience Level
SELECT experience_level, AVG(salary_in_usd) avg_salary
FROM salary
GROUP BY experience_level
ORDER BY avg_salary desc;

-- 6. Average Salary of Data Analyst : Employment Type --
select employment_type, avg(salary_in_usd) avg_salary
from salary
group by employment_type
order by avg_salary desc;

-- 7. Countries with Interesting Salary in Data Analyst Work for "Entry Level / Mid Level" Position
select company_location, avg(salary_in_usd) avg_salary
from salary
where job_title like "%Data Analyst%"
	and employment_type = "FT"
    and experience_level in ("EN","MI")
group by company_location
having avg_salary >= 10000
order by avg_salary desc;

-- 8. Increase of Average Salary from Mid-level to Expert --
with sal_avg_exp as (
	select work_year, avg(salary_in_usd) avg_salary_exp
    from salary
    where job_title like "%Data Analyst%"
		and employment_type = "FT"
		and experience_level = "EX"
	group by work_year
), sal_avg_mid as (
	select work_year, avg(salary_in_usd) avg_salary_mid
    from salary
    where job_title like "%Data Analyst%"
		and employment_type = "FT"
        and experience_level = "MI"
	group by work_year
)
select sal_avg_exp.work_year,
	   sal_avg_exp.avg_salary_exp,
       sal_avg_mid.avg_salary_mid,
       sal_avg_exp.avg_salary_exp - sal_avg_mid.avg_salary_mid differences
from sal_avg_exp
left outer join sal_avg_mid
on sal_avg_exp.work_year = sal_avg_mid.work_year
;