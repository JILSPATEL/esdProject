-- ============================================
-- CLEAN DUMMY DATA FOR BILLING SYSTEM
-- Database: esd_project
-- All payments are validated: total paid <= bill amount
-- ============================================

USE esd_project;

-- Clear existing data
-- DELETE FROM student_payment;
-- DELETE FROM student_bills;
-- DELETE FROM bills;
-- DELETE FROM students;

-- Reset AUTO_INCREMENT to start from 1
ALTER TABLE students AUTO_INCREMENT = 1;
ALTER TABLE bills AUTO_INCREMENT = 1;
ALTER TABLE student_bills AUTO_INCREMENT = 1;
ALTER TABLE student_payment AUTO_INCREMENT = 1;

-- ============================================
-- 1. INSERT STUDENTS
-- Password format: first_name@roll_number
-- Passwords are BCrypt hashed
-- ============================================
INSERT INTO students (roll_number, first_name, last_name, email, password, cgpa, total_credits, graduate_year, domain_id, specialisation_id) VALUES
('STU001', 'John', 'Doe', 'fsnd09768@gmail.com', '$2b$10$z8t5sUxT6wsz/8qWZ5e3QO7N0zLtA44gLeD1B5o3uV4Tz5C2syiJ6', 8.5, 120, 2025, 1, 1),  -- Password: John@STU001
('STU002', 'Jane', 'Smith', '201430142023.cse.jils@gmail.com', '$2b$10$6I8vH3Jr5uM8nQeu5fLvEezf9hUuQdIFN4ZOrwG4Vv8D7ZVkbYjXq', 9.2, 115, 2025, 1, 1),  -- Password: Jane@STU002
('STU003', 'Michael', 'Johnson', 'michael.j@university.edu', '$2a$10$fmSsdjmS93Rw/DGGPiwQie52Ye4MzDAeuc00dEA.OEbP//4q5sFou', 7.8, 110, 2026, 2, 2),  -- Password: Michael@STU003
('STU004', 'Emily', 'Williams', 'emily.w@university.edu', '$2a$10$dB5HniqeF6WXaanLcpIdDe8LhrDSsPA0PhMLVDndifZRW7kRcA9BC', 8.9, 125, 2025, 1, 1),  -- Password: Emily@STU004
('STU005', 'David', 'Brown', 'david.brown@university.edu', '$2a$10$d1LQ2l9UJPNTQlpu57GCpegsKTxfITKx7y65rHHr6tn8wugneYjUi', 7.5, 105, 2026, 2, 2),  -- Password: David@STU005
('STU006', 'Sarah', 'Davis', 'sarah.davis@university.edu', '$2a$10$1.qKD.qJto6CppZanJJFPOWO6t0dy0L/FI7DMsDhnKiZ7FnuCTl7e', 9.0, 130, 2024, 1, 1),  -- Password: Sarah@STU006
('STU007', 'Robert', 'Miller', 'robert.m@university.edu', '$2a$10$KxlG6W5RhTjfaIZ3gcoqtupBNrUx3kLba2JSVI2wvGdR6pwldlfwO', 8.3, 120, 2025, 1, 1),  -- Password: Robert@STU007
('STU008', 'Lisa', 'Wilson', 'lisa.wilson@university.edu', '$2a$10$jLPVekOlqbWWmY.gIGhweOvCh2U1QkWLl3QRRqwU1AdJzCHIQbRBm', 8.7, 115, 2025, 2, 2),  -- Password: Lisa@STU008
('STU009', 'James', 'Moore', 'james.moore@university.edu', '$2a$10$Z0a0FCotdH881V81z5AZuuibyRdzDdxw5XzKr5uKLDgDnd2GmVQnS', 7.9, 110, 2026, 2, 2),  -- Password: James@STU009
('STU010', 'Amanda', 'Taylor', 'amanda.t@university.edu', '$2a$10$OLLfIRN3w3RQ7eyJA4Jc7eCGoYbaLdU4nVqMmS5c1cgZ6.iKZVsJy', 9.1, 125, 2025, 1, 1);  -- Password: Amanda@STU010

-- ============================================
-- 2. INSERT BILLS (2025 Academic Year)
-- Bills are ordered so bill_date increases with bill_id (logical consistency)
-- ============================================
INSERT INTO bills (description, amount, bill_date, deadline) VALUES
-- Semester 1 Bills
('Tuition Fee - Semester 1', 50000.00, '2025-01-10', '2025-02-15'),  -- Bill 1
('Hostel Fee - Semester 1', 30000.00, '2025-01-15', '2025-02-10'),  -- Bill 2 (date >= Bill 1)
('Library Fee', 2000.00, '2025-01-20', '2025-02-20'),  -- Bill 3 (date >= Bill 2)
('Laboratory Fee', 5000.00, '2025-02-01', '2025-03-01'),  -- Bill 4 (date >= Bill 3)
('Sports Fee', 3000.00, '2025-02-05', '2025-03-05'),  -- Bill 5 (date >= Bill 4)
('Examination Fee', 1500.00, '2025-03-01', '2025-04-01'),  -- Bill 6 (date >= Bill 5)
('Development Fee', 10000.00, '2025-03-05', '2025-04-05'),  -- Bill 7 (date >= Bill 6)

-- Semester 2 Bills
('Tuition Fee - Semester 2', 50000.00, '2025-07-10', '2025-08-15'),  -- Bill 8 (date >= Bill 7)
('Hostel Fee - Semester 2', 30000.00, '2025-07-15', '2025-08-10'),  -- Bill 9 (date >= Bill 8)
('Library Fee - Semester 2', 2000.00, '2025-07-20', '2025-08-20'),  -- Bill 10 (date >= Bill 9)
('Laboratory Fee - Semester 2', 5000.00, '2025-08-01', '2025-09-01'),  -- Bill 11 (date >= Bill 10)
('Sports Fee - Semester 2', 3000.00, '2025-08-05', '2025-09-05'),  -- Bill 12 (date >= Bill 11)
('Examination Fee - Semester 2', 1500.00, '2025-09-01', '2025-10-01'),  -- Bill 13 (date >= Bill 12)

-- Additional Bills
('Hostel Fee - Semester 6', 30000.00, '2025-09-05', '2025-10-20'),  -- Bill 14 (date >= Bill 13)
('Tuition Fee - Semester 3', 50000.00, '2025-09-10', '2025-10-15'),  -- Bill 15 (date >= Bill 14)
('Hostel Fee - Semester 3', 30000.00, '2025-09-15', '2025-10-10'),  -- Bill 16 (date >= Bill 15)
('Library Fee - Semester 3', 2000.00, '2025-09-20', '2025-10-20'),  -- Bill 17 (date >= Bill 16)
('Laboratory Fee - Semester 3', 5000.00, '2025-10-01', '2025-11-01');  -- Bill 18 (date >= Bill 17)

-- ============================================
-- 3. LINK STUDENTS TO BILLS (student_bills)
-- ============================================
-- Student 1 (John Doe) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(1, 1),  -- Tuition Fee - Semester 1
(1, 2),  -- Hostel Fee - Semester 1
(1, 3),  -- Library Fee
(1, 4);  -- Laboratory Fee

-- Student 2 (Jane Smith) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(2, 1),  -- Tuition Fee - Semester 1
(2, 2),  -- Hostel Fee - Semester 1
(2, 5),  -- Sports Fee
(2, 6),  -- Examination Fee
(2, 8),  -- Tuition Fee - Semester 2
(2, 9);  -- Hostel Fee - Semester 2

-- Student 3 (Michael Johnson) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(3, 1),  -- Tuition Fee - Semester 1
(3, 2),  -- Hostel Fee - Semester 1
(3, 3),  -- Library Fee
(3, 4);  -- Laboratory Fee

-- Student 4 (Emily Williams) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(4, 1),  -- Tuition Fee - Semester 1
(4, 2),  -- Hostel Fee - Semester 1
(4, 5),  -- Sports Fee
(4, 6),  -- Examination Fee
(4, 8),  -- Tuition Fee - Semester 2
(4, 9);  -- Hostel Fee - Semester 2

-- Student 5 (David Brown) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(5, 1),  -- Tuition Fee - Semester 1
(5, 2),  -- Hostel Fee - Semester 1
(5, 3),  -- Library Fee
(5, 4);  -- Laboratory Fee

-- Student 6 (Sarah Davis) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(6, 1),  -- Tuition Fee - Semester 1
(6, 2),  -- Hostel Fee - Semester 1
(6, 3),  -- Library Fee
(6, 7);  -- Development Fee

-- Student 7 (Robert Miller) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(7, 1),  -- Tuition Fee - Semester 1
(7, 2),  -- Hostel Fee - Semester 1
(7, 4),  -- Laboratory Fee
(7, 5),  -- Sports Fee
(7, 8),  -- Tuition Fee - Semester 2
(7, 9);  -- Hostel Fee - Semester 2

-- Student 8 (Lisa Wilson) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(8, 1),  -- Tuition Fee - Semester 1
(8, 2),  -- Hostel Fee - Semester 1
(8, 3),  -- Library Fee
(8, 4);  -- Laboratory Fee

-- Student 9 (James Moore) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(9, 1),  -- Tuition Fee - Semester 1
(9, 2),  -- Hostel Fee - Semester 1
(9, 5),  -- Sports Fee
(9, 6),  -- Examination Fee
(9, 8),  -- Tuition Fee - Semester 2
(9, 9);  -- Hostel Fee - Semester 2

-- Student 10 (Amanda Taylor) - Semester 6 bill
INSERT INTO student_bills (student_id, bill_id) VALUES
(10, 14); -- Hostel Fee - Semester 6 (now bill 14)

-- ============================================
-- 4. INSERT PAYMENTS (All payments <= bill amount)
-- ============================================

-- Student 1 (John Doe) - Bill 1 (Tuition Fee - $50,000) - Fully paid in 3 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 1, 'First Installment - Tuition Fee', 20000.00, '2025-01-20 10:30:00'),
(1, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-05 14:15:00'),
(1, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-12 11:45:00');
-- Total: $50,000 (Fully Paid)

-- Student 1 - Bill 2 (Hostel Fee - $30,000) - Fully paid in 2 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 2, 'First Installment - Hostel Fee', 15000.00, '2025-01-15 09:20:00'),
(1, 2, 'Second Installment - Hostel Fee', 15000.00, '2025-02-01 16:30:00');
-- Total: $30,000 (Fully Paid)

-- Student 1 - Bill 3 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:00:00');
-- Total: $2,000 (Fully Paid)

-- Student 1 - Bill 4 (Laboratory Fee - $5,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 4, 'Partial Payment - Laboratory Fee', 3000.00, '2025-02-10 13:20:00');
-- Total: $3,000 (Remaining: $2,000)

-- Student 2 (Jane Smith) - Bill 1 (Tuition Fee - $50,000) - Fully paid in 4 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 1, 'First Installment - Tuition Fee', 15000.00, '2025-01-20 10:00:00'),
(2, 1, 'Second Installment - Tuition Fee', 15000.00, '2025-01-30 14:30:00'),
(2, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-05 11:15:00'),
(2, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-10 15:45:00');
-- Total: $50,000 (Fully Paid)

-- Student 2 - Bill 2 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-12 09:00:00');
-- Total: $30,000 (Fully Paid)

-- Student 2 - Bill 5 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');
-- Total: $3,000 (Fully Paid)

-- Student 2 - Bill 6 (Examination Fee - $1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 6, 'Examination Fee - Full Payment', 1500.00, '2025-03-05 10:30:00');
-- Total: $1,500 (Fully Paid)

-- Student 2 - Bill 8 (Tuition Fee Semester 2 - $50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 8, 'First Installment - Tuition Fee Semester 2', 25000.00, '2025-07-20 10:00:00'),
(2, 8, 'Second Installment - Tuition Fee Semester 2', 15000.00, '2025-08-01 14:30:00');
-- Total: $40,000 (Remaining: $10,000)

-- Student 2 - Bill 9 (Hostel Fee Semester 2 - $30,000) - Not paid yet

-- Student 3 (Michael Johnson) - Bill 1 (Tuition Fee - $50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 1, 'First Installment - Tuition Fee', 25000.00, '2025-01-25 11:00:00'),
(3, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-10 14:20:00');
-- Total: $45,000 (Remaining: $5,000)

-- Student 3 - Bill 2 (Hostel Fee - $30,000) - Fully paid in 3 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 2, 'First Installment - Hostel Fee', 10000.00, '2025-01-15 09:30:00'),
(3, 2, 'Second Installment - Hostel Fee', 10000.00, '2025-01-30 13:45:00'),
(3, 2, 'Third Installment - Hostel Fee', 10000.00, '2025-02-05 16:00:00');
-- Total: $30,000 (Fully Paid)

-- Student 3 - Bill 3 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:15:00');
-- Total: $2,000 (Fully Paid)

-- Student 3 - Bill 4 (Laboratory Fee - $5,000) - Not paid yet

-- Student 4 (Emily Williams) - Bill 1 (Tuition Fee - $50,000) - Fully paid in 5 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 1, 'First Installment - Tuition Fee', 10000.00, '2025-01-20 10:00:00'),
(4, 1, 'Second Installment - Tuition Fee', 10000.00, '2025-01-28 11:30:00'),
(4, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-03 14:00:00'),
(4, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-08 15:30:00'),
(4, 1, 'Fifth Installment - Tuition Fee', 10000.00, '2025-02-12 10:45:00');
-- Total: $50,000 (Fully Paid)

-- Student 4 - Bill 2 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-15 09:00:00');
-- Total: $30,000 (Fully Paid)

-- Student 4 - Bill 5 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');
-- Total: $3,000 (Fully Paid)

-- Student 4 - Bill 6 (Examination Fee - $1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 6, 'Examination Fee - Full Payment', 1500.00, '2025-03-05 10:30:00');
-- Total: $1,500 (Fully Paid)

-- Student 4 - Bill 8 (Tuition Fee Semester 2 - $50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 8, 'First Installment - Tuition Fee Semester 2', 30000.00, '2025-07-20 10:00:00');
-- Total: $30,000 (Remaining: $20,000)

-- Student 4 - Bill 9 (Hostel Fee Semester 2 - $30,000) - Not paid yet

-- Student 5 (David Brown) - Bill 1 (Tuition Fee - $50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 1, 'First Installment - Tuition Fee', 30000.00, '2025-01-25 11:00:00'),
(5, 1, 'Second Installment - Tuition Fee', 15000.00, '2025-02-08 14:20:00');
-- Total: $45,000 (Remaining: $5,000)

-- Student 5 - Bill 2 (Hostel Fee - $30,000) - Not paid yet

-- Student 5 - Bill 3 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:15:00');
-- Total: $2,000 (Fully Paid)

-- Student 5 - Bill 4 (Laboratory Fee - $5,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 4, 'Partial Payment - Laboratory Fee', 2500.00, '2025-02-15 13:30:00');
-- Total: $2,500 (Remaining: $2,500)

-- Student 6 (Sarah Davis) - Bill 1 (Tuition Fee - $50,000) - Fully paid in 3 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 1, 'First Installment - Tuition Fee', 20000.00, '2025-01-20 10:30:00'),
(6, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-05 14:15:00'),
(6, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-12 11:45:00');
-- Total: $50,000 (Fully Paid)

-- Student 6 - Bill 2 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-12 09:00:00');
-- Total: $30,000 (Fully Paid)

-- Student 6 - Bill 3 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:00:00');
-- Total: $2,000 (Fully Paid)

-- Student 6 - Bill 7 (Development Fee - $10,000) - Fully paid in 2 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 7, 'First Installment - Development Fee', 5000.00, '2025-01-30 11:00:00'),
(6, 7, 'Second Installment - Development Fee', 5000.00, '2025-02-15 14:30:00');
-- Total: $10,000 (Fully Paid)

-- Student 7 (Robert Miller) - Bill 1 (Tuition Fee - $50,000) - Fully paid in 4 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 1, 'First Installment - Tuition Fee', 15000.00, '2025-01-20 10:00:00'),
(7, 1, 'Second Installment - Tuition Fee', 15000.00, '2025-01-30 14:30:00'),
(7, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-05 11:15:00'),
(7, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-10 15:45:00');
-- Total: $50,000 (Fully Paid)

-- Student 7 - Bill 2 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-12 09:00:00');
-- Total: $30,000 (Fully Paid)

-- Student 7 - Bill 4 (Laboratory Fee - $5,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 4, 'Laboratory Fee - Full Payment', 5000.00, '2025-02-15 13:00:00');
-- Total: $5,000 (Fully Paid)

-- Student 7 - Bill 5 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');
-- Total: $3,000 (Fully Paid)

-- Student 7 - Bill 8 (Tuition Fee Semester 2 - $50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 8, 'First Installment - Tuition Fee Semester 2', 20000.00, '2025-07-20 10:00:00');
-- Total: $20,000 (Remaining: $30,000)

-- Student 7 - Bill 9 (Hostel Fee Semester 2 - $30,000) - Not paid yet

-- Student 8 (Lisa Wilson) - Bill 1 (Tuition Fee - $50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 1, 'First Installment - Tuition Fee', 20000.00, '2025-01-25 11:00:00'),
(8, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-10 14:20:00'),
(8, 1, 'Third Installment - Tuition Fee', 5000.00, '2025-02-15 16:00:00');
-- Total: $45,000 (Remaining: $5,000)

-- Student 8 - Bill 2 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-15 09:00:00');
-- Total: $30,000 (Fully Paid)

-- Student 8 - Bill 3 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:15:00');
-- Total: $2,000 (Fully Paid)

-- Student 8 - Bill 4 (Laboratory Fee - $5,000) - Not paid yet

-- Student 9 (James Moore) - Bill 1 (Tuition Fee - $50,000) - Fully paid in 5 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 1, 'First Installment - Tuition Fee', 10000.00, '2025-01-20 10:00:00'),
(9, 1, 'Second Installment - Tuition Fee', 10000.00, '2025-01-28 11:30:00'),
(9, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-03 14:00:00'),
(9, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-08 15:30:00'),
(9, 1, 'Fifth Installment - Tuition Fee', 10000.00, '2025-02-12 10:45:00');
-- Total: $50,000 (Fully Paid)

-- Student 9 - Bill 2 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-15 09:00:00');
-- Total: $30,000 (Fully Paid)

-- Student 9 - Bill 5 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');
-- Total: $3,000 (Fully Paid)

-- Student 9 - Bill 6 (Examination Fee - $1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 6, 'Examination Fee - Full Payment', 1500.00, '2025-03-05 10:30:00');
-- Total: $1,500 (Fully Paid)

-- Student 9 - Bill 8 (Tuition Fee Semester 2 - $50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 8, 'First Installment - Tuition Fee Semester 2', 25000.00, '2025-07-20 10:00:00');
-- Total: $25,000 (Remaining: $25,000)

-- Student 9 - Bill 9 (Hostel Fee Semester 2 - $30,000) - Not paid yet

-- Student 10 (Amanda Taylor) - Bill 14 (Hostel Fee - Semester 6 - $30,000) - CORRECTED: Fully paid in 3 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(10, 14, 'First Installment - Hostel Fee Semester 6', 10000.00, '2025-09-10 09:30:00'),
(10, 14, 'Second Installment - Hostel Fee Semester 6', 10000.00, '2025-09-25 13:45:00'),
(10, 14, 'Third Installment - Hostel Fee Semester 6', 10000.00, '2025-10-10 16:00:00');
-- Total: $30,000 (Fully Paid) - Payment dates after bill_date (2025-09-05) and before deadline (2025-10-20)

-- ============================================
-- VERIFICATION QUERIES (Optional - Run to check data)
-- ============================================

-- Check total paid per bill per student (should never exceed bill amount)
-- SELECT 
--     s.student_id,
--     s.first_name,
--     s.last_name,
--     b.id as bill_id,
--     b.description,
--     b.amount as total_bill_amount,
--     COALESCE(SUM(sp.amount), 0) as total_paid,
--     (b.amount - COALESCE(SUM(sp.amount), 0)) as remaining_amount
-- FROM student_bills sb
-- JOIN students s ON sb.student_id = s.student_id
-- JOIN bills b ON sb.bill_id = b.id
-- LEFT JOIN student_payment sp ON s.student_id = sp.student_id AND b.id = sp.bill_id
-- GROUP BY s.student_id, s.first_name, s.last_name, b.id, b.description, b.amount
-- HAVING COALESCE(SUM(sp.amount), 0) > b.amount  -- This should return NO ROWS
-- ORDER BY s.student_id, b.id;
