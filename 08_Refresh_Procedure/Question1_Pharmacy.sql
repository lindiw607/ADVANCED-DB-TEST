DELIMITER $$

CREATE PROCEDURE pr_refresh_sales (
    IN p_day DATE
)
BEGIN
    INSERT INTO daily_sales (
        sales_date,
        total_qty,
        total_amount
    )
    SELECT
        DATE(p_day),
        IFNULL(SUM(quantity), 0),
        IFNULL(SUM(quantity * unit_price), 0)
    FROM sales
    WHERE sold_on = DATE(p_day)

    ON DUPLICATE KEY UPDATE
        total_qty = VALUES(total_qty),
        total_amount = VALUES(total_amount);
END$$

DELIMITER ;