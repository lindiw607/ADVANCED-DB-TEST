CREATE OR REPLACE VIEW v_low_stock AS
SELECT
    medicine_id,
    medicine_name,
    unit_price,
    stock_qty AS remaining_stock
FROM medicines
WHERE stock_qty < 10;


CALL pr_record_sale(2, 3, CURDATE());

SELECT * FROM v_low_stock;