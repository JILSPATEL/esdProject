# SQL Scripts - Database Setup Guide

This directory contains organized SQL scripts for setting up the ERP Billing System database.

## Files Overview

### 1. create.sql
Contains all CREATE TABLE and CREATE VIEW statements.

**Tables**:
- `students` - Student information and academic records
- `bills` - Billing information for fees and charges
- `student_bills` - Links students to their assigned bills (junction table)
- `student_payment` - Payment records for student bills

**Views**:
- `vw_student_bill_balance` - Calculates total paid and remaining amount per student per bill

**Usage**:
```sql
mysql -u root -p
CREATE DATABASE esd_project;
USE esd_project;
SOURCE create.sql;
```

### 2. alter.sql
Contains ALTER TABLE statements for schema modifications.

**Current statements**:
- Reset AUTO_INCREMENT counters for fresh data insertion

**Usage**:
```sql
USE esd_project;
SOURCE alter.sql;
```

### 3. insert.sql
Contains all INSERT statements for sample data.

**Data included**:
- 10 sample students
- 18 bills across multiple semesters
- Student-bill assignments
- Payment records (mix of fully paid and partially paid)

**Usage**:
```sql
USE esd_project;
SOURCE insert.sql;
```

### 4. data.sql (Legacy)
Original combined file with both schema and data. Kept for backward compatibility.

---

## Quick Setup (New Database)

To set up a fresh database with sample data:

```bash
mysql -u root -p
```

Then run:
```sql
CREATE DATABASE esd_project;
USE esd_project;

-- Create tables and views
SOURCE create.sql;

-- Apply schema modifications
SOURCE alter.sql;

-- Insert sample data
SOURCE insert.sql;
```

---

## Alternative Setup (Using data.sql)

If you prefer using the original combined file:

```bash
mysql -u root -p
```

Then run:
```sql
CREATE DATABASE esd_project;
USE esd_project;

-- Create schema
SOURCE schema.sql;

-- Insert data
SOURCE data.sql;
```

---

## Verification

After running the scripts, verify the database:

```sql
-- Check tables
SHOW TABLES;

-- Check student count
SELECT COUNT(*) FROM students;

-- Check bills count
SELECT COUNT(*) FROM bills;

-- Check view
SELECT * FROM vw_student_bill_balance LIMIT 5;
```

Expected results:
- 4 tables: students, bills, student_bills, student_payment
- 1 view: vw_student_bill_balance
- 10 students
- 18 bills

---

## Notes

- All sample students use dummy data except for two test emails
- Payment dates are set for 2025 academic year
- Some bills are fully paid, others are partially paid for testing
- The view `vw_student_bill_balance` automatically calculates balances
