DELIMITER $$

CREATE PROCEDURE pr_refresh_collections (
    IN p_day DATE
)
BEGIN
    INSERT INTO daily_collections (
        collection_date,
        payment_count,
        total_amount
    )
    SELECT
        DATE(p_day),
        COUNT(*),
        IFNULL(SUM(amount), 0)
    FROM payments
    WHERE paid_on = DATE(p_day)

    ON DUPLICATE KEY UPDATE
        payment_count = VALUES(payment_count),
        total_amount = VALUES(total_amount);
END$$

DELIMITER ;