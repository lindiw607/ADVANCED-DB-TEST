SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE EVENT ev_refresh_collections
ON SCHEDULE EVERY 1 DAY
STARTS (
    CURRENT_DATE
    + INTERVAL 1 DAY
    + INTERVAL 1 HOUR
)
DO
    CALL pr_refresh_collections(
        CURRENT_DATE - INTERVAL 1 DAY
    )$$

DELIMITER ;