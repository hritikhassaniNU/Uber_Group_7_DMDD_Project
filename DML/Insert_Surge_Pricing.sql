-- Surge_Pricing Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Surge_Pricing;
    DBMS_OUTPUT.PUT_LINE('Existing Surge_Pricing data cleared.');
    
    -- Insert Surge_Pricing data
    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-24 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.5);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-24 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.6);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-24 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.5);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-25 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.6);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-25 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);
    
    -- Weekends have different patterns
    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-29 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.8);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-29 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.1);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-29 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 2.0);

    INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
    VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_DATE('2025-03-29 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.2);
    
    DBMS_OUTPUT.PUT_LINE('Surge_Pricing data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Surge_Pricing data: ' || SQLERRM);
        ROLLBACK;
END;
/