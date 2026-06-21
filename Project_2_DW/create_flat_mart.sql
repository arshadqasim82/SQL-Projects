DROP SCHEMA IF EXISTS flat_mart CASCADE;
CREATE SCHEMA flat_mart;

CREATE TABLE flat_mart.job_postings (
    job_id INTEGER PRIMARY KEY,
    job_title_short VARCHAR,
    job_title VARCHAR,
    job_location VARCHAR,
    job_via VARCHAR,
    job_schedule_type VARCHAR,
    job_work_from_home BOOLEAN,
    search_location VARCHAR,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country VARCHAR,
    salary_rate VARCHAR,
    salary_year_avg DOUBLE,
    salary_hour_avg DOUBLE,
    company_id INTEGER,
    company_name VARCHAR,
    skills_and_types STRUCT(
        type VARCHAR,
        name VARCHAR
    )[]
);

INSERT INTO flat_mart.job_postings (
    job_id,
    job_title_short,
    job_title,
    job_location,
    job_via,
    job_schedule_type,
    job_work_from_home,
    search_location,
    job_posted_date,
    job_no_degree_mention,
    job_health_insurance,
    job_country,
    salary_rate,
    salary_year_avg,
    salary_hour_avg,
    company_id,
    company_name,
    skills_and_types
)


SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.company_id,
    cd.name AS company_name,
    ARRAY_AGG(
      STRUCT_PACK(
        type := sd.type,
        name := sd.skills
      )
    ) AS skills_and_types
FROM
    job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
    LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
GROUP BY ALL;

-- Verify flat mart was created
SELECT 'Flat Mart Job Postings' AS table_name, COUNT(*) as record_count FROM flat_mart.job_postings;
-- Show sample data
SELECT 'Flat Mart Sample' AS info;
SELECT 
    job_id,
    company_name,
    job_title_short,
    job_location,
    job_country,
    salary_year_avg,
    job_work_from_home,
    skills_and_types
FROM flat_mart.job_postings 
LIMIT 10;