CREATE OR REPLACE VIEW VW_DRIVER_CURRENT_STATUS AS
SELECT 
    d.driver_id,
    d.first_name,
    d.last_name,
    sm.status AS current_status,
    d.email,
    d.phone_number,
    d.license_number,
    d.rating,
    d.created_at AS driver_created_at,
    d.last_updated_at AS driver_last_updated_at,
    ds.current_location,
    ds.created_at AS status_created_at
FROM (
    SELECT ds.*,
           ROW_NUMBER() OVER (PARTITION BY ds.driver_id ORDER BY ds.created_at DESC) AS rn
    FROM DRIVER_STATUS ds
) ds
JOIN DRIVER d ON ds.driver_id = d.driver_id
JOIN STATUS_MASTER sm ON ds.status_id = sm.status_id
WHERE ds.rn = 1;