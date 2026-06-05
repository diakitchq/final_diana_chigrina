
final_diana_chigrina
Fitness Club Database Project

Domain
This project is a Fitness Club Management System database.
It manages members, trainers, fitness classes, equipment, memberships, attendance, and payments.

Database Name
fitness_club_db

Schema Name
fitness_club

Project Description
The database is designed to manage operations inside a fitness club:

Members can register, buy memberships, and attend fitness classes
Trainers conduct fitness classes based on their specialization
Fitness classes are linked with trainers and can use different equipment
Equipment inventory is tracked with stock control
Memberships define subscription types (Basic, Standard, Premium)
Payments track membership fees and automatically calculate tax
Attendance tracks which members attended which classes
The system is normalized to 3rd Normal Form (3NF) and includes:

One-to-many relationships (1:N)
Many-to-many relationships (M:N via junction tables)
Referential integrity with foreign keys and cascading rules

Key Features
- Automatic tax calculation using GENERATED column (12%)
- Data validation using CHECK constraints (salary, dates, status, etc.)
- DEFAULT values for timestamps and payment status
- ON DELETE CASCADE and SET NULL rules for data integrity
- Role-based access control (fitness_readonly, fitness_writer)
- Transaction example with DELETE + ROLLBACK
- ALTER TABLE operations (add column, rename column, modify constraints)

How to Run
Open PostgreSQL (pgAdmin, DBeaver, or psql terminal)

Create database:
CREATE DATABASE fitness_club_db;

Run SQL script in this order:
1. CREATE SCHEMA
2. CREATE TABLES
3. ALTER TABLE statements
4. INSERT DATA
5. UPDATE statements
6. DELETE transaction (ROLLBACK example)
7. GRANT / REVOKE permissions

Set schema:
SET search_path TO fitness_club;

Main Tables
- members
- trainers
- fitness_classes
- equipment
- memberships
- payments
- attendance
- class_equipment

Notes for Instructor
- All foreign keys use subqueries instead of hard-coded IDs
- Script is fully re-runnable using TRUNCATE with RESTART IDENTITY CASCADE
- Includes 5 ALTER TABLE operations (add, rename, modify constraints, type changes)
- Includes GENERATED column for tax calculation
- Includes role-based security (read-only vs writer access)
- Includes transaction example with ROLLBACK for safe testing
```
