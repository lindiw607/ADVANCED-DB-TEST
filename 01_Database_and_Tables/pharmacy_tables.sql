CREATE DATABASE IF NOT EXISTS pharmacy_db;

USE pharmacy_db;

CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0,

    CONSTRAINT chk_med_price
        CHECK (unit_price > 0),

    CONSTRAINT chk_med_stock
        CHECK (stock_qty >= 0)
) ENGINE=InnoDB;


CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    sold_on DATE NOT NULL,

    CONSTRAINT chk_sale_qty
        CHECK (quantity > 0),

    CONSTRAINT chk_sale_price
        CHECK (unit_price > 0),

    CONSTRAINT fk_sales_med
        FOREIGN KEY (medicine_id)
        REFERENCES medicines(medicine_id)
) ENGINE=InnoDB;


CREATE TABLE stock_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    old_qty INT NOT NULL,
    new_qty INT NOT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_audit_med
        FOREIGN KEY (medicine_id)
        REFERENCES medicines(medicine_id)
) ENGINE=InnoDB;


CREATE TABLE daily_sales (
    sales_date DATE PRIMARY KEY,
    total_qty INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL
) ENGINE=InnoDB;