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

