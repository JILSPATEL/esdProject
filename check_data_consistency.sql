-- ============================================
-- DATA CONSISTENCY CHECK QUERIES
-- Run these to identify logical inconsistencies
-- ============================================

USE esd_project;

-- Check 1: Bills not in chronological order by ID
SELECT 
    id,
    description,
    bill_date,
    deadline,
    CASE 
        WHEN id > 1 AND bill_date < (SELECT bill_date FROM bills WHERE id = (SELECT MAX(id) FROM bills b2 WHERE b2.id < bills.id))
        THEN 'INCONSISTENT: Bill date is before previous bill'
        ELSE 'OK'
    END as consistency_check
FROM bills
ORDER BY id;

-- Check 2: Payment dates before bill dates
SELECT 
    sp.id as payment_id,
    sp.student_id,
    sp.bill_id,
    b.description as bill_description,
    b.bill_date,
    sp.payment_date,
    CASE 
        WHEN DATE(sp.payment_date) < b.bill_date THEN 'INCONSISTENT: Payment before bill date'
        ELSE 'OK'
    END as consistency_check
FROM student_payment sp
JOIN bills b ON sp.bill_id = b.id
WHERE DATE(sp.payment_date) < b.bill_date;

-- Check 3: Payment dates after deadline
SELECT 
    sp.id as payment_id,
    sp.student_id,
    sp.bill_id,
    b.description as bill_description,
    b.deadline,
    sp.payment_date,
    CASE 
        WHEN DATE(sp.payment_date) > b.deadline THEN 'INCONSISTENT: Payment after deadline'
        ELSE 'OK'
    END as consistency_check
FROM student_payment sp
JOIN bills b ON sp.bill_id = b.id
WHERE DATE(sp.payment_date) > b.deadline;

-- Check 4: Deadline before bill date
SELECT 
    id,
    description,
    bill_date,
    deadline,
    CASE 
        WHEN deadline < bill_date THEN 'INCONSISTENT: Deadline before bill date'
        ELSE 'OK'
    END as consistency_check
FROM bills
WHERE deadline < bill_date;

-- Check 5: Summary of all bills with dates
SELECT 
    id,
    description,
    bill_date,
    deadline,
    DATEDIFF(deadline, bill_date) as days_between
FROM bills
ORDER BY bill_date, id;

