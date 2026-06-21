-- command to run this file 
--duckdb dw_marts.duckdb -c 'build_marts.sql'

-- build tables
.read create_tables.sql
-- load data onto tables
.read load_schema.sql 
-- creating flat mart
.read create_flat_mart.sql
-- creating skills mart
.read create_skills_mart.sql
-- creating priority mart
.read create_priority_mart.sql
-- updating priority mart
.read update_priority_mart.sql
-- create company mart
.read create_company_mart.sql