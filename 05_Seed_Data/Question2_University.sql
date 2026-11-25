INSERT INTO students (student_number, full_name, fee_due) VALUES
    ('202401001', 'Chanda Mwila', 5000.00),
    ('202401002', 'Mutale Banda', 3000.00),
    ('202401003', 'Natasha Phiri', 4000.00);

CALL pr_receive_payment(1, 1000.00, '2026-11-20');
CALL pr_receive_payment(1, 1500.00, '2026-11-21');
CALL pr_receive_payment(1, 500.00, '2026-11-22');
CALL pr_receive_payment(2, 1000.00, '2026-11-21');
CALL pr_receive_payment(2, 800.00, '2026-11-22');
CALL pr_receive_payment(2, 1200.00, '2026-11-22');