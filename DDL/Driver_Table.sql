-- Driver Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Driver CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Driver table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Driver table does not exist or cannot be dropped.');
    END;
    
    -- Create Driver table
    EXECUTE IMMEDIATE '
    CREATE TABLE Driver (
        driver_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        first_name VARCHAR2(50) NOT NULL,
        last_name VARCHAR2(50) NOT NULL,
        email VARCHAR2(50) UNIQUE NOT NULL,
        phone_number VARCHAR2(10) UNIQUE NOT NULL,
        license_number VARCHAR2(10) UNIQUE NOT NULL,
        rating NUMBER(2,1) CHECK (rating BETWEEN 0 AND 5),
        created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        created_by VARCHAR2(50) DEFAULT USER,
        last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_by VARCHAR2(255) DEFAULT USER
    )';
    
    DBMS_OUTPUT.PUT_LINE('Driver table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Driver table: ' || SQLERRM);
        ROLLBACK;
END;
/