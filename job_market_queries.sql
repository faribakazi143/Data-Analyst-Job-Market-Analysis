-- ============================================================
-- Data Analyst Job Market Analysis — SQL Queries
-- ============================================================

-- 1. Top 10 cities by number of job postings
SELECT City, COUNT(*) AS job_count
FROM jobs
GROUP BY City
ORDER BY job_count DESC
LIMIT 10;

-- 2. Average salary by sector
SELECT Sector,
       ROUND(AVG(`Avg Salary`), 0) AS avg_salary,
       COUNT(*) AS postings
FROM jobs
WHERE `Avg Salary` > 0
GROUP BY Sector
ORDER BY avg_salary DESC;

-- 3. Skill demand: number of postings requiring each skill
SELECT 'SQL'      AS skill, COUNT(CASE WHEN SQL        = 1 THEN 1 END) AS postings FROM jobs
UNION ALL
SELECT 'Excel',           COUNT(CASE WHEN Excel        = 1 THEN 1 END) FROM jobs
UNION ALL
SELECT 'Python',          COUNT(CASE WHEN Python       = 1 THEN 1 END) FROM jobs
UNION ALL
SELECT 'Tableau',         COUNT(CASE WHEN Tableau      = 1 THEN 1 END) FROM jobs
UNION ALL
SELECT 'Power BI',        COUNT(CASE WHEN `Power BI`   = 1 THEN 1 END) FROM jobs
ORDER BY postings DESC;

-- 4. Average salary by seniority level
SELECT
  CASE
    WHEN `Job Title` LIKE '%Senior%' THEN 'Senior'
    WHEN `Job Title` LIKE '%Junior%' THEN 'Junior'
    WHEN `Job Title` LIKE '%Lead%'   THEN 'Lead'
    ELSE 'Mid-Level'
  END AS seniority,
  ROUND(AVG(`Avg Salary`), 0) AS avg_salary,
  COUNT(*) AS postings
FROM jobs
GROUP BY seniority
ORDER BY avg_salary DESC;
