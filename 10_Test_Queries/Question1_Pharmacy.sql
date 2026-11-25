-- Check medicines and remaining stock
SELECT * FROM medicines;

-- Check all recorded sales
SELECT * FROM sales;

-- Check stock audit records
SELECT * FROM stock_audit;

-- Check the low-stock view
SELECT * FROM v_low_stock;

-- Test the sales function
SELECT fn_sale_value(1, 5);

-- Check daily sales summary
SELECT * FROM daily_sales;

-- Test refreshing the daily sales summary
CALL pr_refresh_sales('2026-11-22');

-- Run it again to confirm it does not double-count
CALL pr_refresh_sales('2026-11-22');

SELECT * FROM daily_sales;

-- Check the index query plan
EXPLAIN
SELECT
    sale_id,
    quantity,
    unit_price,
    sold_on
FROM sales
WHERE medicine_id = 1
AND sold_on BETWEEN '2026-11-01' AND '2026-11-30';

-- Check scheduled events
SHOW EVENTS;