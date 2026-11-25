DELIMITER $$

CREATE PROCEDURE pr_record_sale (
    IN p_medicine_id INT,
    IN p_quantity    INT,
    IN p_sold_on     DATE
)
BEGIN
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_stock INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_quantity IS NULL OR p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be a positive number.';
    END IF;

    START TRANSACTION;

    SELECT unit_price, stock_qty
    INTO v_price, v_stock
    FROM medicines
    WHERE medicine_id = p_medicine_id
    FOR UPDATE;

    IF v_price IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unknown medicine.';
    END IF;

    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock.';
    END IF;

    INSERT INTO sales (
        medicine_id,
        quantity,
        unit_price,
        sold_on
    )
    VALUES (
        p_medicine_id,
        p_quantity,
        v_price,
        IFNULL(p_sold_on, CURDATE())
    );

    UPDATE medicines
    SET stock_qty = stock_qty - p_quantity
    WHERE medicine_id = p_medicine_id;

    COMMIT;
END$$

DELIMITER ;