CREATE INDEX idx_sales_med_sold
ON sales (medicine_id, sold_on);

EXPLAIN
SELECT
    sale_id,
    quantity,
    unit_price,
    sold_on
FROM sales
WHERE medicine_id = 1
AND sold_on BETWEEN '2026-11-01' AND '2026-11-30';