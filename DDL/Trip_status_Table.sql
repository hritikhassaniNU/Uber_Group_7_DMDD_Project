-- Trip_Status Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Trip_Status CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Trip_Status table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Trip_Status table does not exist or cannot be dropped.');
    END;
    
    -- Create Trip_Status table
    EXECUTE IMMEDIATE '
    CREATE TABLE Trip_Status (
        trip_status_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        trip_id INTEGER,
        status_id INTEGER,
        created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        created_by VARCHAR2(50) DEFAULT USER,
        last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        FOREIGN KEY (trip_id) REFERENCES Trip(trip_id),
        FOREIGN KEY (status_id) REFERENCES Status_Master(status_id)
    )';
    
    DBMS_OUTPUT.PUT_LINE('Trip_Status table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Trip_Status table: ' || SQLERRM);
        ROLLBACK;
END;
/