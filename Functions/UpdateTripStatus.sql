CREATE OR REPLACE FUNCTION UPDATE_TRIP_STATUS (
  p_trip_id      IN Trip.trip_id%TYPE,
  p_status_name  IN Status_Master.status%TYPE
) RETURN VARCHAR2
AS
  v_new_status_id   Status_Master.status_id%TYPE;
  v_trip_exists     NUMBER;
  v_current_status  Status_Master.status%TYPE;
BEGIN
  -- 1. Check if the trip exists
  SELECT COUNT(*) INTO v_trip_exists
  FROM Trip
  WHERE trip_id = p_trip_id;

  IF v_trip_exists = 0 THEN
    RETURN 'Trip not found with ID: ' || p_trip_id;
  END IF;

  -- 2. Get current status of the trip
  BEGIN
    SELECT sm.status
    INTO v_current_status
    FROM Trip_Status ts
    JOIN Status_Master sm ON ts.status_id = sm.status_id
    WHERE ts.trip_id = p_trip_id
      AND sm.status_type = 'Trip'
      AND ts.created_at = (
        SELECT MAX(created_at)
        FROM Trip_Status
        WHERE trip_id = p_trip_id
      );
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'No current status found for Trip ID: ' || p_trip_id;
  END;

  -- 3. Validate status transitions
  IF UPPER(p_status_name) = 'REQUESTED' THEN
    RETURN 'Cannot update status to "Requested". Current status: ' || UPPER(v_current_status);

  ELSIF UPPER(p_status_name) = 'IN PROGRESS' THEN
    IF UPPER(v_current_status) != 'REQUESTED' THEN
      RETURN 'Can only update to "In Progress" from "Requested". Current status: ' || UPPER(v_current_status);
    END IF;

  ELSIF UPPER(p_status_name) = 'CANCELLED' THEN
    IF UPPER(v_current_status) != 'REQUESTED' THEN
      RETURN 'Can only cancel a trip from "Requested". Current status: ' || UPPER(v_current_status);
    END IF;

  ELSIF UPPER(p_status_name) = 'COMPLETED' THEN
    IF UPPER(v_current_status) != 'IN PROGRESS' THEN
      RETURN 'Can only complete a trip from "In Progress". Current status: ' || UPPER(v_current_status);
    END IF;

  END IF;

  -- 4. Get the new status ID
  BEGIN
    SELECT status_id INTO v_new_status_id
    FROM Status_Master
    WHERE LOWER(status) = LOWER(p_status_name)
      AND status_type = 'Trip';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'Invalid status "' || p_status_name || '" for Trip.';
  END;

  -- 5. Insert new trip status
  BEGIN
    INSERT INTO Trip_Status (trip_id, status_id)
    VALUES (p_trip_id, v_new_status_id);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Failed to insert new status: ' || SQLERRM;
  END;

  RETURN 'Trip status updated to "' || p_status_name || '" for Trip ID ' || p_trip_id ||
         '. Previous status: ' || UPPER(v_current_status) || '.';

EXCEPTION
  WHEN OTHERS THEN
    RETURN 'Unexpected error: ' || SQLERRM;
END UPDATE_TRIP_STATUS;


-- Test Case


SET SERVEROUTPUT ON;

BEGIN
  DBMS_OUTPUT.PUT_LINE(UPDATE_TRIP_STATUS(1, 'Completed'));
END;
/