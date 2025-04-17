-- Driver_Status Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Driver_Status CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Driver_Status table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Driver_Status table does not exist or cannot be dropped.');
    END;
    
    -- Create Driver_Status table
    EXECUTE IMMEDIATE '
    CREATE TABLE Driver_Status (
        driver_status_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        driver_id INTEGER NOT NULL,
        status_id INTEGER NOT NULL,
        current_location INTEGER NOT NULL,
        created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        created_by VARCHAR2(50) DEFAULT USER,
        last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_by VARCHAR2(50) DEFAULT USER,
        FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
        FOREIGN KEY (status_id) REFERENCES Status_Master(status_id)
    )';
    
    DBMS_OUTPUT.PUT_LINE('Driver_Status table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Driver_Status table: ' || SQLERRM);
        ROLLBACK;
END;
/