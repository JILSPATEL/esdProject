-- ============================================
-- DUMMY DATA FOR BILLING SYSTEM
-- Database: esd_project
-- ============================================

USE esd_project;

-- Clear existing data (optional - be careful!)
-- DELETE FROM student_payment;
-- DELETE FROM student_bills;
-- DELETE FROM bills;
-- DELETE FROM students;

-- ============================================
-- 1. INSERT STUDENTS
-- ============================================
INSERT INTO students (roll_number, first_name, last_name, email, cgpa, total_credits, graduate_year, domain_id, specialisation_id) VALUES
('STU001', 'John', 'Doe', 'john.doe@university.edu', 8.5, 120, 2025, 1, 1),
('STU002', 'Jane', 'Smith', 'jane.smith@university.edu', 9.2, 115, 2025, 1, 1),
('STU003', 'Michael', 'Johnson', 'michael.j@university.edu', 7.8, 110, 2026, 2, 2),
('STU004', 'Emily', 'Williams', 'emily.w@university.edu', 8.9, 125, 2025, 1, 1),
('STU005', 'David', 'Brown', 'david.brown@university.edu', 7.5, 105, 2026, 2, 2),
('STU006', 'Sarah', 'Davis', 'sarah.davis@university.edu', 9.0, 130, 2024, 1, 1),
('STU007', 'Robert', 'Miller', 'robert.m@university.edu', 8.3, 120, 2025, 1, 1),
('STU008', 'Lisa', 'Wilson', 'lisa.wilson@university.edu', 8.7, 115, 2025, 2, 2),
('STU009', 'James', 'Moore', 'james.moore@university.edu', 7.9, 110, 2026, 2, 2),
('STU010', 'Amanda', 'Taylor', 'amanda.t@university.edu', 9.1, 125, 2025, 1, 1);

-- ============================================
-- 2. INSERT BILLS
-- ============================================
INSERT INTO bills (description, amount, bill_date, deadline) VALUES
('Tuition Fee - Semester 1', 50000.00, '2024-01-15', '2024-02-15'),
('Tuition Fee - Semester 2', 50000.00, '2024-07-15', '2024-08-15'),
('Hostel Fee - Annual', 30000.00, '2024-01-10', '2024-02-10'),
('Library Fee', 2000.00, '2024-01-20', '2024-02-20'),
('Laboratory Fee', 5000.00, '2024-02-01', '2024-03-01'),
('Sports Fee', 3000.00, '2024-02-05', '2024-03-05'),
('Examination Fee', 1500.00, '2024-03-01', '2024-04-01'),
('Development Fee', 10000.00, '2024-01-25', '2024-02-25'),
('Tuition Fee - Semester 1', 50000.00, '2024-01-15', '2024-02-15'),
('Tuition Fee - Semester 2', 50000.00, '2024-07-15', '2024-08-15'),
('Hostel Fee - Annual', 30000.00, '2024-01-10', '2024-02-10'),
('Library Fee', 2000.00, '2024-01-20', '2024-02-20'),
('Laboratory Fee', 5000.00, '2024-02-01', '2024-03-01'),
('Sports Fee', 3000.00, '2024-02-05', '2024-03-05'),
('Examination Fee', 1500.00, '2024-03-01', '2024-04-01'),
('Development Fee', 10000.00, '2024-01-25', '2024-02-25'),
('Tuition Fee - Semester 1', 50000.00, '2024-01-15', '2024-02-15'),
('Hostel Fee - Annual', 30000.00, '2024-01-10', '2024-02-10'),
('Library Fee', 2000.00, '2024-01-20', '2024-02-20'),
('Laboratory Fee', 5000.00, '2024-02-01', '2024-03-01');

-- ============================================
-- 3. LINK STUDENTS TO BILLS (student_bills)
-- ============================================
-- Student 1 (John Doe) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(1, 1),  -- Tuition Fee - Semester 1
(1, 3),  -- Hostel Fee
(1, 4),  -- Library Fee
(1, 5);  -- Laboratory Fee

-- Student 2 (Jane Smith) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(2, 2),  -- Tuition Fee - Semester 2
(2, 3),  -- Hostel Fee
(2, 6),  -- Sports Fee
(2, 7);  -- Examination Fee

-- Student 3 (Michael Johnson) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(3, 9),  -- Tuition Fee - Semester 1
(3, 11), -- Hostel Fee
(3, 12), -- Library Fee
(3, 13); -- Laboratory Fee

-- Student 4 (Emily Williams) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(4, 10), -- Tuition Fee - Semester 2
(4, 11), -- Hostel Fee
(4, 14), -- Sports Fee
(4, 15); -- Examination Fee

-- Student 5 (David Brown) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(5, 17), -- Tuition Fee - Semester 1
(5, 18), -- Hostel Fee
(5, 19), -- Library Fee
(5, 20); -- Laboratory Fee

-- Student 6 (Sarah Davis) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(6, 1),  -- Tuition Fee - Semester 1
(6, 3),  -- Hostel Fee
(6, 4),  -- Library Fee
(6, 8);  -- Development Fee

-- Student 7 (Robert Miller) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(7, 2),  -- Tuition Fee - Semester 2
(7, 3),  -- Hostel Fee
(7, 5),  -- Laboratory Fee
(7, 6);  -- Sports Fee

-- Student 8 (Lisa Wilson) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(8, 9),  -- Tuition Fee - Semester 1
(8, 11), -- Hostel Fee
(8, 12), -- Library Fee
(8, 13); -- Laboratory Fee

-- Student 9 (James Moore) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(9, 10), -- Tuition Fee - Semester 2
(9, 11), -- Hostel Fee
(9, 14), -- Sports Fee
(9, 15); -- Examination Fee

-- Student 10 (Amanda Taylor) - Multiple bills
INSERT INTO student_bills (student_id, bill_id) VALUES
(10, 17), -- Tuition Fee - Semester 1
(10, 18), -- Hostel Fee
(10, 19), -- Library Fee
(10, 20); -- Laboratory Fee

-- ============================================
-- 4. INSERT PAYMENTS (INSTALLMENTS)
-- ============================================

-- Student 1 (John Doe) - Bill 1 (Tuition Fee - $50,000) - Paid in 3 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 1, 'First Installment - Tuition Fee', 20000.00, '2024-01-20 10:30:00'),
(1, 1, 'Second Installment - Tuition Fee', 20000.00, '2024-02-05 14:15:00'),
(1, 1, 'Third Installment - Tuition Fee', 10000.00, '2024-02-12 11:45:00');

-- Student 1 - Bill 3 (Hostel Fee - $30,000) - Paid in 2 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 3, 'First Installment - Hostel Fee', 15000.00, '2024-01-15 09:20:00'),
(1, 3, 'Second Installment - Hostel Fee', 15000.00, '2024-02-01 16:30:00');

-- Student 1 - Bill 4 (Library Fee - $2,000) - Fully paid in one payment
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 4, 'Library Fee - Full Payment', 2000.00, '2024-01-25 10:00:00');

-- Student 1 - Bill 5 (Laboratory Fee - $5,000) - Partially paid (1 installment)
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(1, 5, 'Partial Payment - Laboratory Fee', 3000.00, '2024-02-10 13:20:00');

-- Student 2 (Jane Smith) - Bill 2 (Tuition Fee - $50,000) - Paid in 4 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 2, 'First Installment - Tuition Fee', 15000.00, '2024-07-20 10:00:00'),
(2, 2, 'Second Installment - Tuition Fee', 15000.00, '2024-07-30 14:30:00'),
(2, 2, 'Third Installment - Tuition Fee', 10000.00, '2024-08-05 11:15:00'),
(2, 2, 'Fourth Installment - Tuition Fee', 10000.00, '2024-08-10 15:45:00');

-- Student 2 - Bill 3 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 3, 'Hostel Fee - Full Payment', 30000.00, '2024-01-12 09:00:00');

-- Student 2 - Bill 6 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 6, 'Sports Fee - Full Payment', 3000.00, '2024-02-10 12:00:00');

-- Student 2 - Bill 7 (Examination Fee - $1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(2, 7, 'Examination Fee - Full Payment', 1500.00, '2024-03-05 10:30:00');

-- Student 3 (Michael Johnson) - Bill 9 (Tuition Fee - $50,000) - Paid in 2 installments (partial)
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 9, 'First Installment - Tuition Fee', 25000.00, '2024-01-25 11:00:00'),
(3, 9, 'Second Installment - Tuition Fee', 20000.00, '2024-02-10 14:20:00');

-- Student 3 - Bill 11 (Hostel Fee - $30,000) - Paid in 3 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 11, 'First Installment - Hostel Fee', 10000.00, '2024-01-15 09:30:00'),
(3, 11, 'Second Installment - Hostel Fee', 10000.00, '2024-01-30 13:45:00'),
(3, 11, 'Third Installment - Hostel Fee', 10000.00, '2024-02-05 16:00:00');

-- Student 3 - Bill 12 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(3, 12, 'Library Fee - Full Payment', 2000.00, '2024-01-25 10:15:00');

-- Student 3 - Bill 13 (Laboratory Fee - $5,000) - Not paid yet (no payments)

-- Student 4 (Emily Williams) - Bill 10 (Tuition Fee - $50,000) - Fully paid in 5 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 10, 'First Installment - Tuition Fee', 10000.00, '2024-07-20 10:00:00'),
(4, 10, 'Second Installment - Tuition Fee', 10000.00, '2024-07-28 11:30:00'),
(4, 10, 'Third Installment - Tuition Fee', 10000.00, '2024-08-03 14:00:00'),
(4, 10, 'Fourth Installment - Tuition Fee', 10000.00, '2024-08-08 15:30:00'),
(4, 10, 'Fifth Installment - Tuition Fee', 10000.00, '2024-08-12 10:45:00');

-- Student 4 - Bill 11 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 11, 'Hostel Fee - Full Payment', 30000.00, '2024-01-15 09:00:00');

-- Student 4 - Bill 14 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 14, 'Sports Fee - Full Payment', 3000.00, '2024-02-10 12:00:00');

-- Student 4 - Bill 15 (Examination Fee - $1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(4, 15, 'Examination Fee - Full Payment', 1500.00, '2024-03-05 10:30:00');

-- Student 5 (David Brown) - Bill 17 (Tuition Fee - $50,000) - Paid in 2 installments (partial)
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 17, 'First Installment - Tuition Fee', 30000.00, '2024-01-25 11:00:00'),
(5, 17, 'Second Installment - Tuition Fee', 15000.00, '2024-02-08 14:20:00');

-- Student 5 - Bill 18 (Hostel Fee - $30,000) - Not paid yet

-- Student 5 - Bill 19 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 19, 'Library Fee - Full Payment', 2000.00, '2024-01-25 10:15:00');

-- Student 5 - Bill 20 (Laboratory Fee - $5,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(5, 20, 'Partial Payment - Laboratory Fee', 2500.00, '2024-02-15 13:30:00');

-- Student 6 (Sarah Davis) - Bill 1 (Tuition Fee - $50,000) - Fully paid in 3 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 1, 'First Installment - Tuition Fee', 20000.00, '2024-01-20 10:30:00'),
(6, 1, 'Second Installment - Tuition Fee', 20000.00, '2024-02-05 14:15:00'),
(6, 1, 'Third Installment - Tuition Fee', 10000.00, '2024-02-12 11:45:00');

-- Student 6 - Bill 3 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 3, 'Hostel Fee - Full Payment', 30000.00, '2024-01-12 09:00:00');

-- Student 6 - Bill 4 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 4, 'Library Fee - Full Payment', 2000.00, '2024-01-25 10:00:00');

-- Student 6 - Bill 8 (Development Fee - $10,000) - Paid in 2 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(6, 8, 'First Installment - Development Fee', 5000.00, '2024-01-30 11:00:00'),
(6, 8, 'Second Installment - Development Fee', 5000.00, '2024-02-15 14:30:00');

-- Student 7 (Robert Miller) - Bill 2 (Tuition Fee - $50,000) - Fully paid in 4 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 2, 'First Installment - Tuition Fee', 15000.00, '2024-07-20 10:00:00'),
(7, 2, 'Second Installment - Tuition Fee', 15000.00, '2024-07-30 14:30:00'),
(7, 2, 'Third Installment - Tuition Fee', 10000.00, '2024-08-05 11:15:00'),
(7, 2, 'Fourth Installment - Tuition Fee', 10000.00, '2024-08-10 15:45:00');

-- Student 7 - Bill 3 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 3, 'Hostel Fee - Full Payment', 30000.00, '2024-01-12 09:00:00');

-- Student 7 - Bill 5 (Laboratory Fee - $5,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 5, 'Laboratory Fee - Full Payment', 5000.00, '2024-02-15 13:00:00');

-- Student 7 - Bill 6 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(7, 6, 'Sports Fee - Full Payment', 3000.00, '2024-02-10 12:00:00');

-- Student 8 (Lisa Wilson) - Bill 9 (Tuition Fee - $50,000) - Paid in 3 installments (partial)
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 9, 'First Installment - Tuition Fee', 20000.00, '2024-01-25 11:00:00'),
(8, 9, 'Second Installment - Tuition Fee', 20000.00, '2024-02-10 14:20:00'),
(8, 9, 'Third Installment - Tuition Fee', 5000.00, '2024-02-15 16:00:00');

-- Student 8 - Bill 11 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 11, 'Hostel Fee - Full Payment', 30000.00, '2024-01-15 09:00:00');

-- Student 8 - Bill 12 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(8, 12, 'Library Fee - Full Payment', 2000.00, '2024-01-25 10:15:00');

-- Student 8 - Bill 13 (Laboratory Fee - $5,000) - Not paid yet

-- Student 9 (James Moore) - Bill 10 (Tuition Fee - $50,000) - Fully paid in 5 installments
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 10, 'First Installment - Tuition Fee', 10000.00, '2024-07-20 10:00:00'),
(9, 10, 'Second Installment - Tuition Fee', 10000.00, '2024-07-28 11:30:00'),
(9, 10, 'Third Installment - Tuition Fee', 10000.00, '2024-08-03 14:00:00'),
(9, 10, 'Fourth Installment - Tuition Fee', 10000.00, '2024-08-08 15:30:00'),
(9, 10, 'Fifth Installment - Tuition Fee', 10000.00, '2024-08-12 10:45:00');

-- Student 9 - Bill 11 (Hostel Fee - $30,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 11, 'Hostel Fee - Full Payment', 30000.00, '2024-01-15 09:00:00');

-- Student 9 - Bill 14 (Sports Fee - $3,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 14, 'Sports Fee - Full Payment', 3000.00, '2024-02-10 12:00:00');

-- Student 9 - Bill 15 (Examination Fee - $1,500) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(9, 15, 'Examination Fee - Full Payment', 1500.00, '2024-03-05 10:30:00');

-- Student 10 (Amanda Taylor) - Bill 17 (Tuition Fee - $50,000) - Paid in 2 installments (partial)
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(10, 17, 'First Installment - Tuition Fee', 30000.00, '2024-01-25 11:00:00'),
(10, 17, 'Second Installment - Tuition Fee', 15000.00, '2024-02-08 14:20:00');

-- Student 10 - Bill 18 (Hostel Fee - $30,000) - Not paid yet

-- Student 10 - Bill 19 (Library Fee - $2,000) - Fully paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(10, 19, 'Library Fee - Full Payment', 2000.00, '2024-01-25 10:15:00');

-- Student 10 - Bill 20 (Laboratory Fee - $5,000) - Partially paid
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) VALUES
(10, 20, 'Partial Payment - Laboratory Fee', 2500.00, '2024-02-15 13:30:00');

-- ============================================
-- VERIFICATION QUERIES (Optional - Run to check data)
-- ============================================

-- Check students
-- SELECT * FROM students;

-- Check bills
-- SELECT * FROM bills;

-- Check student-bill relationships
-- SELECT sb.id, s.first_name, s.last_name, b.description, b.amount 
-- FROM student_bills sb
-- JOIN students s ON sb.student_id = s.student_id
-- JOIN bills b ON sb.bill_id = b.id;

-- Check payments with totals
-- SELECT 
--     s.first_name,
--     s.last_name,
--     b.description as bill_description,
--     b.amount as bill_amount,
--     sp.amount as payment_amount,
--     sp.payment_date,
--     sp.description as payment_description
-- FROM student_payment sp
-- JOIN students s ON sp.student_id = s.student_id
-- JOIN bills b ON sp.bill_id = b.id
-- ORDER BY s.student_id, b.id, sp.payment_date;

-- Check total paid per bill per student
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
-- ORDER BY s.student_id, b.id;

