-- ============================================
-- ALTER TABLE STATEMENTS
-- Database: esd_project (Billing System)
-- Description: Schema modifications and index optimizations
-- ============================================

-- Reset auto-increment counters for fresh data insertion
ALTER TABLE students AUTO_INCREMENT = 1;
ALTER TABLE bills AUTO_INCREMENT = 1;
ALTER TABLE student_bills AUTO_INCREMENT = 1;
ALTER TABLE student_payment AUTO_INCREMENT = 1;
