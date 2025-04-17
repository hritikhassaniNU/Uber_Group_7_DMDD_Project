-- Package Definition

create or replace PACKAGE PKG_TRIP_COMPLETION AS 
  PROCEDURE complete_trip(p_trip_id IN NUMBER);
END PKG_TRIP_COMPLETION;


-- Package Body

CREATE OR REPLACE PACKAGE BODY PKG_TRIP_COMPLETION AS

  PROCEDURE complete_trip(p_trip_id IN NUMBER) IS
    v_latest_status_id           NUMBER;
    v_status_id_completed        NUMBER;
    v_status_id_in_progress      NUMBER;
    v_vehicle_id                 NUMBER;
    v_driver_id                  NUMBER;
    v_dropoff_zipcode            NUMBER;
    v_status_message             VARCHAR2(200);
    v_current_status_name        VARCHAR2(50);
  BEGIN
    -- Step 1: Get status IDs for 'IN PROGRESS' and 'COMPLETED'
    BEGIN
      SELECT status_id
      INTO v_status_id_in_progress
      FROM status_master
      WHERE UPPER(status) = 'IN PROGRESS'
        AND UPPER(status_type) = 'TRIP';

      SELECT status_id
      INTO v_status_id_completed
      FROM status_master
      WHERE UPPER(status) = 'COMPLETED'
        AND UPPER(status_type) = 'TRIP';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Required status ID ("IN PROGRESS" or "COMPLETED") not found in STATUS_MASTER.');
        RETURN;
    END;

    -- Step 2: Get the latest status_id and name for this trip
    BEGIN
      SELECT sm.status_id, sm.status
      INTO v_latest_status_id, v_current_status_name
      FROM trip_status ts
      JOIN status_master sm ON ts.status_id = sm.status_id
      WHERE ts.trip_id = p_trip_id
        AND ts.created_at = (
          SELECT MAX(created_at)
          FROM trip_status
          WHERE trip_id = p_trip_id
        );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No status history found for Trip ID ' || p_trip_id);
        RETURN;
    END;

    -- Step 3: Ensure trip is currently 'IN PROGRESS'
    IF v_latest_status_id != v_status_id_in_progress THEN
      DBMS_OUTPUT.PUT_LINE('Trip must be In Progress to be marked as Completed. Current status: ' || v_current_status_name);
      RETURN;
    END IF;

    -- Step 4: Insert 'COMPLETED' into TRIP_STATUS
    BEGIN
      INSERT INTO trip_status (trip_id, status_id)
      VALUES (p_trip_id, v_status_id_completed);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to insert trip completion status: ' || SQLERRM);
        RETURN;
    END;

    -- Step 5: Update trip's END_TIME
    BEGIN
      UPDATE trip
      SET end_time = CURRENT_DATE,
          last_updated_at = CURRENT_DATE,
          updated_by = 'PKG_TRIP_COMPLETION'
      WHERE trip_id = p_trip_id;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to update trip END_TIME: ' || SQLERRM);
        RETURN;
    END;

    -- Step 6: Get DRIVER_ID and dropoff_zipcode
    BEGIN
      SELECT V.driver_id, T.dropoff_zipcode
      INTO v_driver_id, v_dropoff_zipcode
      FROM trip T
      JOIN vehicle V ON T.vehicle_id = V.vehicle_id
      WHERE T.trip_id = p_trip_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Driver or drop-off location not found for Trip ID ' || p_trip_id);
        RETURN;
    END;

    -- Step 7: Update driver status to 'Available'
    BEGIN
      v_status_message := update_driver_status(
        p_driver_id        => v_driver_id,
        p_status_name      => 'Available',
        p_current_location => v_dropoff_zipcode
      );
      DBMS_OUTPUT.PUT_LINE(v_status_message);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating driver status: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('Trip ' || p_trip_id || ' has been marked as Completed.');

  END complete_trip;

END PKG_TRIP_COMPLETION;
