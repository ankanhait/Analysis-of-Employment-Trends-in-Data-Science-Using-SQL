select* from job_details;

#1> What is the distribution of employee?
select work_year,count(*) as total_no_of_jobs_yearly
from job_details
group by work_year;


#2> Find the total no of job posting based on job category

select job_category,count(*) as total_no_of_jobs
from job_details
group by job_category;

#3> Find the top 5 average salaries job based on  job category.

select job_category,round(avg(salary),0) as avg_salary
from job_details
group by job_category
limit 5;


#4> What is the distribution of job postings across different experience levels?

SELECT  experience_level, ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM  job_details
GROUP BY  experience_level;


#5> Trend of maximum salaries in USD over the years.

select work_year,max(salary_in_usd) as max_usd_salaries
from job_details
group by work_year;

#6> What are the preferred work settings based on the no of job postings.

select work_setting,count(*) as no_of_jobs
from job_details
group by work_setting;

#7> What is the distribution of job postings based on company size.

select company_size,count(*) as no_of_jobs
from job_details
group by company_size;

#8> Identify the job title with the highest salary in each job category.

with ranked_jobs as (select job_category,job_title,salary,row_number() over (partition by job_category order by salary desc) as rn
    from job_details)
select job_category,job_title,salary
from ranked_jobs
where rn = 1;

#9> Find the top 5 company locations offering the highest average salaries for the position of 'Data Scientist'.

select company_location,round(avg(salary), 2) as highest_average_salaries
from job_details
where lower(job_title) = 'data scientist'
group by company_location
order by highest_average_salaries desc
limit 5;


