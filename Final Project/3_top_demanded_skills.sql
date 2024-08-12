/* 
    - Identifying the top 5 in-demand skills for the Data Scientist role in Egypt.
    - Focusing on all job postings
    - This question could be answered by 2 methods. 
*/

-- Method 1: 


SELECT 
    skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON 
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere'
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;

----------------------------------------------------------

-- Method 2: Using a CTE
WITH skills_demand AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS job_skills
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = job_skills.job_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location = 'Egypt'
    GROUP BY skill_id
)

SELECT
    skills AS skill_name,
    skill_count
FROM 
    skills_demand
INNER JOIN 
    skills_dim AS skills ON skills.skill_id = skills_demand.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5;