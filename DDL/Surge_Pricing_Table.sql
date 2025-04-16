-- Surge_Pricing Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Surge_Pricing CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Surge_Pricing table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Surge_Pricing table does not exist or cannot be dropped.');
    END;
    
    -- Create Surge_Pricing table
    EXECUTE IMMEDIATE '
    CREATE TABLE Surge_Pricing (
        surge_pricing_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        surge_date DATE NOT NULL,
        weekday_weekend VARCHAR2(10),
        start_time DATE NOT NULL,
        end_time DATE NOT NULL,
        peak_off_peak NUMBER(1) CHECK (peak_off_peak IN (0, 1)),
        multiplier NUMBER(2,1) NOT NULL CHECK (multiplier >= 1.0),
        created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        created_by VARCHAR2(50) DEFAULT USER,
        last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_by VARCHAR2(50) DEFAULT USER
    )';
    
    DBMS_OUTPUT.PUT_LINE('Surge_Pricing table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Surge_Pricing table: ' || SQLERRM);
        ROLLBACK;
END;
/
