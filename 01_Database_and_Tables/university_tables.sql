CREATE DATABASE IF NOT EXISTS university_db;

USE university_db;

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    fee_due DECIMAL(12,2) NOT NULL,

    CONSTRAINT chk_fee_due
        CHECK (fee_due >= 0)
) ENGINE=InnoDB;


CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    paid_on DATE NOT NULL,

    CONSTRAINT chk_pay_amount
        CHECK (amount > 0),

    CONSTRAINT fk_pay_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
) ENGINE=InnoDB;


CREATE TABLE payment_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    student_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    logged_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_aud_payment
        FOREIGN KEY (payment_id)
        REFERENCES payments(payment_id),

    CONSTRAINT fk_aud_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
) ENGINE=InnoDB;


CREATE TABLE daily_collections (
    collection_date DATE PRIMARY KEY,
    payment_count INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL
) ENGINE=InnoDB;