-- ============================================
-- SQL Script to Add Password Column to Students Table
-- ============================================

USE esd_project;

-- Add password column to students table
ALTER TABLE students 
ADD COLUMN password VARCHAR(255) NOT NULL DEFAULT '' AFTER placement_id;

-- Note: After running this script, you need to update passwords using the dummy_data.sql file
-- which will include BCrypt hashed passwords in the format: first_name@roll_number

