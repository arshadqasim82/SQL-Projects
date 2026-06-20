/*
Highest Paying Skills for Software and Machine Learning Engineers

Objective:
This analysis identifies the top 25 highest paying technical skills globally for Software Engineers and Machine Learning Engineers, filtering for skills with significant market presence.

Approach:
- Filter job postings specifically for Software Engineer and Machine Learning Engineer roles.
- Group the dataset by individual skills and calculate the median average yearly salary.
- Ensure statistical relevance by excluding any skill with 50 or fewer job postings.
- Order the results to highlight the highest premium skills in the market.
*/
SELECT sd.skills,
MEDIAN(jpf.salary_year_avg) as median_salary,
COUNT(jpf.*) AS demand_count
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
  median_salary DESC
LIMIT 25;


/*
Result:
┌─────────────────┬───────────────┬──────────────┐
│     skills      │ median_salary │ demand_count │
│     varchar     │    double     │    int64     │
├─────────────────┼───────────────┼──────────────┤
│ macos           │      250000.0 │          419 │
│ swift           │      250000.0 │         1038 │
│ arch            │      217500.0 │           71 │
│ haskell         │      213000.0 │          119 │
│ notion          │      191500.0 │          308 │
│ redshift        │      190000.0 │         2244 │
│ neo4j           │      187625.0 │          527 │
│ sheets          │      187500.0 │          414 │
│ golang          │      186000.0 │         2951 │
│ dynamodb        │      186000.0 │         1804 │
│ mysql           │      178675.0 │         5643 │
│ splunk          │      177750.0 │         1472 │
│ c               │      176000.0 │         4200 │
│ unify           │      175250.0 │          454 │
│ node            │      174500.0 │         1221 │
│ zoom            │      170000.0 │          504 │
│ ruby on rails   │      170000.0 │          627 │
│ kotlin          │      168000.0 │         1750 │
│ slack           │      167500.0 │         1055 │
│ microsoft teams │      167500.0 │          143 │
│ couchbase       │      166250.0 │          137 │
│ go              │      166000.0 │         9793 │
│ bigquery        │      166000.0 │         2552 │
│ jenkins         │      166000.0 │         6835 │
│ c++             │      166000.0 │         9203 │
└─────────────────┴───────────────┴──────────────┘
Analysis of Results:
- Apple Ecosystem Premium: macos and swift lead the market with a median salary of $250,000. While highly lucrative, their demand pool is significantly smaller than mainstream backend languages.
- Niche Specialisations Pay Disproportionately: Hyper specialized skills like arch and haskell command top tier salaries but offer the lowest job availability on this list.
- The High Demand / High Salary Sweet Spot: Core engineering languages and infrastructure tools offer the best balance of compensation and job security. go,c++ and jenkins all maintain highly competitive median salaries of $166,000 at massive scale.
- Enterprise Integration Roles: The surprising presence of notion, sheets, slack, and zoom with salaries over $167,000 likely points to highpaying enterprise integration engineering building apps, bots, or extensions for these platforms via APIs.
- Cloud Data Warehousing: AWS infrastructure (redshift, dynamodb) and GCP (bigquery) command $166,000–$190,000, underscoring the high value of cloud data storage engineering.

Conclusion:
While specialising in iOS/macOS development or niche functional languages maximizes absolute salary potential, mastering high concurrency backend languages like Go and C++, alongside CI/CD tools like Jenkins, provides the optimal balance of high compensation and abundant job opportunities.
*/