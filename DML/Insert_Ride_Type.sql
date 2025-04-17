-- Ride_Type Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Ride_Type;
    DBMS_OUTPUT.PUT_LINE('Existing Ride_Type data cleared.');
    
    -- Insert Ride_Type data
    INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberX', 'Standard', 1.0);
    INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberXL', 'Premium', 1.5);
    INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberBlack', 'Luxury', 2.0);
    INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberEco', 'Premium', 1.5);
    INSERT INTO Ride_Type (type, category, multiplier) VALUES ('Uber Electric', 'Green', 3.0);
    INSERT INTO Ride_Type (type, category, multiplier) VALUES ('Comfort', 'Standard', 1.8);
    INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberXXL', 'Luxury', 3.0);
    
    DBMS_OUTPUT.PUT_LINE('Ride_Type data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Ride_Type data: ' || SQLERRM);
        ROLLBACK;
END;
/