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

-----------------------------------------------------------
-- 6. Insert rows into Driver
-----------------------------------------------------------
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Suraj',    'Kumar',    'suraj.kumar@gmail.com',   '9876543210', 'LIC1234567', 4.9);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Rohan',    'Gupta',    'rohan.gupta@hotmail.com', '1234567890', 'LIC7654321', 4.6);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Aditi',    'Singh',    'aditi.singh@outlook.com', '5556667777', 'LIC3333333', 4.8);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Meera',    'Sharma',   'meera.sharma@gmail.com',  '4445556666', 'LIC4444444', 4.7);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Kunal',    'Nair',     'kunal.nair@outlook.com',  '3334445555', 'LIC5555555', 4.5);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Reena',    'Kapoor',   'reena.kapoor@hotmail.com','2223334444', 'LIC6666666', 4.9);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Vikram',   'Chauhan',  'vikram.chauhan@gmail.com','1112223333', 'LIC7777777', 4.4);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Neha',     'Desai',    'neha.desai@outlook.com', '9998887777', 'LIC8888888', 4.6);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Rahul',    'Malhotra', 'rahul.malhotra@gmail.com','8887776666', 'LIC9999999', 4.3);
INSERT INTO Driver (first_name, last_name, email, phone_number, license_number, rating)
VALUES ('Priya',    'Rao',      'priya.rao@hotmail.com',  '7776665555', 'LIC1010101', 4.2);


-----------------------------------------------------------
-- 7. Insert rows into Trip
-- (References: Customer, Ride_Type, Surge_Pricing, Payment)
-----------------------------------------------------------

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, 
                  pricing_id, total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (1, 1, TO_DATE('2025-03-23 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-23 08:00:00', 'YYYY-MM-DD HH24:MI:SS'),  '123 Main St, Boston, MA', '02101', '456 Elm St, Boston, MA','02102', 5.50, 7.50, 1, 25.62, 1, 4.0, 
    'Smooth and pleasant ride', 4.3, 4.6,NULL, NULL, NULL);

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (2, 2, TO_DATE('2025-03-24 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-24 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), '200 Beacon St, Boston, MA', '02102', '300 Boylston St, Boston, MA', '02103', 6.25, 8.00, 2, 40.81, 2,
  5.0, 'Driver canceled due to illness; communication was clear', 5.0, 5.0, TO_DATE('2025-03-24 07:30:00', 'YYYY-MM-DD HH24:MI:SS'),'Driver', 'Driver was ill');

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (3, 3, TO_DATE('2025-03-25 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), '101 Summer St, Boston, MA', '02103', '202 Atlantic Ave, Boston, MA', '02104',4.75, 7.25, 3, 11.24, 3,
  4.0, 'Comfortable and efficient ride', 4.1, 4.4, NULL, NULL, NULL);

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (4, 4, TO_DATE('2025-03-26 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-26 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), '50 Winter St, Boston, MA', '02104', '75 Atlantic Ave, Boston, MA', '02105',
  8.00, 9.50, 4, 12.64, 4, 4.0, 'Customer canceled', 4.0, 4.0, TO_DATE('2025-03-24 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Customer', 'Customer changed mind');

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (5, 5, TO_DATE('2025-03-27 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), '120 Commonwealth Ave, Boston, MA', '02105', '85 Clarendon St, Boston, MA', '02106',
  7.30, 8.90, 5, 21.89, 5, 3.0, 'Average ride, need for improvement', 3.5, 3.1, NULL, NULL, NULL);

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (6, 6, TO_DATE('2025-03-28 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-28 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), '300 Washington St, Boston, MA', '02106', '400 Atlantic Ave, Boston, MA', '02107',
  8.10, 9.80, 6, 39.05, 6, 5.0, 'Professional service with a comfortable ride', 5.0, 5.0, NULL, NULL, NULL);

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (7, 7, TO_DATE('2025-03-29 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-29 13:00:00', 'YYYY-MM-DD HH24:MI:SS'),'60 Beacon St, Boston, MA', '02107', '75 Newbury St, Boston, MA', '02108',
  5.90, 8.20, 7, 11.53, 7, 4.0, 'Arrival delay caused cancellation', 4.0, 4.0, TO_DATE('2025-03-24 12:30:00', 'YYYY-MM-DD HH24:MI:SS'),'Customer', 'Cancelled due to unexpected delay');

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (8, 1, TO_DATE('2025-03-29 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-29 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '80 Tremont St, Boston, MA', '02108', '90 Boylston St, Boston, MA', '02109',
  4.25, 7.00, 8, 11.08, 8, 3.0, 'Ride was on time but vehicle could be cleaner', 3.0, 3.0, NULL, NULL, NULL);

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (9, 7, TO_DATE('2025-03-30 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-30 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), '250 Columbus Ave, Boston, MA', '02109', '300 Huntington Ave, Boston, MA', '02110', 3.50, 6.75, 9, 34.78, 9,
  4.0, 'Quick trip with friendly driver', 4.0, 4.0,NULL, NULL, NULL);

INSERT INTO Trip (customer_id, ride_type_id, start_time, end_time, pickup_location, pickup_zipcode, dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id, total_fare, payment_id, 
                  trip_rating, feedback, driver_rating, customer_rating, cancelled_at, cancelled_by, cancellation_reason)
VALUES (10, 5,TO_DATE('2025-03-30 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-03-30 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), '500 Massachusetts Ave, Boston, MA', '02110', '600 Cambridge St, Boston, MA', '02101', 6.00, 8.50, 10, 42.80, 10,
  5.0, 'Customer canceled for a cheaper alternative', 5.0, 5.0, TO_DATE('2025-03-24 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Customer', 'Customer found cheaper ride');

-----------------------------------------------------------
-- 8. Insert rows into Trip_Status
-----------------------------------------------------------
INSERT INTO Trip_Status (trip_id, status_id) VALUES (1, 2);  
INSERT INTO Trip_Status (trip_id, status_id) VALUES (2, 4);  
INSERT INTO Trip_Status (trip_id, status_id) VALUES (3, 3); 
INSERT INTO Trip_Status (trip_id, status_id) VALUES (4, 4);  
INSERT INTO Trip_Status (trip_id, status_id) VALUES (5, 2);  
INSERT INTO Trip_Status (trip_id, status_id) VALUES (6, 2);  
INSERT INTO Trip_Status (trip_id, status_id) VALUES (7, 4);  
INSERT INTO Trip_Status (trip_id, status_id) VALUES (8, 2);  
INSERT INTO Trip_Status (trip_id, status_id) VALUES (9, 3); 
INSERT INTO Trip_Status (trip_id, status_id) VALUES (10, 4); 

-----------------------------------------------------------
-- 9. Insert rows into Driver_Status
-----------------------------------------------------------
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (1, 5, '02101');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (2, 3, '02102');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (3, 7, '02103');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (4, 8, '02104');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (5, 5, '02105');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (6, 6, '02106');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (7, 7, '02107');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (8, 8, '02108');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (9, 5, '02109');  
INSERT INTO Driver_Status (driver_id, status_id, current_location) VALUES (10, 6, '02110'); 

-----------------------------------------------------------
-- 10. Insert rows into Vehicle
-----------------------------------------------------------
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
COMMIT;


-----------------------------------------
--Checking the data in tables
-----------------------------------------
-- SELECT * FROM Status_Master;
-- SELECT * FROM Payment;
-- SELECT * FROM Customer;
-- SELECT * FROM Ride_Type;
-- SELECT * FROM Surge_Pricing;
-- SELECT * FROM Driver;
-- SELECT * FROM Trip;
-- SELECT * FROM Trip_Status;
-- SELECT * FROM Driver_Status;
-- SELECT * FROM Vehicle;
