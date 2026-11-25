DELIMITER $$

CREATE TRIGGER trg_medicines_stock_audit
AFTER UPDATE ON medicines
FOR EACH ROW
BEGIN
    IF OLD.stock_qty <> NEW.stock_qty THEN
        INSERT INTO stock_audit (
            medicine_id,
            old_qty,
            new_qty,
            changed_at
        )
        VALUES (
            NEW.medicine_id,
            OLD.stock_qty,
            NEW.stock_qty,
            NOW()
        );
    END IF;
END$$

DELIMITER ;