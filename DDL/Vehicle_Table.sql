-- Vehicle Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Vehicle CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Vehicle table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Vehicle table does not exist or cannot be dropped.');
    END;
    
    -- Create Vehicle table
    EXECUTE IMMEDIATE '
    CREATE TABLE Vehicle (
        vehicle_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        driver_id INTEGER NOT NULL,
        ride_type_id INTEGER NOT NULL,
        model VARCHAR2(20),
        make VARCHAR2(20) NOT NULL,
        year INTEGER NOT NULL,
        license_plate_number VARCHAR2(10) UNIQUE NOT NULL,
        created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        created_by VARCHAR2(50) DEFAULT USER,
        updated_by VARCHAR2(255) DEFAULT USER,
        FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
        FOREIGN KEY (ride_type_id) REFERENCES Ride_Type(ride_type_id)
    )';
    
    DBMS_OUTPUT.PUT_LINE('Vehicle table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Vehicle table: ' || SQLERRM);
        ROLLBACK;
END;
/