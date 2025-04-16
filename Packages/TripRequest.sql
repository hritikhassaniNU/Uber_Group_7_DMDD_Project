CREATE OR REPLACE PACKAGE pkg_trip_request AS
  PROCEDURE create_trip (
    p_customer_id         IN NUMBER,
    p_pickup_location     IN VARCHAR2,
    p_dropoff_location    IN VARCHAR2,
    p_pickup_zipcode      IN INTEGER,
    p_dropoff_zipcode     IN INTEGER,
    p_ride_type_id        IN NUMBER,
    p_trip_id             OUT NUMBER
  );
  
  PROCEDURE assign_driver_to_trip (
    p_trip_id       IN  NUMBER,
    p_ride_type_id  IN  NUMBER,
    p_driver_id     OUT NUMBER
);
END pkg_trip_request;
/


-- Package Body

CREATE OR REPLACE PACKAGE BODY pkg_trip_request AS
PROCEDURE create_trip (
    p_customer_id         IN NUMBER,
    p_pickup_location     IN VARCHAR2,
    p_dropoff_location    IN VARCHAR2,
    p_pickup_zipcode      IN INTEGER,
    p_dropoff_zipcode     IN INTEGER,
    p_ride_type_id        IN NUMBER,
    p_trip_id             OUT NUMBER
  ) IS
    v_distance_miles     NUMBER(5,2);
    v_price_per_mile     NUMBER(5,2);
    v_base_fare          NUMBER(6,2);
    v_surge_multiplier   NUMBER(3,2);
    v_total_fare         NUMBER(6,2);
    v_status_id          NUMBER(2);
    v_trip_time          TIMESTAMP := SYSTIMESTAMP;
    v_driver_id          NUMBER;

    -- Custom exceptions
    ex_invalid_input      EXCEPTION;
    ex_customer_not_found EXCEPTION;
    ex_ride_type_not_found EXCEPTION;
    ex_status_not_found   EXCEPTION;
  BEGIN
    -- Input validation
    IF p_customer_id IS NULL OR p_ride_type_id IS NULL THEN
        RAISE ex_invalid_input;
    END IF;

    -- Validate customer_id
    BEGIN
        SELECT 1 INTO v_status_id
        FROM CUSTOMER
        WHERE customer_id = p_customer_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE ex_customer_not_found;
    END;

    -- Validate ride_type_id and get price_per_mile
    BEGIN
        SELECT multiplier INTO v_price_per_mile
        FROM RIDE_TYPE
        WHERE ride_type_id = p_ride_type_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE ex_ride_type_not_found;
    END;

    -- Generate random distance between 2 and 10 miles
    v_distance_miles := ROUND(DBMS_RANDOM.VALUE(2, 10), 2);

    -- Calculate base fare
    v_base_fare := ROUND(v_price_per_mile * v_distance_miles, 2);

    -- Get surge multiplier based on trip time
    BEGIN
        v_surge_multiplier := get_surge_multiplier(v_trip_time);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error fetching surge multiplier: ' || SQLERRM);
            RETURN;
    END;

    -- Calculate total fare
    v_total_fare := ROUND(v_base_fare * v_surge_multiplier, 2);

    -- Insert into TRIP and return generated trip_id (omit created_at etc.)
    BEGIN
        INSERT INTO TRIP (
            CUSTOMER_ID, PICKUP_LOCATION, DROPOFF_LOCATION,
            PICKUP_ZIPCODE, DROPOFF_ZIPCODE, DISTANCE_MILES,
            BASE_FARE, TOTAL_FARE, UPDATED_BY
        ) VALUES (
            p_customer_id, p_pickup_location, p_dropoff_location,
            p_pickup_zipcode, p_dropoff_zipcode, v_distance_miles,
            v_base_fare, v_total_fare, 'System'
        )
        RETURNING trip_id INTO p_trip_id;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting trip record: ' || SQLERRM);
            RETURN;
    END;

    -- Get status ID for 'REQUESTED'
    BEGIN
        SELECT STATUS_ID INTO v_status_id
        FROM STATUS_MASTER
        WHERE UPPER(STATUS_TYPE) = 'TRIP'
          AND UPPER(STATUS) = 'REQUESTED';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE ex_status_not_found;
    END;

    -- Insert into TRIP_STATUS (omit created_at etc.)
    BEGIN
        INSERT INTO TRIP_STATUS (
            STATUS_ID, TRIP_ID
        ) VALUES (
            v_status_id, p_trip_id
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting trip status: ' || SQLERRM);
            RETURN;
    END;

    -- Check if trip was created successfully
    IF p_trip_id IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Trip created successfully! Trip ID: ' || p_trip_id);

        -- Assign driver to the trip
        BEGIN
            assign_driver_to_trip(
                p_trip_id       => p_trip_id,
                p_ride_type_id  => p_ride_type_id,
                p_driver_id     => v_driver_id
            );
        END;
    END IF;

  EXCEPTION
    WHEN ex_invalid_input THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid input parameters provided.');
    WHEN ex_customer_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: Customer ID ' || p_customer_id || ' not found.');
    WHEN ex_ride_type_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ride type ID ' || p_ride_type_id || ' not found.');
    WHEN ex_status_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: Status "REQUESTED" for "TRIP" not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
  END create_trip;
  
  
  -- Assigning driver to a trip
    PROCEDURE assign_driver_to_trip (
    p_trip_id       IN  NUMBER,
    p_ride_type_id  IN  NUMBER,
    p_driver_id     OUT NUMBER
) IS
    v_pickup_zipcode   NUMBER;
    v_status_id        NUMBER;
    v_vehicle_id       NUMBER;
BEGIN
    -- 1. Get the pickup zipcode of the trip
    BEGIN
        SELECT pickup_zipcode
        INTO v_pickup_zipcode
        FROM Trip
        WHERE trip_id = p_trip_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Trip ID ' || p_trip_id || ' not found.');
            p_driver_id := NULL;
            RETURN;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error fetching trip details: ' || SQLERRM);
            p_driver_id := NULL;
            RETURN;
    END;

    -- 2. Get the Status_ID for 'AVAILABLE' from DRIVER status type
    BEGIN
        SELECT status_id
        INTO v_status_id
        FROM Status_Master
        WHERE UPPER(status) = 'AVAILABLE' AND UPPER(status_type) = 'DRIVER';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Status ID for AVAILABLE driver not found in Status_Master.');
            p_driver_id := NULL;
            RETURN;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error fetching status_id: ' || SQLERRM);
            p_driver_id := NULL;
            RETURN;
    END;

    -- 3. Find a matching available driver and vehicle based on ride type and pickup location
    BEGIN
        SELECT D.driver_id, V.vehicle_id
        INTO p_driver_id, v_vehicle_id
        FROM Driver D
        JOIN Vehicle V ON D.driver_id = V.driver_id
        WHERE V.ride_type_id = p_ride_type_id
          AND D.driver_id IN (
            SELECT DS.driver_id
            FROM (
              SELECT driver_id, current_location, status_id,
                     ROW_NUMBER() OVER (PARTITION BY driver_id ORDER BY last_updated_at DESC) AS rn
              FROM Driver_Status
            ) DS
            WHERE rn = 1
              AND DS.status_id = v_status_id
              AND DS.current_location = v_pickup_zipcode
          )
          AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No available drivers found for Trip ID: ' || p_trip_id);
            p_driver_id := NULL;
            RETURN;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error finding available driver: ' || SQLERRM);
            p_driver_id := NULL;
            RETURN;
    END;

    -- 4. Assign the driver and vehicle to the trip
    BEGIN
        UPDATE Trip
        SET vehicle_id = v_vehicle_id,
            last_updated_at = SYSDATE,
            updated_by = 'System'
        WHERE trip_id = p_trip_id;

        DBMS_OUTPUT.PUT_LINE('Driver ' || p_driver_id || ' assigned to Trip ' || p_trip_id);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error assigning driver to trip: ' || SQLERRM);
            p_driver_id := NULL;
    END;
END assign_driver_to_trip;

END pkg_trip_request;
