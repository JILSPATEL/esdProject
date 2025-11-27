-- ============================================
-- INSERT SAMPLE DATA
-- Database: esd_project (Billing System)
-- Description: Sample student, bill, and payment data for testing
-- All payments are validated: total paid <= bill amount
-- ============================================

USE esd_project;

-- ============================================
-- 1. INSERT STUDENTS
-- ============================================
INSERT INTO students (roll_number, first_name, last_name, email, cgpa, total_credits, graduate_year, domain_id, specialisation_id) VALUES
('STU001', 'John', 'Doe', 'fsnd09768@gmail.com', 8.5, 120, 2025, 1, 1),
('STU002', 'Jane', 'Smith', '201430142023.cse.jils@gmail.com', 9.2, 115, 2025, 1, 1),
('STU003', 'Michael', 'Johnson', 'michael.j@university.edu', 7.8, 110, 2026, 2, 2),
('STU004', 'Emily', 'Williams', 'emily.w@university.edu', 8.9, 125, 2025, 1, 1),
('STU005', 'David', 'Brown', 'david.brown@university.edu', 7.5, 105, 2026, 2, 2),
('STU006', 'Sarah', 'Davis', 'sarah.davis@university.edu', 9.0, 130, 2024, 1, 1),
('STU007', 'Robert', 'Miller', 'robert.m@university.edu', 8.3, 120, 2025, 1, 1),
('STU008', 'Lisa', 'Wilson', 'lisa.wilson@university.edu', 8.7, 115, 2025, 2, 2),
('STU009', 'James', 'Moore', 'james.moore@university.edu', 7.9, 110, 2026, 2, 2),
('STU010', 'Amanda', 'Taylor', 'amanda.t@university.edu', 9.1, 125, 2025, 1, 1);

-- ============================================
-- 2. INSERT BILLS (2025 Academic Year)
-- ============================================
INSERT INTO bills (description, amount, bill_date, deadline) VALUES
-- Semester 1 Bills
('Tuition Fee - Semester 1', 50000.00, '2025-01-10', '2025-02-15'),
('Hostel Fee - Semester 1', 30000.00, '2025-01-15', '2025-02-10'),
('Library Fee', 2000.00, '2025-01-20', '2025-02-20'),
('Laboratory Fee', 5000.00, '2025-02-01', '2025-03-01'),
('Sports Fee', 3000.00, '2025-02-05', '2025-03-05'),
('Examination Fee', 1500.00, '2025-03-01', '2025-04-01'),
('Development Fee', 10000.00, '2025-03-05', '2025-04-05'),

-- Semester 2 Bills
('Tuition Fee - Semester 2', 50000.00, '2025-07-10', '2025-08-15'),
('Hostel Fee - Semester 2', 30000.00, '2025-07-15', '2025-08-10'),
('Library Fee - Semester 2', 2000.00, '2025-07-20', '2025-08-20'),
('Laboratory Fee - Semester 2', 5000.00, '2025-08-01', '2025-09-01'),
('Sports Fee - Semester 2', 3000.00, '2025-08-05', '2025-09-05'),
('Examination Fee - Semester 2', 1500.00, '2025-09-01', '2025-10-01'),

-- Additional Bills
('Hostel Fee - Semester 6', 30000.00, '2025-09-05', '2025-10-20'),
('Tuition Fee - Semester 3', 50000.00, '2025-09-10', '2025-10-15'),
('Hostel Fee - Semester 3', 30000.00, '2025-09-15', '2025-10-10'),
('Library Fee - Semester 3', 2000.00, '2025-09-20', '2025-10-20'),
('Laboratory Fee - Semester 3', 5000.00, '2025-10-01', '2025-11-01');

-- ============================================
-- 3. LINK STUDENTS TO BILLS (student_bills)
-- ============================================

-- Student 1 (John Doe) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4);

-- Student 2 (Jane Smith) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(2, 1), (2, 2), (2, 5), (2, 6), (2, 8), (2, 9);

-- Student 3 (Michael Johnson) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(3, 1), (3, 2), (3, 3), (3, 4);

-- Student 4 (Emily Williams) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(4, 1), (4, 2), (4, 5), (4, 6), (4, 8), (4, 9);

-- Student 5 (David Brown) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(5, 1), (5, 2), (5, 3), (5, 4);

-- Student 6 (Sarah Davis) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(6, 1), (6, 2), (6, 3), (6, 7);

-- Student 7 (Robert Miller) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(7, 1), (7, 2), (7, 4), (7, 5), (7, 8), (7, 9);

-- Student 8 (Lisa Wilson) - Semester 1 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(8, 1), (8, 2), (8, 3), (8, 4);

-- Student 9 (James Moore) - Semester 1 & 2 bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(9, 1), (9, 2), (9, 5), (9, 6), (9, 8), (9, 9);

-- Student 10 (Amanda Taylor) - Semester 6 bill
INSERT INTO student_bills (student_id, bill_id) VALUES
(10, 14);

-- ============================================
-- 4. INSERT PAYMENTS
-- ============================================

-- Student 1: Tuition Fee ($50,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 1, 'First Installment - Tuition Fee', 20000.00, '2025-01-20 10:30:00'),
(1, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-05 14:15:00'),
(1, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-12 11:45:00');

-- Student 1: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 2, 'First Installment - Hostel Fee', 15000.00, '2025-01-15 09:20:00'),
(1, 2, 'Second Installment - Hostel Fee', 15000.00, '2025-02-01 16:30:00');

-- Student 1: Library Fee ($2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:00:00');

-- Student 1: Laboratory Fee ($5,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 4, 'Partial Payment - Laboratory Fee', 3000.00, '2025-02-10 13:20:00');

-- Student 2: Tuition Fee ($50,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 1, 'First Installment - Tuition Fee', 15000.00, '2025-01-20 10:00:00'),
(2, 1, 'Second Installment - Tuition Fee', 15000.00, '2025-01-30 14:30:00'),
(2, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-05 11:15:00'),
(2, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-10 15:45:00');

-- Student 2: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-12 09:00:00');

-- Student 2: Sports Fee ($3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');

-- Student 2: Examination Fee ($1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 6, 'Examination Fee - Full Payment', 1500.00, '2025-03-05 10:30:00');

-- Student 2: Tuition Fee Semester 2 ($50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 8, 'First Installment - Tuition Fee Semester 2', 25000.00, '2025-07-20 10:00:00'),
(2, 8, 'Second Installment - Tuition Fee Semester 2', 15000.00, '2025-08-01 14:30:00');

-- Student 3: Tuition Fee ($50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 1, 'First Installment - Tuition Fee', 25000.00, '2025-01-25 11:00:00'),
(3, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-10 14:20:00');

-- Student 3: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 2, 'First Installment - Hostel Fee', 10000.00, '2025-01-15 09:30:00'),
(3, 2, 'Second Installment - Hostel Fee', 10000.00, '2025-01-30 13:45:00'),
(3, 2, 'Third Installment - Hostel Fee', 10000.00, '2025-02-05 16:00:00');

-- Student 3: Library Fee ($2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:15:00');

-- Student 4: Tuition Fee ($50,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 1, 'First Installment - Tuition Fee', 10000.00, '2025-01-20 10:00:00'),
(4, 1, 'Second Installment - Tuition Fee', 10000.00, '2025-01-28 11:30:00'),
(4, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-03 14:00:00'),
(4, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-08 15:30:00'),
(4, 1, 'Fifth Installment - Tuition Fee', 10000.00, '2025-02-12 10:45:00');

-- Student 4: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-15 09:00:00');

-- Student 4: Sports Fee ($3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');

-- Student 4: Examination Fee ($1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 6, 'Examination Fee - Full Payment', 1500.00, '2025-03-05 10:30:00');

-- Student 4: Tuition Fee Semester 2 ($50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 8, 'First Installment - Tuition Fee Semester 2', 30000.00, '2025-07-20 10:00:00');

-- Student 5: Tuition Fee ($50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 1, 'First Installment - Tuition Fee', 30000.00, '2025-01-25 11:00:00'),
(5, 1, 'Second Installment - Tuition Fee', 15000.00, '2025-02-08 14:20:00');

-- Student 5: Library Fee ($2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:15:00');

-- Student 5: Laboratory Fee ($5,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 4, 'Partial Payment - Laboratory Fee', 2500.00, '2025-02-15 13:30:00');

-- Student 6: Tuition Fee ($50,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 1, 'First Installment - Tuition Fee', 20000.00, '2025-01-20 10:30:00'),
(6, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-05 14:15:00'),
(6, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-12 11:45:00');

-- Student 6: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-12 09:00:00');

-- Student 6: Library Fee ($2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:00:00');

-- Student 6: Development Fee ($10,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 7, 'First Installment - Development Fee', 5000.00, '2025-01-30 11:00:00'),
(6, 7, 'Second Installment - Development Fee', 5000.00, '2025-02-15 14:30:00');

-- Student 7: Tuition Fee ($50,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 1, 'First Installment - Tuition Fee', 15000.00, '2025-01-20 10:00:00'),
(7, 1, 'Second Installment - Tuition Fee', 15000.00, '2025-01-30 14:30:00'),
(7, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-05 11:15:00'),
(7, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-10 15:45:00');

-- Student 7: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-12 09:00:00');

-- Student 7: Laboratory Fee ($5,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 4, 'Laboratory Fee - Full Payment', 5000.00, '2025-02-15 13:00:00');

-- Student 7: Sports Fee ($3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');

-- Student 7: Tuition Fee Semester 2 ($50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 8, 'First Installment - Tuition Fee Semester 2', 20000.00, '2025-07-20 10:00:00');

-- Student 8: Tuition Fee ($50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 1, 'First Installment - Tuition Fee', 20000.00, '2025-01-25 11:00:00'),
(8, 1, 'Second Installment - Tuition Fee', 20000.00, '2025-02-10 14:20:00'),
(8, 1, 'Third Installment - Tuition Fee', 5000.00, '2025-02-15 16:00:00');

-- Student 8: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-15 09:00:00');

-- Student 8: Library Fee ($2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 3, 'Library Fee - Full Payment', 2000.00, '2025-01-25 10:15:00');

-- Student 9: Tuition Fee ($50,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 1, 'First Installment - Tuition Fee', 10000.00, '2025-01-20 10:00:00'),
(9, 1, 'Second Installment - Tuition Fee', 10000.00, '2025-01-28 11:30:00'),
(9, 1, 'Third Installment - Tuition Fee', 10000.00, '2025-02-03 14:00:00'),
(9, 1, 'Fourth Installment - Tuition Fee', 10000.00, '2025-02-08 15:30:00'),
(9, 1, 'Fifth Installment - Tuition Fee', 10000.00, '2025-02-12 10:45:00');

-- Student 9: Hostel Fee ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 2, 'Hostel Fee - Full Payment', 30000.00, '2025-01-15 09:00:00');

-- Student 9: Sports Fee ($3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 5, 'Sports Fee - Full Payment', 3000.00, '2025-02-10 12:00:00');

-- Student 9: Examination Fee ($1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 6, 'Examination Fee - Full Payment', 1500.00, '2025-03-05 10:30:00');

-- Student 9: Tuition Fee Semester 2 ($50,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 8, 'First Installment - Tuition Fee Semester 2', 25000.00, '2025-07-20 10:00:00');

-- Student 10: Hostel Fee Semester 6 ($30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(10, 14, 'First Installment - Hostel Fee Semester 6', 10000.00, '2025-09-10 09:30:00'),
(10, 14, 'Second Installment - Hostel Fee Semester 6', 10000.00, '2025-09-25 13:45:00'),
(10, 14, 'Third Installment - Hostel Fee Semester 6', 10000.00, '2025-10-10 16:00:00');
