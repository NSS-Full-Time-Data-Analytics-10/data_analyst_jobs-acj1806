-- 1.	How many rows are in the data_analyst_jobs table? 1793

SELECT COUNT(*)
FROM data_analyst_jobs;

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row? 		ExxonMobil

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky? 		21/27

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location ILIKE 'KY';

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location IN  ('TN', 'KY');

-- 4.	How many postings in Tennessee have a star rating above 4? 		3

SELECT *
FROM data_analyst_jobs
WHERE location ILIKE 'TN' AND star_rating > 4;

-- 5.	How many postings in the dataset have a review count between 500 and 1000?		151

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating? 		NE(4.2)

SELECT ROUND(AVG(star_rating), 2) AS avg_rating, location AS state
FROM data_analyst_jobs
WHERE location IS NOT NULL 
	AND location <> 'USA' 
	AND location <> 'Remote'
GROUP BY location
ORDER BY avg_rating DESC NULLS LAST;

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?		881

SELECT DISTINCT title
FROM data_analyst_jobs;

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

-- 8.	How many unique job titles are there for California companies?		230

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE location ILIKE 'CA';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location ILIKE 'CA';

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?		40

SELECT company, ROUND(AVG(star_rating), 2) as avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY company;

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating? 		6 companies with 4.2 rating

SELECT company, ROUND(AVG(star_rating), 2) as avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC;

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 		774

SELECT COUNT(DISTINCT title) 
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common? 	4/tableau

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%' AND title NOT ILIKE '%analytics%';

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--  - Disregard any postings where the domain is NULL. 
--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
--   - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT COUNT(title) as hard_to_fill, domain, ROUND(AVG(days_since_posting), 0) as avg_days_since_posting
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%' 
	AND domain IS NOT NULL 
	AND days_since_posting > 21
GROUP BY domain
ORDER BY hard_to_fill DESC;


