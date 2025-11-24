-- ============================================
-- SQL Script to Update Student Passwords with BCrypt Hashes
-- Password Format: first_name@roll_number
-- ============================================
-- 
-- IMPORTANT: Run GeneratePasswordHashes.java first to generate actual BCrypt hashes
-- Then replace the hashes below with the generated ones
--
-- To generate hashes:
-- 1. Build the project: mvnw.cmd clean install
-- 2. Run: mvnw.cmd test-compile exec:java -Dexec.mainClass="com.erp.billing.util.GeneratePasswordHashes"
-- 3. Copy the generated UPDATE statements here
--
-- ============================================

USE esd_project;

-- Update passwords with BCrypt hashes
-- Format: first_name@roll_number
-- Example: John@STU001
-- Generated using: mvnw.cmd compile exec:java

UPDATE students SET password = '$2a$10$Kt0RjBGtiSkeCH48rgY/SeFjQcKXnrbzZO2o9CauDhnsMRCEEV6gu' WHERE roll_number = 'STU001'; -- John@STU001
UPDATE students SET password = '$2a$10$JR87RPjU3L5H//mvA7MLyOEGSU9pRFGX2NBR.KCyajNfyLeVTFe1i' WHERE roll_number = 'STU002'; -- Jane@STU002
UPDATE students SET password = '$2a$10$fmSsdjmS93Rw/DGGPiwQie52Ye4MzDAeuc00dEA.OEbP//4q5sFou' WHERE roll_number = 'STU003'; -- Michael@STU003
UPDATE students SET password = '$2a$10$dB5HniqeF6WXaanLcpIdDe8LhrDSsPA0PhMLVDndifZRW7kRcA9BC' WHERE roll_number = 'STU004'; -- Emily@STU004
UPDATE students SET password = '$2a$10$d1LQ2l9UJPNTQlpu57GCpegsKTxfITKx7y65rHHr6tn8wugneYjUi' WHERE roll_number = 'STU005'; -- David@STU005
UPDATE students SET password = '$2a$10$1.qKD.qJto6CppZanJJFPOWO6t0dy0L/FI7DMsDhnKiZ7FnuCTl7e' WHERE roll_number = 'STU006'; -- Sarah@STU006
UPDATE students SET password = '$2a$10$KxlG6W5RhTjfaIZ3gcoqtupBNrUx3kLba2JSVI2wvGdR6pwldlfwO' WHERE roll_number = 'STU007'; -- Robert@STU007
UPDATE students SET password = '$2a$10$jLPVekOlqbWWmY.gIGhweOvCh2U1QkWLl3QRRqwU1AdJzCHIQbRBm' WHERE roll_number = 'STU008'; -- Lisa@STU008
UPDATE students SET password = '$2a$10$Z0a0FCotdH881V81z5AZuuibyRdzDdxw5XzKr5uKLDgDnd2GmVQnS' WHERE roll_number = 'STU009'; -- James@STU009
UPDATE students SET password = '$2a$10$OLLfIRN3w3RQ7eyJA4Jc7eCGoYbaLdU4nVqMmS5c1cgZ6.iKZVsJy' WHERE roll_number = 'STU010'; -- Amanda@STU010

