CREATE OR REPLACE FUNCTION update_driver_status (
    p_driver_id        IN Driver.driver_id%TYPE,
    p_status_name      IN Status_Master.status%TYPE,
    p_current_location IN Driver_Status.current_location%TYPE
) RETURN VARCHAR2
IS
    v_status_id     Status_Master.status_id%TYPE;
    v_driver_exists NUMBER;
BEGIN
    -- 1. Check if driver exists
    SELECT COUNT(*) INTO v_driver_exists
    FROM Driver
    WHERE driver_id = p_driver_id;

    IF v_driver_exists = 0 THEN
        RETURN 'Driver not found with given ID.';
    END IF;

    -- 2. Get status_id for the given status name
    SELECT status_id INTO v_status_id
    FROM Status_Master
    WHERE LOWER(status) = LOWER(p_status_name)
      AND status_type = 'Driver';

    -- 3. Insert new Driver_Status record (no manual timestamps)
    INSERT INTO Driver_Status (
        driver_id, status_id, current_location
    ) VALUES (
        p_driver_id, v_status_id, p_current_location
    );

    RETURN 'Driver status updated to "' || p_status_name || '" at location ' || p_current_location;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Invalid status "' || p_status_name || '" for Driver.';
    WHEN OTHERS THEN
        RETURN 'Error: ' || SQLERRM;
END update_driver_status;


-- Test Case


--// Test Block for Updating Driver Status
--// Valid Status Names: 'Available', 'Offline', 'On Trip', 'Suspended'

SET SERVEROUTPUT ON;

DECLARE
  v_result VARCHAR2(200);
BEGIN
  v_result := update_driver_status(
    p_driver_id        => 5,             -- Replace with a valid DRIVER_ID from DRIVER table
    p_status_name      => 'On Trip',     -- Choose from: Available, Offline, On Trip, Suspended
    p_current_location => 02116          -- Provide ZIP code or area identifier
  );

  DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
