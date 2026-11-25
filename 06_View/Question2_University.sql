CREATE OR REPLACE VIEW v_fee_balances AS
SELECT
    s.student_number,
    s.full_name,
    s.fee_due - IFNULL(SUM(p.amount), 0) AS outstanding_balance
FROM students s
LEFT JOIN payments p
    ON p.student_id = s.student_id
GROUP BY
    s.student_id,
    s.student_number,
    s.full_name,
    s.fee_due
HAVING s.fee_due - IFNULL(SUM(p.amount), 0) > 0;

SELECT * FROM v_fee_balances;