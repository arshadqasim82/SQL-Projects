 Select jpf.*,cd.*
 From job_postings_fact as jpf
 LEFT JOIN company_dim as cd
    ON jpf.company_id = cd.company_id
Limit 10; 

 Select jpf.*,cd.*
 From job_postings_fact as jpf
 RIGHT JOIN company_dim as cd
    ON jpf.company_id = cd.company_id
 Limit 10; 

  Select jpf.*,cd.*
 From job_postings_fact as jpf
 INNER JOIN company_dim as cd
    ON jpf.company_id = cd.company_id
 Limit 10; 

 Select jpf.*,cd.*
 From job_postings_fact as jpf
 FULL OUTER JOIN company_dim as cd
    ON jpf.company_id = cd.company_id
 Limit 10; 