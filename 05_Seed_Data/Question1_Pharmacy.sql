INSERT INTO medicines (medicine_name, unit_price, stock_qty) VALUES
    ('Paracetamol 500mg', 5.00, 50),
    ('Amoxicillin 250mg', 12.50, 30),
    ('Ibuprofen 200mg', 8.00, 20),
    ('Cough Syrup', 15.00, 12);

CALL pr_record_sale(1, 10, '2026-11-22');
CALL pr_record_sale(1, 5, '2026-11-22');
CALL pr_record_sale(2, 8, '2026-11-22');
CALL pr_record_sale(2, 10, '2026-11-23');
CALL pr_record_sale(3, 12, '2026-11-23');
CALL pr_record_sale(4, 3, '2026-11-23');
CALL pr_record_sale(1, 10, '2026-11-23');