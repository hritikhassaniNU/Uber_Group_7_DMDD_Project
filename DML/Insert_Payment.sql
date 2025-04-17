-- Payment Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Payment;
    DBMS_OUTPUT.PUT_LINE('Existing Payment data cleared.');
    
    -- Insert Payment data
    INSERT INTO Payment (amount, payment_method) VALUES (25.62, 'EWallet');
    INSERT INTO Payment (amount, payment_method) VALUES (40.81, 'EWallet');
    INSERT INTO Payment (amount, payment_method) VALUES (11.24, 'Cash');
    INSERT INTO Payment (amount, payment_method) VALUES (12.64, 'Card');
    INSERT INTO Payment (amount, payment_method) VALUES (21.89, 'Card');
    INSERT INTO Payment (amount, payment_method) VALUES (39.05, 'EWallet');
    INSERT INTO Payment (amount, payment_method) VALUES (11.53, 'Cash');
    INSERT INTO Payment (amount, payment_method) VALUES (11.08, 'UPI');
    INSERT INTO Payment (amount, payment_method) VALUES (34.78, 'Card');
    INSERT INTO Payment (amount, payment_method) VALUES (42.80, 'EWallet');
    
    DBMS_OUTPUT.PUT_LINE('Payment data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Payment data: ' || SQLERRM);
        ROLLBACK;
END;
/