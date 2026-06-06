/*
Identifying the Most Optimal Skills for Software and Machine Learning Engineers
Objective:
This analysis determines the most valuable skills by calculating an optimal score that balances both high market demand and high compensation.

Approach:
- Filter job postings for Software Engineer and Machine Learning Engineer roles.
- Calculate the median salary and total posting count for each skill.
- Apply a natural logarithm to the demand count to normalize the vast differences in posting volume between niche and ubiquitous skills.
- Create an optimal score by multiplying the median salary by the normalized demand count (divided by 1,000,000 for readability).
- Filter out skills with fewer than 50 postings to maintain statistical relevance.
*/
SELECT sd.skills,
MEDIAN(jpf.salary_year_avg) as median_salary,
COUNT(jpf.*) AS demand_count,
ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000,2) AS optimal_score
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
  ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim AS sd
  ON sjd.skill_id = sd.skill_id
WHERE
  (jpf.job_title_short='Software Engineer' OR jpf.job_title_short='Machine Learning Engineer')
  
GROUP BY
  sd.skills
HAVING 
  MEDIAN(jpf.salary_year_avg) IS NOT NULL AND
  COUNT(jpf.*)>50
ORDER BY
  optimal_score DESC
LIMIT 25;

/*
Result:
┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ swift      │      250000.0 │         1038 │             6.9 │          1.74 │
│ gcp        │      165000.0 │        11947 │             9.4 │          1.55 │
│ aws        │     149358.25 │        32630 │            10.4 │          1.55 │
│ mysql      │      178675.0 │         5643 │             8.6 │          1.54 │
│ python     │      140000.0 │        57944 │            11.0 │          1.54 │
│ go         │      166000.0 │         9793 │             9.2 │          1.53 │
│ c++        │      166000.0 │         9203 │             9.1 │          1.52 │
│ macos      │      250000.0 │          419 │             6.0 │          1.51 │
│ java       │      148500.0 │        25186 │            10.1 │           1.5 │
│ golang     │      186000.0 │         2951 │             8.0 │          1.49 │
│ kubernetes │      150000.0 │        18834 │             9.8 │          1.48 │
│ c          │      176000.0 │         4200 │             8.3 │          1.47 │
│ redshift   │      190000.0 │         2244 │             7.7 │          1.47 │
│ jenkins    │      166000.0 │         6835 │             8.8 │          1.47 │
│ airflow    │      165318.0 │         6015 │             8.7 │          1.44 │
│ tensorflow │      150000.0 │        13546 │             9.5 │          1.43 │
│ pytorch    │      150000.0 │        13887 │             9.5 │          1.43 │
│ spark      │      150000.0 │        13813 │             9.5 │          1.43 │
│ docker     │      143000.0 │        18685 │             9.8 │          1.41 │
│ postgresql │      161000.0 │         5713 │             8.7 │          1.39 │
│ dynamodb   │      186000.0 │         1804 │             7.5 │          1.39 │
│ scala      │      155500.0 │         6909 │             8.8 │          1.37 │
│ kafka      │      150000.0 │         9282 │             9.1 │          1.37 │
│ sql        │      130000.0 │        34076 │            10.4 │          1.36 │
│ azure      │      132600.0 │        23733 │            10.1 │          1.34 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
Analysis of Results:
- The Outlier: Swift commands the highest optimal score due to its massive $250,000 median salary, despite having a moderate demand count. The sheer weight of the compensation outweighs the lower job volume in this mathematical model.
- The Big Three Cloud Providers: GCP and AWS tie for the second highest optimal score, proving that cloud infrastructure offers the best realistic intersection of high pay and massive job availability. Azure lags slightly behind, largely due to a lower median salary.
- The Python & SQL Paradox: Python and SQL boast the highest sheer demand by a massive margin (57,944 and 34,076 postings). However, their optimal scores are tempered by their lower median salaries, reflecting their status as ubiquitous baseline requirements rather than premium specialised skills.
- The Power Backend Duo: Go and C++ secure top positions. With identical median salaries and highly comparable demand, they represent the strongest return on investment for backend developers looking for both premium pay and steady hiring volume.

Conclusion:
To maximise both earning potential and hireability, an engineer should focus heavily on cloud infrastructure (specifically AWS or GCP) while building deep expertise in a high performance backend language like Go or C++.
*/