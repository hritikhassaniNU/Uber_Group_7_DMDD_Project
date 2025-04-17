-- Trip_Status Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Trip_Status;
    DBMS_OUTPUT.PUT_LINE('Existing Trip_Status data cleared.');
    
    -- Insert Trip_Status data
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (1, 2); -- completed
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (2, 4); -- cancelled
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (3, 3); -- In Progress
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (4, 4); -- cancelled
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (5, 2); -- completed
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (6, 2); -- completed
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (7, 4); -- cancelled
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (8, 2); -- completed
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (9, 3); -- In Progress
    INSERT INTO Trip_Status (trip_id, status_id) VALUES (10, 4); -- cancelled
    
    DBMS_OUTPUT.PUT_LINE('Trip_Status data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Trip_Status data: ' || SQLERRM);
        ROLLBACK;
END;
/