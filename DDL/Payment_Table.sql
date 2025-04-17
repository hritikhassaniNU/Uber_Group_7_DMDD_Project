-- Payment Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Payment CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Payment table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Payment table does not exist or cannot be dropped.');
    END;
    
    -- Create Payment table
    EXECUTE IMMEDIATE '
    CREATE TABLE Payment (
        payment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        amount NUMBER(4,2) CHECK (amount >= 0),
        payment_method VARCHAR2(15) NOT NULL 
            CHECK (payment_method IN (''Card'', ''Cash'', ''EWallet'', ''UPI'')),
        transcation_date DATE DEFAULT SYSDATE,
        created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        created_by VARCHAR2(50) DEFAULT USER,
        last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_by VARCHAR2(50) DEFAULT USER
    )';
    
    DBMS_OUTPUT.PUT_LINE('Payment table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Payment table: ' || SQLERRM);
        ROLLBACK;
END;
/