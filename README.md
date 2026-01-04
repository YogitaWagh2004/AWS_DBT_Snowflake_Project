# 🏠 Airbnb End-to-End Data Engineering Project 

## 📋 Overview

This project implements a complete end-to-end data engineering pipeline for Airbnb data using modern cloud technologies. The solution demonstrates best practices in data warehousing, transformation, and analytics using Snowflake, dbt (Data Build Tool), and AWS.

The pipeline processes Airbnb listings, bookings, and hosts data through a medallion architecture (Bronze → Silver → Gold), implementing incremental loading, slowly changing dimensions (SCD Type 2), and creating analytics-ready datasets.

## 🏗️ Architecture

### Data Flow

Source CSV Files

↓

AWS S3

↓

Snowflake (Staging)

↓

Bronze Layer → Silver Layer → Gold Layer



## Technology Stack
   - **Cloud Data Warehouse**: Snowflake
   - **Transformation Layer**: dbt (Data Build Tool)
   - **Cloud Storage**: AWS S3 
   - **Version Control**: Git
   - **Python**: 3.11+

**Key dbt Features**:
   
   - Incremental models
          
   - Snapshots (SCD Type 2)
     
   - Custom macros
     
   - Jinja templating
     
   - Testing and documentation
  
## 📊 Data Model

   ### Medallion Architecture
   
   **🥉 Bronze Layer (Raw Data)**:
   Raw data ingested from staging with minimal transformations:
   
   **bronze_bookings** - Raw booking transactions
   
   **bronze_hosts** - Raw host information
   
   **bronze_listings** - Raw property listings

   **🥈 Silver Layer (Cleaned Data)**:
   Cleaned and standardized data:
   
   **silver_bookings** - Validated booking records
   
   **silver_hosts** - Enhanced host profiles with quality metrics
   
   **silver_listings** - Standardized listing information with price categorization

   **🥇 Gold Layer (Analytics-Ready)**
   Business-ready datasets optimized for analytics:
   
   **obt (One Big Table)** - Denormalized fact table joining bookings, listings, and hosts
   
   **fact** - Fact table for dimensional modeling
   
   -Ephemeral models for intermediate transformations

## Snapshots (SCD Type 2) Slowly Changing Dimensions to track historical changes:
   **dim_bookings** - Historical booking changes
   
   **dim_hosts** - Historical host profile changes
   
   **dim_listings** - Historical listing changes

## 🚀 Getting Started

## Prerequisites
   1. Snowflake Account (will create one if doesn't exist)
   2. Python Environment
       Python 3.11 or higher
       pip or uv package manager
   3. **AWS Account (will create one if doesn't exist)** (for S3 storage)

## Installation
   1. Clone the Repository

       git clone <repository-url>
       cd AWS_DBT_Snowflake
      
   2. Create Virtual Environment

       python -m venv .venv
       .venv\Scripts\Activate.ps1 

   3. Install Dependencies
      
       pip install -r requirements.txt
       pip install -e .

      
      ## Core Dependencies:
        dbt-core>=1.11.2
        dbt-snowflake>=1.11.0
        sqlfmt>=0.0.3
      
  4. Configure Snowflake Connection

      Create ~/.dbt/profiles.yml:

        aws_dbt_snowflake_project:
           outputs:
           dev:
              account: <your-account-identifier>
              database: AIRBNB
              password: <your-password>
              role: ACCOUNTADMIN
              schema: dbt_schema
              threads: 4
              type: snowflake
              user: <your-username>
              warehouse: COMPUTE_WH
          target: dev

  5. Set Up Snowflake Database
      Run the DDL scripts to create tables:
      **Execute DDL/ddl.sql in Snowflake to create staging tables**

  6. Load Source Data
        Load CSV files from SourceData/ to Snowflake staging schema:
             **bookings.csv** → AIRBNB.STAGING.BOOKINGS
             **hosts.csv** → AIRBNB.STAGING.HOSTS
             **listings.csv** → AIRBNB.STAGING.LISTINGS
   
## 🔧 Usage
Running dbt Commands
    1. Test Connection
        cd aws_dbt_snowflake_project
        dbt debug
    2. Install Dependencies
       dbt deps
    3. Run All Models
       dbt run
    4. Run Specific Layer
       dbt run --select bronze.*      -  Run bronze models only
       dbt run --select silver.*      -  Run silver models only
       dbt run --select gold.*        - Run gold models only
    5. Run Tests
       dbt test
    6. Run Snapshots 
       dbt snapshot
    7. Generate Documentation
       dbt docs generate
       dbt docs serve
    8. Build Everything
        dbt build  **Runs models, tests, and snapshots**


## 🎯 Key Features

### 1. Incremental Loading: 
   Bronze and silver models use incremental materialization to process only new/changed data:
          {{ config(materialized='incremental') }}
          {% if is_incremental() %}
                WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
          {% endif %}

## 2. Custom Macros
Reusable business logic:

- tag() macro: Categorizes prices into 'low', 'medium', 'hig

     {{ tag('CAST(PRICE_PER_NIGHT AS INT)') }} AS PRICE_PER_NIGHT_TAG

## 3. Dynamic SQL Generation
The OBT (One Big Table) model uses Jinja loops for maintainable joins:
     {% set configs = [...] %}
      SELECT {% for config in configs %}...{% endfor %}

## 4. Slowly Changing Dimensions
Track historical changes with timestamp-based snapshots:
Valid from/to dates automatically maintained
Historical data preserved for point-in-time analysis

## 5. Schema Organization
Automatic schema separation by layer:
    Bronze models → AIRBNB.BRONZE.*
    Silver models → AIRBNB.SILVER.*
    Gold models → AIRBNB.GOLD.*

## 📈 Data Quality

**Testing Strategy**
    Source data validation tests
    Unique key constraints
    Not null checks
    Referential integrity tests
    Custom business rule tests
    
## Data Lineage
dbt automatically tracks data lineage, showing:

   Upstream dependencies
   Downstream impacts
   Model relationships
   Source to consumption flow

## 🔐 Security & Best Practices
   1. Credentials Management
       Never commit profiles.yml with credentials
       Use environment variables for sensitive data
       Implement role-based access control (RBAC) in Snowflake
   2. Code Quality
      SQL formatting with sqlfmt
      Version control with Git
      Code reviews for model changes

   3. Performance Optimization
      Incremental models for large datasets
      Ephemeral models for intermediate transformations
      Appropriate clustering keys in Snowflake

## 🤝 Contributing
   1. Fork the repository
   2. Create a feature branch (git checkout -b feature/AmazingFeature)
   3. Commit your changes (git commit -m 'Add some AmazingFeature')
   4. Push to the branch (git push origin feature/AmazingFeature)
   5. Open a Pull Request

## 👤 Author
**Project**: Airbnb Data Engineering Pipeline
**Technologies**: Snowflake, dbt, AWS, Python

## 🐛 Troubleshooting
Common Issues
    1. Connection Error
       Verify Snowflake credentials in profiles.yml
       Check network connectivity
       Ensure warehouse is running
    2. Compilation Error
       Run dbt debug to check configuration
       Verify model dependencies
       Check Jinja syntax
    3. Incremental Load Issues
       Run dbt run --full-refresh to rebuild from scratch
       Verify source data timestamps








