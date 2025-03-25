-- Drop tables in child-to-parent order
DROP TABLE Trip_Status CASCADE CONSTRAINTS;
DROP TABLE Driver_Status CASCADE CONSTRAINTS;
DROP TABLE Vehicle CASCADE CONSTRAINTS;
DROP TABLE Trip CASCADE CONSTRAINTS;
DROP TABLE Surge_Pricing CASCADE CONSTRAINTS;
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Ride_Type CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Driver CASCADE CONSTRAINTS;
DROP TABLE Status_Master CASCADE CONSTRAINTS;


ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR HH24:MI:SS';

-- 1. Status_Master
CREATE TABLE Status_Master (
    status_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    status VARCHAR2(15) DEFAULT 'Offline'
           CHECK (status IN ('Requested', 'completed', 'In Progress', 'cancelled', 'Available', 'Offline',
               'On Trip','Suspended')),
    status_type VARCHAR2(15) NOT NULL
);


-- 2. Payment
CREATE TABLE Payment (
    payment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    amount NUMBER(4,2) CHECK (amount >= 0),
    payment_method VARCHAR2(15) NOT NULL 
        CHECK (payment_method IN ('Card', 'Cash', 'EWallet', 'UPI')),
    transcation_date DATE DEFAULT SYSDATE,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by VARCHAR2(50) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
);

-- 3. Customer
CREATE TABLE Customer (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) UNIQUE NOT NULL,
    phone_number INTEGER UNIQUE NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    address_line_1 VARCHAR2(100),
    address_line_2 VARCHAR2(100),
    zipcode VARCHAR2(10),
    rating NUMBER(2,1),
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by VARCHAR2(50) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
);

-- 4. Ride_Type
CREATE TABLE Ride_Type (
    ride_type_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR2(50) NOT NULL,
    category VARCHAR2(20),
    multiplier NUMBER(2,1)
);

-- 5. Surge_Pricing
CREATE TABLE Surge_Pricing (
    surge_pricing_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    surge_date DATE NOT NULL,
    weekday_weekend VARCHAR2(10),
    start_time DATE NOT NULL,
    end_time DATE NOT NULL,
    peak_off_peak NUMBER(1) CHECK (peak_off_peak IN (0, 1)),
    multiplier NUMBER(2,1) NOT NULL CHECK (multiplier >= 1.0),
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by VARCHAR2(50) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
);

-- 6. Driver
CREATE TABLE Driver (
    driver_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(50) UNIQUE NOT NULL,
    phone_number VARCHAR2(10) UNIQUE NOT NULL,
    license_number VARCHAR2(10) UNIQUE NOT NULL,
    rating NUMBER(2,1) CHECK (rating BETWEEN 0 AND 5),
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by VARCHAR2(255) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
);


-- 7. Trip
CREATE TABLE Trip (
    trip_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    ride_type_id INTEGER NOT NULL,
    start_time DATE,
    end_time DATE,
    pickup_location VARCHAR2(100),
    pickup_zipcode INTEGER NOT NULL,
    dropoff_location VARCHAR2(100),
    dropoff_zipcode INTEGER NOT NULL,
    distance_miles NUMBER(5,2) CHECK (distance_miles >= 0),
    base_fare NUMBER(4,2) CHECK (base_fare >= 0),
    pricing_id INTEGER,
    total_fare NUMBER(4,2) CHECK (total_fare >= 0),
    payment_id INTEGER,
    trip_rating NUMBER(2,1) CHECK (trip_rating BETWEEN 0 AND 5),
    feedback VARCHAR2(400),
    driver_rating NUMBER(2,1) CHECK (driver_rating BETWEEN 0 AND 5),
    customer_rating NUMBER(2,1) CHECK (customer_rating BETWEEN 0 AND 5),
    cancelled_at DATE,
    cancelled_by VARCHAR2(50),
    cancellation_reason VARCHAR2(400),
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by VARCHAR2(50) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER'),

    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (ride_type_id) REFERENCES Ride_Type(ride_type_id),
    FOREIGN KEY (pricing_id) REFERENCES Surge_Pricing(surge_pricing_id),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);

-- 8. Trip_Status
CREATE TABLE Trip_Status (
    trip_status_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trip_id INTEGER,
    status_id INTEGER,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,

    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id),
    FOREIGN KEY (status_id) REFERENCES Status_Master(status_id)
);

-- 9. Driver_Status
CREATE TABLE Driver_Status (
    driver_status_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    driver_id INTEGER NOT NULL,
    status_id INTEGER NOT NULL,
    current_location INTEGER NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by VARCHAR2(50) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER'),

    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY (status_id) REFERENCES Status_Master(status_id)
);

-- 10. Vehicle
CREATE TABLE Vehicle (
    vehicle_id INTEGER GENERATED ALWAYS AS IDENTITY ,
    driver_id INTEGER NOT NULL,
    ride_type_id INTEGER NOT NULL,
    model VARCHAR2(20),
    make VARCHAR2(20) NOT NULL,
    year INTEGER NOT NULL,
    license_plate_number VARCHAR2(10) UNIQUE NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by VARCHAR2(255) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER'),
    PRIMARY KEY (vehicle_id, ride_type_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY (ride_type_id) REFERENCES Ride_Type(ride_type_id)
);

--------------------------------
-- UBER DRIVER ROLE GRANTS
--------------------------------
-- Allow Uber_Driver to read trip records and update status-related fields
GRANT SELECT, UPDATE ON Trip TO Uber_Driver;

-- Allow Uber_Driver to view ride status history
GRANT SELECT, INSERT ON Trip_Status TO Uber_Driver;

-- Allow Uber_Driver to view payment/earnings info
GRANT SELECT ON Payment TO Uber_Driver;

GRANT SELECT ON Vehicle TO Uber_Driver;


------------------------------------
-- APP CUSTOMER ROLE GRANTS
-------------------------------------
-- Allow App_Customer to book a trip (insert)
GRANT INSERT ON Trip TO App_Customer;

-- Allow App_Customer to manage their own customer data
GRANT INSERT, UPDATE, SELECT ON Customer TO App_Customer;

-- Allow App_Customer to cancel their ride
GRANT UPDATE (cancelled_at, cancelled_by, cancellation_reason, updated_by, driver_rating,trip_rating) ON Trip TO App_Customer;

-- Allow App_Customer to view trip and trip status history
GRANT SELECT ON Trip TO App_Customer;
GRANT SELECT ON Trip_Status TO App_Customer;

-- Allow App_Customer to view driver info
GRANT SELECT ON Driver TO App_Customer;

-- Allow App_Customer to make and view payment
GRANT INSERT, SELECT ON Payment TO App_Customer;

---------------------------------------
-- CUSTOMER SUPPORT TEAM ROLE GRANTS
---------------------------------------
-- Allow Support_Team to read and update trip for dispute handling
GRANT SELECT, UPDATE (trip_rating, feedback, cancellation_reason, updated_by) ON Trip TO Support_Team;

-- Allow Support_Team to view trip status history
GRANT SELECT ON Trip_Status TO Support_Team;

-- Allow Support_Team to view customer info
GRANT SELECT ON Customer TO Support_Team;

---------------------------------------
-- FLEET MANAGEMENT TEAM ROLE GRANTS
---------------------------------------
-- Allow Fleet_Management to view and update driver records
GRANT SELECT, UPDATE (rating, phone_number, email, updated_by) ON Driver TO Fleet_Management;

-- Allow Fleet_Management to monitor driver locations/status
GRANT SELECT ON Driver_Status TO Fleet_Management;

COMMIT;