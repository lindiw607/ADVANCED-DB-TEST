DELIMITER $$

CREATE TRIGGER trg_payments_audit
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    INSERT INTO payment_audit (
        payment_id,
        student_id,
        amount,
        logged_at
    )
    VALUES (
        NEW.payment_id,
        NEW.student_id,
        NEW.amount,
        NOW()
    );
END$$

DELIMITER ;