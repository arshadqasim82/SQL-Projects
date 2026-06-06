/*
Most In-Demand Skills for Software and Machine Learning Engineers in the UK
Objective:
This analysis identifies the top 10 most in-demand technical skills for Software Engineers and Machine Learning Engineers in the United Kingdom.
Approach:
- Filter job postings for Software Engineer and Machine Learning Engineer roles
- Focus on UK-based job listings
- Join job postings with associated skills data
- Aggregate skill frequency to measure demand
*/

SELECT sd.skills,COUNT(jpf.*) AS demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
  ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim AS sd
  ON sjd.skill_id = sd.skill_id
WHERE
  (jpf.job_title_short='Software Engineer' OR jpf.job_title_short='Machine Learning Engineer')
  AND jpf.job_location='United Kingdom'
GROUP BY
  sd.skills
ORDER BY
  demand_count DESC
LIMIT 10;

/*
Result:
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ python     │          432 │
│ sql        │          191 │
│ aws        │          181 │
│ c++        │          138 │
│ azure      │          112 │
│ pytorch    │          111 │
│ tensorflow │          100 │
│ gcp        │           94 │
│ kubernetes │           91 │
│ java       │           85 │
└────────────┴──────────────┘
Key Points:
- Python Dominance: Python is the primary requirement, appearing in more than 2x the postings of any other skill.
- Cloud Infrastructure: AWS, Azure, and GCP all appear in the top 10, indicating that cloud proficiency is a core requirement for modern engineering roles.
- Engineering Fundamentals: SQL and C++ remain high priority, highlighting the importance of data management and systems programming alongside AI.
- ML Frameworks: PyTorch and TensorFlow show nearly equal demand, though PyTorch holds a slight lead in this dataset.
- DevOps Integration: The presence of Kubernetes suggests that engineers are increasingly expected to manage deployment and containerization.

Conclusion:
The ideal candidate profile for the UK market is a Python specialist with strong SQL foundations and experience in at least one major cloud ecosystem.
*/
