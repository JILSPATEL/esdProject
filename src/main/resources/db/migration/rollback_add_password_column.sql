-- Rollback Script: Add password column back to students table
-- Purpose: Rollback migration in case password field needs to be restored
-- Date: 2025-11-26
-- WARNING: Only use this if you need to revert the OAuth-only changes

-- Add password column back (if needed for rollback)
ALTER TABLE students ADD COLUMN password VARCHAR(255);

-- Note: This will add the column but it will be NULL for all existing records
-- You'll need to populate it with appropriate values if password authentication is re-enabled
