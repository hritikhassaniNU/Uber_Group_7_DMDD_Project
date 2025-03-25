-- ============================================================
-- Sample Data Insert Script for Uber Ride Management System
-- ============================================================


DELETE FROM Trip_Status;
DELETE FROM Driver_Status;
DELETE FROM Vehicle;
DELETE FROM Trip;
DELETE FROM Surge_Pricing;
DELETE FROM Payment;
DELETE FROM Ride_Type;
DELETE FROM Customer;
DELETE FROM Driver;
DELETE FROM Status_Master;
COMMIT;

-----------------------------------------------------------
-- 1. Insert rows into Status_Master
-----------------------------------------------------------
-- Allowed values for "status" are:
INSERT INTO Status_Master (status, status_type) VALUES ('Requested',   'Trip');
INSERT INTO Status_Master (status, status_type) VALUES ('completed',   'Trip');
INSERT INTO Status_Master (status, status_type) VALUES ('In Progress', 'Trip');
INSERT INTO Status_Master (status, status_type) VALUES ('cancelled',   'Trip');
INSERT INTO Status_Master (status, status_type) VALUES ('Available',   'Driver');
INSERT INTO Status_Master (status, status_type) VALUES ('Offline',     'Driver');
INSERT INTO Status_Master (status, status_type) VALUES ('On Trip',     'Driver');
INSERT INTO Status_Master (status, status_type) VALUES ('Suspended',   'Driver');

-----------------------------------------------------------
-- 2. Insert rows into Payment
-----------------------------------------------------------
-- Payment_Method must be one of ('Card', 'Cash', 'EWallet', 'UPI')
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

-----------------------------------------------------------
-- 3. Insert rows into Customer
-----------------------------------------------------------
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Raj',      'Kumar',    9876543211, 'raj@gmail.com',      '101 Redwood St',    'Boston', '02101', 4.2);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Srikanth', 'Reddy',    9876543212, 'srikanth@outlook.com', '202 Maple Ave',     'Boston', '02102', 4.5);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Rahul',    'Patel',    9876543213, 'rahul@gamil.com',    '303 Oak Dr',        NULL,     '02103', 4.7);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Neha',     'Gupta',    9876543214, 'neha@gmail.com',     '404 Pine Rd',       'Boston', '02104', 4.3);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Anita',    'Shah',     9876543215, 'anita@outlook.com',    '505 Elm St',        NULL,     '02105', 4.0);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Vijay',    'Singh',    9876543216, 'vijay@gmail.com',    '606 Cedar Ln',      NULL,     '02106', 3.9);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Priya',    'Das',      9876543217, 'priya@gmail.com',    '707 Walnut Ave',    'Boston', '02107', 4.4);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES ('Arjun',    'Chauhan',  9876543218, 'arjun@outlook.com',    '808 Chestnut Ct',   NULL,     '02108', 4.6);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES('Sanya',    'Kapoor',   9876543219, 'sanya@outlook.com',    '909 Spruce Blvd',   NULL,     '02109', 4.8);
INSERT INTO Customer (first_name, last_name, phone_number, email, address_line_1, address_line_2, zipcode, rating)
VALUES('Vikram',   'Rao',      9876543220, 'vikram@gmail.com',   '1010 Redwood Pl',   NULL,     '02110', 4.1);

-----------------------------------------------------------
-- 4. Insert rows into Ride_Type
-----------------------------------------------------------
INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberX', 'Standard', 1.0);
INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberXL', 'Premium', 1.5);
INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberBlack', 'Luxury', 2.0);
INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberX', 'Premium', 1.5);
INSERT INTO Ride_Type (type, category, multiplier) VALUES ('Uber Electric', 'Green', 3);
INSERT INTO Ride_Type (type, category, multiplier) VALUES ('Comfort', 'Standard', 1.8);
INSERT INTO Ride_Type (type, category, multiplier) VALUES ('UberXXL', 'Luxury', 3);


-----------------------------------------------------------
-- 5. Insert rows into Surge_Pricing 
-----------------------------------------------------------
INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-24 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.5);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-24 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.6);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-24', 'Weekday', TO_DATE('2025-03-24 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-24 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.5);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-25 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.6);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-25', 'Weekday', TO_DATE('2025-03-25 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-25 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-26', 'Weekday', TO_DATE('2025-03-26 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.5);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-26', 'Weekday', TO_DATE('2025-03-26 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-26', 'Weekday', TO_DATE('2025-03-26 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.6);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-26', 'Weekday', TO_DATE('2025-03-26 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-27', 'Weekday', TO_DATE('2025-03-27 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.5);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-27', 'Weekday', TO_DATE('2025-03-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-27 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-27', 'Weekday', TO_DATE('2025-03-27 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-27 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.6);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-27', 'Weekday', TO_DATE('2025-03-27 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-27 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-28', 'Weekday', TO_DATE('2025-03-28 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-28 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.5);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-28', 'Weekday', TO_DATE('2025-03-28 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-28 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-28', 'Weekday', TO_DATE('2025-03-28 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-28 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.6);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-28', 'Weekday', TO_DATE('2025-03-28 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-28 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-29 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.8);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-29 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.1);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-29 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 2.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-29', 'Weekend', TO_DATE('2025-03-29 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-29 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.2);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-30', 'Weekend', TO_DATE('2025-03-30 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1.8);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-30', 'Weekend', TO_DATE('2025-03-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-30 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.1);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-30', 'Weekend', TO_DATE('2025-03-30 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-30 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 2.0);

INSERT INTO Surge_Pricing (surge_date, weekday_weekend, start_time, end_time, peak_off_peak, multiplier)
VALUES (DATE '2025-03-30', 'Weekend', TO_DATE('2025-03-30 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-30 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1.2);
