/* 
- Showing the top 10 highest-paying Data Scientist roles that are available in Egypt. 
- Focusing on job_postings that specify salaries (ignoring ones that has null values as salaries). 
- Extra: Showing the name of the company. 
*/ 

SELECT 
    job_id,
    job_title,
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
LIMIT 10;
