DELIMITER $$

CREATE FUNCTION fn_fee_balance (p_student_id INT)
RETURNS DECIMAL(12,2)
READS SQL DATA
BEGIN
    DECLARE v_fee DECIMAL(12,2);
    DECLARE v_paid DECIMAL(12,2);

    SELECT fee_due INTO v_fee
    FROM students
    WHERE student_id = p_student_id;

    IF v_fee IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unknown student.';
    END IF;

    SELECT IFNULL(SUM(amount), 0) INTO v_paid
    FROM payments
    WHERE student_id = p_student_id;

    RETURN v_fee - v_paid;
END$$

DELIMITER ;