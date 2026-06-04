# final_diana_chigrina
# Fitness Club Database Project

## Domain
This project is a Fitness Club Management System database.  
It manages members, trainers, fitness classes, equipment, memberships, attendance, and payments.

---

## Database Name
fitness_club_db

## Schema Name
fitness_club

---

## Project Description
The database is designed to manage operations inside a fitness club:

- Members can buy memberships and attend classes
- Trainers conduct fitness classes
- Classes use equipment
- Payments track membership fees
- Attendance tracks which members attended which classes

The system is normalized to 3rd Normal Form (3NF) and includes relationships:
- One-to-many (1:N)
- Many-to-many (M:N via junction tables)

---

## How to Run

1. Open PostgreSQL (pgAdmin)
2. Create a new database:
   CREATE DATABASE fitness_club_db;

3. Run the SQL script in this order:
   - DROP SCHEMA (if exists)
   - CREATE TABLES
   - ALTER TABLE
   - INSERT DATA
   - UPDATE statements
   - DELETE transaction
   - GRANT / REVOKE

4. Set schema:
   SET search_path TO fitness_club;

---

## Main Tables

- members
- trainers
- fitness_classes
- equipment
- memberships
- payments
- attendance
- class_equipment

---

## Notes for Instructor
- All foreign keys use subqueries (no hard-coded IDs)
- Script is fully re-runnable
- Includes 5 ALTER TABLE operations
- Includes GENERATED column and DEFAULT values
- Includes transactions for DELETE (ROLLBACK used)
