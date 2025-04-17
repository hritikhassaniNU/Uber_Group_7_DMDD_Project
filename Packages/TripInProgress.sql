-- Package Definition
--// Package: PKG_TRIP_IN_PROGRESS
--// Purpose: Used to start a trip after it has been created and assigned a driver.

--// Usage Notes:
--// 1. Input: Provide a valid TRIP_ID that:
--//    Exists in the TRIP table
--//    Has been assigned a VEHICLE (i.e., a driver is already linked)
--//    Latest status should be 'REQUESTED' or 'ASSIGNED' (not already 'IN PROGRESS' or 'COMPLETED')
--//
--// 2. What this procedure does:
--//    Checks if the trip has already started, completed, or was cancelled
--//    Inserts a new TRIP_STATUS as 'IN PROGRESS'
--//    Updates TRIP.START_TIME with the current timestamp
--//    Retrieves the DRIVER_ID from the assigned vehicle
--//    Updates the DRIVER's status to 'ON TRIP' using the update_driver_status() function
--//
--// 3. Output: Status messages are printed using DBMS_OUTPUT to confirm or explain each action

-- Package definition
CREATE OR REPLACE PACKAGE PKG_TRIP_IN_PROGRESS AS
  PROCEDURE start_trip(p_trip_id IN NUMBER); -- ID of the trip you want to start
END PKG_TRIP_IN_PROGRESS;


-- Package Body
CREATE OR REPLACE PACKAGE BODY PKG_TRIP_IN_PROGRESS AS

  PROCEDURE start_trip(p_trip_id IN NUMBER) IS
    v_status_id         NUMBER;
    v_ride_start_time   DATE := SYSDATE;
    v_vehicle_id        NUMBER;
    v_driver_id         NUMBER;
    v_pickup_zipcode    NUMBER;
    v_status_message    VARCHAR2(200);
    v_latest_status     VARCHAR2(50);
  BEGIN
    -- 0. Check latest status of the trip
    BEGIN
      SELECT sm.status
      INTO v_latest_status
      FROM trip_status ts
      JOIN status_master sm ON ts.status_id = sm.status_id
      WHERE ts.trip_id = p_trip_id
        AND ts.created_at = (
          SELECT MAX(created_at)
          FROM trip_status
          WHERE trip_id = p_trip_id
        );
    
      IF UPPER(v_latest_status) = 'IN PROGRESS' THEN
        DBMS_OUTPUT.PUT_LINE('Cannot start the trip:' || p_trip_id || ' as it is already in progress');
        RETURN;
      ELSIF UPPER(v_latest_status) = 'COMPLETED' THEN
        DBMS_OUTPUT.PUT_LINE('Cannot start the trip:' || p_trip_id || ' as the trip thas already been completed.');
        RETURN;
      ELSIF UPPER(v_latest_status) = 'CANCELLED' THEN
        DBMS_OUTPUT.PUT_LINE('Cannot start the trip:' || p_trip_id || ' as the trip has been cancelled. Please start a new trip');
        RETURN;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No status history found for Trip ID: ' || p_trip_id);
        RETURN;
    END;

    -- 1. Get the STATUS_ID for 'In Progress'
    BEGIN
      SELECT status_id INTO v_status_id
      FROM STATUS_MASTER
      WHERE UPPER(status) = 'IN PROGRESS' AND UPPER(status_type) = 'TRIP';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Status "In Progress" not found in STATUS_MASTER.');
        RETURN;
    END;

    -- 2. Insert 'In Progress' into TRIP_STATUS
    BEGIN
      INSERT INTO TRIP_STATUS (
        trip_id, status_id
      ) VALUES (
        p_trip_id, v_status_id
      );
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to insert trip status: ' || SQLERRM);
        RETURN;
    END;

    -- 3. Update START_TIME of the trip
    BEGIN
      UPDATE TRIP
      SET start_time = v_ride_start_time,
          last_updated_at = v_ride_start_time,
          updated_by = 'PKG_TRIP_IN_PROGRESS'
      WHERE trip_id = p_trip_id;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to update trip start time: ' || SQLERRM);
        RETURN;
    END;

    -- 4. Get VEHICLE_ID and PICKUP_ZIPCODE for this trip
    BEGIN
      SELECT vehicle_id, pickup_zipcode INTO v_vehicle_id, v_pickup_zipcode
      FROM TRIP
      WHERE trip_id = p_trip_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Trip ID ' || p_trip_id || ' not found.');
        RETURN;
    END;

    -- 5. Get DRIVER_ID from the assigned vehicle
    BEGIN
      SELECT driver_id INTO v_driver_id
      FROM VEHICLE
      WHERE vehicle_id = v_vehicle_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No driver found for vehicle ID ' || v_vehicle_id);
        RETURN;
    END;

    -- 6. Update driver status to 'On Trip' using update_driver_status function
    BEGIN
      v_status_message := update_driver_status(
        p_driver_id        => v_driver_id,
        p_status_name      => 'On Trip',
        p_current_location => v_pickup_zipcode
      );

      DBMS_OUTPUT.PUT_LINE(v_status_message);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to update driver status: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('Trip ' || p_trip_id || ' marked as In Progress.');
  END start_trip;

END PKG_TRIP_IN_PROGRESS;
