-- Customer Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Customer CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Customer table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Customer table does not exist or cannot be dropped.');
    END;
    
    -- Create Customer table
    EXECUTE IMMEDIATE '
    CREATE TABLE Customer (
        customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        first_name VARCHAR2(50) NOT NULL,
        last_name VARCHAR2(50) UNIQUE NOT NULL,
        phone_number INTEGER UNIQUE NOT NULL,
        email VARCHAR2(100) UNIQUE NOT NULL,
        address_line_1 VARCHAR2(100),
        address_line_2 VARCHAR2(100),
        zipcode VARCHAR2(10),
        rating NUMBER(2,1),
        created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        created_by VARCHAR2(50) DEFAULT USER,
        last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_by VARCHAR2(50) DEFAULT USER
    )';
    
    DBMS_OUTPUT.PUT_LINE('Customer table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Customer table: ' || SQLERRM);
        ROLLBACK;
END;
/
