#!/usr/bin/env python
# coding: utf-8

#  # Data Analyst (PROJECT) | SQL Analysis

# In[1]:


import pandas as pd
import sqlite3

df = pd.read_csv('/Users/faribakazi/Downloads/DataAnalyst_fixed.csv')
conn = sqlite3.connect('jobs.db')
df.to_sql('jobs', conn, if_exists='replace', index=False)
print('Done')


# In[2]:


pd.read_sql_query("""
SELECT City, COUNT(*) AS job_count
FROM jobs
GROUP BY City
ORDER BY job_count DESC
LIMIT 10
""", conn)


# In[3]:


pd.read_sql_query("""
SELECT Sector, ROUND(AVG(`Avg Salary`), 0) AS avg_salary, COUNT(*) AS postings
FROM jobs
WHERE `Avg Salary` > 0
GROUP BY Sector
ORDER BY avg_salary DESC
""", conn)


# In[4]:


pd.read_sql_query("""
SELECT 'SQL' AS Skill, SUM(SQL) AS Count FROM jobs
UNION ALL
SELECT 'Excel', SUM(Excel) FROM jobs
UNION ALL
SELECT 'Python', SUM(Python) FROM jobs
UNION ALL
SELECT 'Tableau', SUM(Tableau) FROM jobs
UNION ALL
SELECT 'Power_BI', SUM(`Power BI`) FROM jobs
UNION ALL
SELECT 'R', SUM(R) FROM jobs
ORDER BY Count DESC
""", conn)


# In[5]:


pd.read_sql_query("""
SELECT
  CASE
    WHEN `Job Title` LIKE '%Senior%' THEN 'Senior'
    WHEN `Job Title` LIKE '%Junior%' THEN 'Junior'
    WHEN `Job Title` LIKE '%Lead%' THEN 'Lead'
    ELSE 'Mid-Level'
  END AS Seniority,
  ROUND(AVG(`Avg Salary`), 0) AS avg_salary,
  COUNT(*) AS postings
FROM jobs
GROUP BY Seniority
ORDER BY avg_salary DESC
""", conn)


# In[6]:


queries = """
-- Top 10 cities by number of job postings
SELECT City, COUNT(*) AS job_count
FROM jobs
GROUP BY City
ORDER BY job_count DESC
LIMIT 10;

-- Average salary by sector
SELECT Sector, ROUND(AVG(`Avg Salary`), 0) AS avg_salary, COUNT(*) AS postings
FROM jobs
WHERE `Avg Salary` > 0
GROUP BY Sector
ORDER BY avg_salary DESC;

-- Skill demand ranked
SELECT 'SQL' AS Skill, SUM(SQL) AS Count FROM jobs
UNION ALL
SELECT 'Excel', SUM(Excel) FROM jobs
UNION ALL
SELECT 'Python', SUM(Python) FROM jobs
UNION ALL
SELECT 'Tableau', SUM(Tableau) FROM jobs
UNION ALL
SELECT 'Power_BI', SUM(`Power BI`) FROM jobs
ORDER BY Count DESC;

-- Average salary by seniority
SELECT
  CASE
    WHEN `Job Title` LIKE '%Senior%' THEN 'Senior'
    WHEN `Job Title` LIKE '%Junior%' THEN 'Junior'
    WHEN `Job Title` LIKE '%Lead%' THEN 'Lead'
    ELSE 'Mid-Level'
  END AS Seniority,
  ROUND(AVG(`Avg Salary`), 0) AS avg_salary,
  COUNT(*) AS postings
FROM jobs
GROUP BY Seniority
ORDER BY avg_salary DESC;
"""

with open('analysis_queries.sql', 'w') as f:
    f.write(queries)

print('Saved')

