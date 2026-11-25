-- Check all students
SELECT * FROM students;

-- Check all payments
SELECT * FROM payments;

-- Check payment audit records
SELECT * FROM payment_audit;

-- Check students with outstanding balances
SELECT * FROM v_fee_balances;

-- Test the fee balance function
SELECT fn_fee_balance(1);

SELECT fn_fee_balance(3);

-- Check daily collections summary
SELECT * FROM daily_collections;

-- Test refreshing daily collections
CALL pr_refresh_collections('2026-11-22');

-- Run it again to confirm it does not double-count
CALL pr_refresh_collections('2026-11-22');

SELECT * FROM daily_collections;

-- Check the index query plan
EXPLAIN
SELECT
    payment_id,
    amount,
    paid_on
FROM payments
WHERE student_id = 1
AND paid_on BETWEEN '2026-11-01' AND '2026-11-30';

-- Check scheduled events
SHOW EVENTS;