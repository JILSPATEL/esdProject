-- Quick fix for current database state
-- Run this to fix the foreign key constraint issues

USE esd_project;

-- Option 1: Delete all and reload with reset AUTO_INCREMENT
DELETE FROM student_payment;
DELETE FROM student_bills;
DELETE FROM bills;
DELETE FROM students;

-- Reset AUTO_INCREMENT
ALTER TABLE students AUTO_INCREMENT = 1;
ALTER TABLE bills AUTO_INCREMENT = 1;
ALTER TABLE student_bills AUTO_INCREMENT = 1;
ALTER TABLE student_payment AUTO_INCREMENT = 1;

-- Now run the dummy_data.sql file again

