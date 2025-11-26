-- Migration Script: Remove password column from students table
-- Purpose: This application uses OAuth2 (Google) authentication only
-- Date: 2025-11-26
-- Description: Drops the password column as it's not needed for OAuth-based authentication

-- Step 1: Drop the password column from students table
ALTER TABLE students DROP COLUMN password;

-- Note: Make sure to backup your database before running this migration
-- This change is irreversible and will permanently remove all password data
