# MediSoftDatabase
SQL scripts for the MediSoft hospital database system, including table creation, sample data, views, indexes, and queries. Built by a team of 5 IT students for managing hospital operations using Oracle SQL.

## 📁 Repository Contents

| File Name                               | Description                                                                 |
|----------------------------------------|-----------------------------------------------------------------------------|
| `table 2.sql`                           | SQL script to create hospital tables (patients, doctors, appointments, etc). |
| `sampledatav2 2.sql`                    | Populates the database with sample data for development and testing.         |
| `oracle_hospital_queries.sql`          | Oracle-specific queries for data retrieval and manipulation.                |
| `Medisoft_Drop_Create_Views_Indexes 2.sql` | SQL script to create views and indexes, and drop existing ones if needed.   |
| `samplequery 2.sql`                    | Additional sample queries for validating and demonstrating database usage.   |

---

## 🏥 Project Overview

The MediSoft project is designed to simulate the backend database for a hospital management system. Features include:

- Patient and staff management  
- Appointments and admissions  
- Billing and department tracking  
- Advanced queries using views and indexes  

---

## 🛠️ Setup Instructions

### 1. Prerequisites

- Oracle Database or compatible RDBMS  
- SQL client (e.g., SQL Developer, DBeaver)

### 2. Execution Order

To set up the database:

```sql
-- Step 1: Create all tables
@table\ 2.sql

-- Step 2: Insert test data
@sampledatav2\ 2.sql

-- Step 3: Create views and indexes
@Medisoft_Drop_Create_Views_Indexes\ 2.sql

-- Step 4: Run sample queries
@samplequery\ 2.sql
@oracle_hospital_queries.sql
