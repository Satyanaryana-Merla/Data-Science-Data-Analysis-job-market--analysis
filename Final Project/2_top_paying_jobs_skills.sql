/*
 Using query no. 1 to show the skills required for these roles. 
*/


WITH top_paying_jobs AS(
SELECT 
    job_id,
    job_location, 
    job_title_short,
    salary_year_avg,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_location = 'Anywhere' AND 
    job_title_short = 'Data Scientist' AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON 
    top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON 
    skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg
LIMIT 20;