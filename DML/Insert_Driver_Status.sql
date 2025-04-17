-- Driver_Status Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Driver_Status;
    DBMS_OUTPUT.PUT_LINE('Existing Driver_Status data cleared.');
    
    -- Insert Driver_Status data
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (1, 5, 2101); -- Available
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (2, 7, 2102); -- On Trip
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (3, 7, 2103); -- On Trip
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (4, 8, 2104); -- Suspended
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (5, 5, 2105); -- Available
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (6, 6, 2106); -- Offline
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (7, 7, 2107); -- On Trip
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (8, 8, 2108); -- Suspended
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (9, 5, 2109); -- Available
    INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (10, 6, 2110); -- Offline
    
    DBMS_OUTPUT.PUT_LINE('Driver_Status data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Driver_Status data: ' || SQLERRM);
        ROLLBACK;
END;
/