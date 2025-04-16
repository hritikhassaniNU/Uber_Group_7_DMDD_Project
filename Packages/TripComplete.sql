CREATE OR REPLACE PACKAGE PKG_TRIP_COMPLETE AS 
  PROCEDURE trip_complete (
    p_trip_id      IN NUMBER,
    p_driver_id    IN NUMBER,
    p_drop_zipcode IN INTEGER
  );
END PKG_TRIP_COMPLETE;

-- Package Body

create or replace PACKAGE BODY PKG_TRIP_COMPLETE AS

  PROCEDURE trip_complete (
    p_trip_id      IN NUMBER,
    p_driver_id    IN NUMBER,
    p_drop_zipcode IN INTEGER
  ) IS
    v_status_on_trip       NUMBER;
    v_status_in_progress   NUMBER;
    v_status_completed     NUMBER;
    v_status_available     NUMBER;
    v_trip_drop_zip        INTEGER;
    v_pickup_zipcode       INTEGER;
    v_payment_id           NUMBER;
    v_total_fare           NUMBER;
  BEGIN
    SELECT status_id INTO v_status_completed
    FROM status_master
    WHERE UPPER(status) = 'COMPLETED' AND UPPER(status_type) = 'TRIP';

    SELECT status_id INTO v_status_available
    FROM status_master
    WHERE UPPER(status) = 'AVAILABLE' AND UPPER(status_type) = 'DRIVER';

    SELECT pickup_zipcode INTO v_pickup_zipcode
    FROM trip
    WHERE trip_id = p_trip_id;

    UPDATE trip
    SET end_time = SYSDATE,
        last_updated_at = SYSDATE,
        updated_by = USER
    WHERE trip_id = p_trip_id;

    DBMS_OUTPUT.PUT_LINE('️TRIP TIMING UPDATED: Trip ID = ' || p_trip_id || ' end time set to current timestamp');

    INSERT INTO trip_status (
      trip_id, status_id,
      created_at, created_by, last_updated_at
    ) VALUES (
      p_trip_id, v_status_completed,
      SYSDATE, USER, SYSDATE
    );

    DBMS_OUTPUT.PUT_LINE('TRIP STATUS UPDATE: Trip ID = ' || p_trip_id || ' is now "COMPLETED"');

    SELECT dropoff_zipcode INTO v_trip_drop_zip
    FROM trip
    WHERE trip_id = p_trip_id;

    INSERT INTO driver_status (
      driver_id, status_id, current_location,
      created_at, created_by, last_updated_at, updated_by
    ) VALUES (
      p_driver_id, v_status_available, v_trip_drop_zip,
      SYSDATE, USER, SYSDATE, USER
    );

    DBMS_OUTPUT.PUT_LINE('DRIVER STATUS UPDATE: Driver ID = ' || p_driver_id || ' is now "AVAILABLE" at drop-off location (Zipcode: ' || v_trip_drop_zip || ')');

    SELECT total_fare INTO v_total_fare FROM Trip WHERE trip_id = p_trip_id;

    BEGIN
      PROCESS_PAYMENT_FOR_TRIP(
        p_trip_id         => p_trip_id,
        p_payment_method  => 'Card',
        p_amount          => v_total_fare,
        p_payment_id      => v_payment_id
      );
      DBMS_OUTPUT.PUT_LINE('PAYMENT CONFIRMED: Payment ID = ' || v_payment_id || ' linked to Trip ID = ' || p_trip_id);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in trip flow update or payment processing: ' || SQLERRM);
    END;

  END trip_complete;

END PKG_TRIP_COMPLETE;
