USE job_market_analysis;

-- Create job_skills table
DROP TABLE IF EXISTS job_skills;

CREATE TABLE job_skills (
  job_id INT,
  skill VARCHAR(255)
);

-- Insert normalized skills
INSERT INTO job_skills (job_id, skill)
SELECT job_id, TRIM(skill_1) FROM jobs_filtered WHERE skill_1 IS NOT NULL AND TRIM(skill_1) <> ''
UNION ALL
SELECT job_id, TRIM(skill_2) FROM jobs_filtered WHERE skill_2 IS NOT NULL AND TRIM(skill_2) <> ''
UNION ALL
SELECT job_id, TRIM(skill_3) FROM jobs_filtered WHERE skill_3 IS NOT NULL AND TRIM(skill_3) <> ''
UNION ALL
SELECT job_id, TRIM(skill_4) FROM jobs_filtered WHERE skill_4 IS NOT NULL AND TRIM(skill_4) <> ''
UNION ALL
SELECT job_id, TRIM(skill_5) FROM jobs_filtered WHERE skill_5 IS NOT NULL AND TRIM(skill_5) <> ''
UNION ALL
SELECT job_id, TRIM(skill_6) FROM jobs_filtered WHERE skill_6 IS NOT NULL AND TRIM(skill_6) <> ''
UNION ALL
SELECT job_id, TRIM(skill_7) FROM jobs_filtered WHERE skill_7 IS NOT NULL AND TRIM(skill_7) <> ''
UNION ALL
SELECT job_id, TRIM(skill_8) FROM jobs_filtered WHERE skill_8 IS NOT NULL AND TRIM(skill_8) <> '';

-- Clean skills
ALTER TABLE job_skills
ADD COLUMN skill_clean VARCHAR(255);

UPDATE job_skills
SET skill_clean = LOWER(TRIM(skill));

-- Create fact tables for Power BI
DROP TABLE IF EXISTS fact_jobs;
CREATE TABLE fact_jobs AS
SELECT 
  job_id,
  Title,
  Company,
  Dept,
  location,
  exp_min,
  exp_max,
  salary_mid
FROM jobs_filtered;

DROP TABLE IF EXISTS fact_job_skills;
CREATE TABLE fact_job_skills AS
SELECT job_id, skill_clean
FROM job_skills;

SET SQL_SAFE_UPDATES = 1;
