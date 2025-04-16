-- Ride_Type Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Ride_Type CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Ride_Type table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ride_Type table does not exist or cannot be dropped.');
    END;
    
    -- Create Ride_Type table
    EXECUTE IMMEDIATE '
    CREATE TABLE Ride_Type (
        ride_type_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        type VARCHAR2(50) NOT NULL,
        category VARCHAR2(20),
        multiplier NUMBER(2,1)
    )';
    
    DBMS_OUTPUT.PUT_LINE('Ride_Type table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Ride_Type table: ' || SQLERRM);
        ROLLBACK;
END;
/