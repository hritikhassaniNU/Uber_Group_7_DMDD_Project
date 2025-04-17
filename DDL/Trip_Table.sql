-- Trip Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Trip CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Trip table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Trip table does not exist or cannot be dropped.');
    END;
    
    -- Create Trip table
    EXECUTE IMMEDIATE '
    CREATE TABLE Trip (
        trip_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        customer_id INTEGER NOT NULL,
        vehicle_id INTEGER ,
        start_time DATE,
        end_time DATE,
        pickup_location VARCHAR2(100) NOT NULL,
        pickup_zipcode INTEGER NOT NULL,
        dropoff_location VARCHAR2(100) NOT NULL,
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
        created_by VARCHAR2(50) DEFAULT USER,
        last_updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_by VARCHAR2(50) DEFAULT USER,
        
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
        FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id),
        FOREIGN KEY (pricing_id) REFERENCES Surge_Pricing(surge_pricing_id),
        FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
    )';
    
    DBMS_OUTPUT.PUT_LINE('Trip table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Trip table: ' || SQLERRM);
        ROLLBACK;
END;
/