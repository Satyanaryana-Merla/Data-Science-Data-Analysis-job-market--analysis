# Introduction 

Dive into the exciting world of the data job market with me! This project focuses on Data Scientist roles, unveiling insights into top-paying positions, In-demand skills, and where high demand meets high salaries.

Curious to see the queries? [Check them out here](/Final%20Project/)

**Note** : 

I tried to work on this project to cover inisghts about the Egyptian Job market, but unfortunatley the Egyptian market data was too limited. So I decided to go with remote Data Scientist jobs. 

# Why this Project?

This project is the final project of Luke Barousse's SQL course, aiming to uncover insights about Egypt's data job market using real-world data provided by Luke. The dataset provides valuable information on job titles, salaries, locations, and essential skills.

### Question I answered through the queries: 
1. What are the top paying remote data jobs?
2. What are the top paying skills associated with the data scientist role?
3. What are the top demanded skills for Data Scientist role?
4. What are the skills associated with the highest salaries?
5. What are the optimal skills to learn?

# Tools Used 
For my analysis, I used various tools, some of which were new experiences:

- **SQL** : Serving as the cornerstone of my analysis, SQL enabled me to query the database and unveil these valuable insights.

- **PostgreSQL** : Selected as the database management system to efficiently handle and store the data.

- **Visual Studio Code**: The integrated development environment where I executed my queries and conducted analysis.

- **Git & GitHub** : Utilized for version control and sharing my queries, fostering collaboration and facilitating project management.

# What I learned
- **Complex Query Writing** : I mastered query writing, merging tables using different types of joins and writing complex CTEs.

- **Data Aggregation** : Got better using GROUP BY statements and summarizing data using aggregate functions like COUNT() and AVG().

- **Analytical Skills** : Sharpened my real-world problem solving by turning questions into actionable SQL queries to uncover needed insights.

# The Analysis
The main goal of these queries is to uncover certain insights about the Data Scientist roles. So let's have a deeper dive on how I approached each question and what are the uncovered inisghts.

## 1. Top Paying Data Jobs
To identify the highest paying Data Science jobs, I filtered the data by the average salary and location focusing on jobs in Egypt.

```sql
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
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here's a breakdown of the findings: 

- **Wide Salary Range** : The first 10 results shows that the average salaries for the Data Scientist role range from 300,000$ to 550,000$ per year. Which indicates a significant variability in compensation for this roles that is likely influeced by the level of experience, industry and job titles.

- **Diversity of Employers** : The results shows that there's a diversity in employers in different industries such as Reddit, Teramind, Lawrence Harvey, etc. Which indicates that this role is sought after accross different industries such as Technology, Healtcare and retail.

- **Variety of Job Titles** : The results shows a variety in job titles, which indicates the breadth of roles and responsibilities in the field and suggests that the Data Scientist role requires a wide  range of skills and expertise that suits different organizational needs and objectives.

## 2. Needed Skills for the top paying jobs
To know what are the required skills needed for the Data Scientist role in Egypt, I joined the job postings table with the skills data table providing insights into what skills the employers value the most. 

``` sql
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
LIMIT 10
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
```

Here's a breakdown of the most demanded skills in the top 20 jobs: 
- **SQL**: SQL is leading with a count of 5
- **Python** : Python follows  closely at number two with a count of 4. 
- **R**:  R comes in third place with a count of 3. 

## 3. Top In-Demanded Skills for Data Scientist roles
The aim of this query is to focus on the skills most demanded in job postings. I tackled this query in 2 different ways, I'll go here with the easiest one, if you want to see the other one [you'll find it here](/Final%20Project/3_top_demanded_skills.sql).

``` sql
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
```

And here's a breakdown of the findings: 

| Skills  | Demand Count |
|---------|--------------|
| python  | 10390        |
| sql     | 7488         |
| r       | 4674         |
| aws     | 2593         |
| tableau | 2458         |

*The top 5 demanded skills for Data Scientist Jobs*

- **Python** & **SQL** are the fundemental skills for any Data job in any market with more than 10,000 and 7,000 job postings respectively. 
- Followed by **R** & **AWS** and visulization tools such as **Tableau** which are less important, however they're listed in some job postings and 

## 4. Salaries Based on Skills

In this query I explored the average salary for each skills. 

``` sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) as salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    salary_avg DESC;
```
Here's a breakdown of the results for top paying skills for Data Scientist roles: 

- **High Demand for Specialized Skills** : Skills such as GDPR, Golang, Atlassian, Selenium, and OpenCV command high salaries, which reflects the industry's need for specialized expertise in those certain skills.

- **Emerging Technologies** : Emerging technologies like Neo4j, MicroStrategy, DynamoDB, and DataRobot are also highly valued, which indicates a growing demand for skills in graph databases, business intelligence, NoSQL databases, and automated machine learning.


- **Programming Languages** : Proficiency in programming languages such as PHP, Solidity, C, Go, Julia, and Rust is rewarded with competitive salaries, highlighting the importance of software development skills in data analytics roles.

- **Cloud and Analytics Platforms** : Familiarity with cloud platforms like Watson, Cassandra, and Elixir, as well as analytics tools like Qlik and Looker, is associated with above-average salaries, emphasizing the significance of cloud computing and data visualization skills in the data analytics field.

| Skill       | Average Salary |
|-------------|----------------|
| GDPR        | $217,738       |
| Golang      | $208,750       |
| Atlassian   | $189,700       |
| Selenium    | $180,000       |
| OpenCV      | $172,500       |
| Neo4j       | $171,655       |
| MicroStrategy | $171,147     |
| DynamoDB    | $169,670       |
| PHP         | $168,125       |
| Tidyverse   | $165,513       |

*Top paying skills and their average salaries*

## 5. Optimal Skills to Learn
Combining insights from demand and salaries data (queries 3 & 4) to uncover insights about the optimal skills to learn (high demand & high pay)

(I tackled this query with 3 different ways, I'll show the simplest one, but if you're curious about the other 2, please have a look [Here](/Final%20Project/5_optimal_skills.sql).)

``` sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS demand_count,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.skill_id) > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;
```
| skill ID | Skills       | Demand Count | Avg Salary |
|----------|--------------|--------------|------------|
| 1        | python       | 4312         | 138,049    |
| 0        | sql          | 3151         | 138,430    |
| 5        | r            | 2486         | 135,165    |
| 182      | tableau      | 1278         | 131,636    |
| 76       | aws          | 1016         | 138,861    |
| 92       | spark        | 946          | 144,399    |
| 99       | tensorflow   | 641          | 143,440    |
| 74       | azure        | 623          | 132,897    |
| 181      | excel        | 617          | 124,593    |
| 186      | sas          | 615          | 122,910    |

*The most optimal skills for a Data Scientist to learn, sorted by demand count*

Here's a breakdown of the findings: 

- **High-Demand Programming Languages** : Python and R emerge as the top languages, with Python leading with a demand count of 4,312 and R following closely behind with 2,486. Despite their high demand, their average salaries are around $138,049 for Python and $135,165 for R, which indicates that proficiency in these languages is highly sought after but also relatively well-compensated.

- **Cloud Tools and Technologies** : Specialized technologies such as Tableau, AWS, Spark, and TensorFlow exhibit significant demand, with Tableau leading at 1,278 and AWS following with 1,016. These skills command relatively high average salaries, ranging from $131,636 for Tableau to $144,399 for Spark, reflecting the increasing importance of cloud platforms and big data technologies in data analysis.

- **Business Intelligence and Visualization Tools** : Tableau stands out as the primary tool in this category, with a demand count of 1,278 and an average salary of $131,636. This highlights the critical role of data visualization and business intelligence tools in deriving actionable insights from data.

- **Database Technologies** : Proficiency in database technologies such as SQL (demand count of 3,151) and Excel (demand count of 617) remains crucial for data scientist. These skills are fundamental for data storage, retrieval, and management, and they typically command average salaries ranging from $124,593 for Excel to $138,430 for SQL.

# Conclusion

### Final Insights from the analysis:
1. **Top Paying Data Science Jobs** : The top paying Data Scientist Jobs offers a wide range of salaries, with the highest at 550,000$ per year.
2. **Top Paying Skills** : High paying Data Scientist roles requires proficency in SQL, Python and R. 
3. **In-demand Skills** : Python, SQL and R are also the most in-demand skills for a Data Scientist role, followed by cloud technologies such as AWS and Visualization tools such as Tableau.
4. **Skills with highest salaries** : Specialized salaries such as GDPR, Golang, Atlassian, Selenium, and OpenCV command high salaries which indicates the industries needs for specialized expertise in those skills.
5. **Optimal Skills to Learn** : SQL & Python leads the market demand along with high salaries, which indicates that these are the most optimal skills in the Data market to learn, followed by R, AWS and Tableau.
