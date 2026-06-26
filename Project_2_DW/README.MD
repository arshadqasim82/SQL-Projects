# Data Warehouse & Data Mart Pipeline

An end-to-end SQL data engineering project that extracts raw job posting data, transforms it into a dimensional data warehouse, and creates analytical data marts for reporting and business intelligence.

The project demonstrates practical ETL development, dimensional modelling, and SQL-based data engineering using DuckDB.

---

## Project Overview

The source data consists of multiple CSV files containing job posting information. While suitable for storage, the raw files are difficult to analyse efficiently due to duplicated information and many-to-many relationships.

This project builds a complete analytical pipeline by:

- Loading raw CSV files into DuckDB
- Transforming the data into a star schema
- Creating reusable analytical data marts
- Supporting repeatable pipeline execution through SQL scripts

The result is a structured warehouse that can easily be queried from BI tools or SQL.

---

## Features

- End-to-end ETL pipeline
- Star schema data warehouse
- Fact and dimension tables
- Bridge tables for many-to-many relationships
- Analytical data marts
- Incremental updates using MERGE
- Idempotent SQL scripts
- Automated build script

---

## Tech Stack

| Technology           | Purpose                           |
| -------------------- | --------------------------------- |
| SQL                  | Data transformation and modelling |
| DuckDB               | Data warehouse engine             |
| Google Cloud Storage | Source data storage               |
| Git                  | Version control                   |
| VS Code              | Development                       |

---

## Project Structure

```text
.
├── 01_create_tables_dw.sql
├── 02_load_schema_dw.sql
├── 03_create_flat_mart.sql
├── 04_create_skills_mart.sql
├── 05_create_priority_mart.sql
├── 06_update_priority_mart.sql
├── 07_create_company_mart.sql
├── build_dw_marts.sql
└── README.md
```

---

## Data Pipeline

The pipeline follows a traditional ETL architecture.

```
Raw CSV Files
       │
       ▼
Extract
       │
       ▼
Transform
       │
       ▼
Star Schema Warehouse
       │
       ▼
Analytical Data Marts
       │
       ▼
Reporting / BI Tools
```

The warehouse acts as the single source of truth, while each data mart is designed for a specific analytical purpose.

---

## Warehouse Design

The warehouse follows a star schema consisting of:

- **job_postings_fact**
- **company_dim**
- **skills_dim**
- **skills_job_dim**

The fact table stores individual job postings while dimensions describe companies and required skills. Bridge tables resolve many-to-many relationships.

---

## Data Marts

### Flat Mart

A denormalised table containing commonly joined information for fast exploratory queries.

### Skills Mart

Aggregated skill demand over time, enabling trend analysis and reporting.

### Priority Mart

Tracks priority job postings and demonstrates incremental loading using SQL MERGE statements.

### Company Mart

Aggregates hiring activity by company, role and location for organisational reporting.

---

## SQL Concepts Used

This project includes practical use of:

- CREATE TABLE
- INSERT INTO
- MERGE
- JOINs
- Common Table Expressions (CTEs)
- CASE expressions
- Aggregate functions
- STRING_AGG
- DATE_TRUNC
- Window functions
- Data type conversion
- Schema management

---

## Engineering Practices

The pipeline was designed with production-style practices in mind.

- Repeatable execution
- Idempotent scripts
- Logical schema separation
- Explicit data types
- Modular SQL files
- Incremental update support
- Validation queries throughout the pipeline

---

## Running the Project

Execute the master build script:

```sql
.read build_dw_marts.sql
```

This will:

1. Create the warehouse
2. Load the source data
3. Build each analytical data mart

---

## Skills Demonstrated

- ETL Pipeline Development
- Data Warehousing
- Dimensional Modelling
- SQL Development
- Data Transformation
- Incremental Loading
- Analytical Data Modelling
- Query Optimisation
- Data Engineering Best Practices
