CREATE INDEX idx_payments_student_paid
ON payments (student_id, paid_on);

EXPLAIN
SELECT
    payment_id,
    amount,
    paid_on
FROM payments
WHERE student_id = 1
AND paid_on BETWEEN '2026-11-01' AND '2026-11-30';