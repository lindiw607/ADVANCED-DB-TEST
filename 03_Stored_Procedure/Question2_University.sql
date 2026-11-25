DELIMITER $$

CREATE PROCEDURE pr_receive_payment (
    IN p_student_id INT,
    IN p_amount     DECIMAL(12,2),
    IN p_paid_on    DATE
)
BEGIN
    DECLARE v_fee     DECIMAL(12,2);
    DECLARE v_balance DECIMAL(12,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Amount must be greater than zero.';
    END IF;

    START TRANSACTION;

    SELECT fee_due
    INTO v_fee
    FROM students
    WHERE student_id = p_student_id
    FOR UPDATE;

    IF v_fee IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unknown student.';
    END IF;

    SET v_balance = fn_fee_balance(p_student_id);

    IF p_amount > v_balance THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment exceeds outstanding balance.';
    END IF;

    INSERT INTO payments (
        student_id,
        amount,
        paid_on
    )
    VALUES (
        p_student_id,
        p_amount,
        IFNULL(p_paid_on, CURDATE())
    );

    COMMIT;
END$$

DELIMITER ;