-- Vehicle Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Vehicle;
    DBMS_OUTPUT.PUT_LINE('Existing Vehicle data cleared.');
    
    -- Insert Vehicle data
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (1, 1, 'Corolla', 'Toyota', 2020, 'PLT001');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (2, 2, 'Civic', 'Honda', 2019, 'PLT002');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (3, 3, 'Model S', 'Tesla', 2021, 'PLT003');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (4, 4, 'Swift', 'Maruti', 2018, 'PLT004');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (5, 5, 'Maruti Nexus', 'Maruti', 2020, 'PLT005');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (6, 6, 'Camry', 'Toyota', 2017, 'PLT006');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (7, 7, 'Verna', 'Hyundai', 2021, 'PLT007');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (8, 1, 'Accord', 'Honda', 2019, 'PLT008');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (9, 7, 'Fortuner', 'Toyota', 2022, 'PLT009');
    
    INSERT INTO Vehicle (driver_id, ride_type_id, model, make, year, license_plate_number)
    VALUES (10, 5, 'Nexon EV', 'Tata', 2023, 'PLT010');
    
    DBMS_OUTPUT.PUT_LINE('Vehicle data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Vehicle data: ' || SQLERRM);
        ROLLBACK;
END;
/