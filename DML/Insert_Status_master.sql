-- Status_Master Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Status_Master;
    DBMS_OUTPUT.PUT_LINE('Existing Status_Master data cleared.');
    
    -- Insert Status_Master data
    INSERT INTO Status_Master (status, status_type) VALUES ('Requested', 'Trip');
    INSERT INTO Status_Master (status, status_type) VALUES ('completed', 'Trip');
    INSERT INTO Status_Master (status, status_type) VALUES ('In Progress', 'Trip');
    INSERT INTO Status_Master (status, status_type) VALUES ('cancelled', 'Trip');
    INSERT INTO Status_Master (status, status_type) VALUES ('Available', 'Driver');
    INSERT INTO Status_Master (status, status_type) VALUES ('Offline', 'Driver');
    INSERT INTO Status_Master (status, status_type) VALUES ('On Trip', 'Driver');
    INSERT INTO Status_Master (status, status_type) VALUES ('Suspended', 'Driver');
    
    DBMS_OUTPUT.PUT_LINE('Status_Master data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Status_Master data: ' || SQLERRM);
        ROLLBACK;
END;
/