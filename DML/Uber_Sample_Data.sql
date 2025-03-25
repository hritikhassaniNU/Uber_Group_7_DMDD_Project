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
COMMIT;

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
--COMMIT;
