-- Driver Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Driver;
    DBMS_OUTPUT.PUT_LINE('Existing Driver data cleared.');
    
    -- Insert Driver data
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Suraj', 'Kumar', 'suraj.kumar@gmail.com', '9876543210', 'LIC1234567', 4.9);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Rohan', 'Gupta', 'rohan.gupta@hotmail.com', '1234567890', 'LIC7654321', 4.6);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Aditi', 'Singh', 'aditi.singh@outlook.com', '5556667777', 'LIC3333333', 4.8);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Meera', 'Sharma', 'meera.sharma@gmail.com', '4445556666', 'LIC4444444', 4.7);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Kunal', 'Nair', 'kunal.nair@outlook.com', '3334445555', 'LIC5555555', 4.5);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Reena', 'Kapoor', 'reena.kapoor@hotmail.com', '2223334444', 'LIC6666666', 4.9);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Vikram', 'Chauhan', 'vikram.chauhan@gmail.com', '1112223333', 'LIC7777777', 4.4);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Neha', 'Desai', 'neha.desai@outlook.com', '9998887777', 'LIC8888888', 4.6);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Rahul', 'Malhotra', 'rahul.malhotra@gmail.com', '8887776666', 'LIC9999999', 4.3);
    
    INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
    VALUES ('Priya', 'Rao', 'priya.rao@hotmail.com', '7776665555', 'LIC1010101', 4.2);
    
    DBMS_OUTPUT.PUT_LINE('Driver data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Driver data: ' || SQLERRM);
        ROLLBACK;
END;
/
