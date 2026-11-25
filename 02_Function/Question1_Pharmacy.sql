DELIMITER $$

CREATE FUNCTION fn_sale_value (
    p_medicine_id INT,
    p_quantity INT
)
RETURNS DECIMAL(12,2)
READS SQL DATA
BEGIN
    DECLARE v_price DECIMAL(10,2);

    IF p_quantity IS NULL OR p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be a positive number.';
    END IF;

    SELECT unit_price
    INTO v_price
    FROM medicines
    WHERE medicine_id = p_medicine_id;

    IF v_price IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unknown medicine.';
    END IF;

    RETURN v_price * p_quantity;
END$$

DELIMITER ;