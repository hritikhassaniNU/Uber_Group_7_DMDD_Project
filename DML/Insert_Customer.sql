-- Customer Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Customer;
    DBMS_OUTPUT.PUT_LINE('Existing Customer data cleared.');
    
    -- Insert Customer data
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Raj', 'Kumar', 9876543211, 'raj@gmail.com', '101 Redwood St', 'Boston', '02101', 4.2);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Srikanth', 'Reddy', 9876543212, 'srikanth@outlook.com', '202 Maple Ave', 'Boston', '02102', 4.5);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Rahul', 'Patel', 9876543213, 'rahul@gamil.com', '303 Oak Dr', NULL, '02103', 4.7);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Neha', 'Gupta', 9876543214, 'neha@gmail.com', '404 Pine Rd', 'Boston', '02104', 4.3);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Anita', 'Shah', 9876543215, 'anita@outlook.com', '505 Elm St', NULL, '02105', 4.0);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Vijay', 'Singh', 9876543216, 'vijay@gmail.com', '606 Cedar Ln', NULL, '02106', 3.9);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Priya', 'Das', 9876543217, 'priya@gmail.com', '707 Walnut Ave', 'Boston', '02107', 4.4);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Arjun', 'Chauhan', 9876543218, 'arjun@outlook.com', '808 Chestnut Ct', NULL, '02108', 4.6);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Sanya', 'Kapoor', 9876543219, 'sanya@outlook.com', '909 Spruce Blvd', NULL, '02109', 4.8);
    
    INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
    VALUES ('Vikram', 'Rao', 9876543220, 'vikram@gmail.com', '1010 Redwood Pl', NULL, '02110', 4.1);
    
    DBMS_OUTPUT.PUT_LINE('Customer data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Customer data: ' || SQLERRM);
        ROLLBACK;
END;
/