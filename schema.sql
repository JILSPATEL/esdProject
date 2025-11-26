CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150) NOT NULL UNIQUE,
    photograph_path VARCHAR(255),
    cgpa DECIMAL(4,2),
    total_credits INT,
    graduate_year INT,
    domain_id INT,
    specialisation_id INT,
    placement_id INT,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT,
    amount DECIMAL(10,2) NOT NULL,
    bill_date DATE,
    deadline DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS student_bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    bill_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_student_bills_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_student_bills_bill
        FOREIGN KEY (bill_id) REFERENCES bills(id)
        ON DELETE CASCADE,
    CONSTRAINT uq_student_bill UNIQUE (student_id, bill_id)
);

CREATE TABLE IF NOT EXISTS student_payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    bill_id INT NOT NULL,
    description TEXT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_student_payment_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_student_payment_bill
        FOREIGN KEY (bill_id) REFERENCES bills(id)
        ON DELETE CASCADE,
    INDEX idx_payment_student_bill (student_id, bill_id)
);

CREATE OR REPLACE VIEW vw_student_bill_balance AS
SELECT
    sb.student_id,
    sb.bill_id,
    b.description,
    b.amount AS bill_amount,
    COALESCE(SUM(sp.amount), 0) AS total_paid,
    (b.amount - COALESCE(SUM(sp.amount), 0)) AS remaining_amount
FROM student_bills sb
JOIN bills b ON sb.bill_id = b.id
LEFT JOIN student_payment sp
    ON sp.student_id = sb.student_id AND sp.bill_id = sb.bill_id
GROUP BY sb.student_id, sb.bill_id, b.description, b.amount;

