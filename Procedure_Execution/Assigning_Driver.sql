--// Assigning Driver to a Trip – Test Block
--// STEP 1: Ensure the trip_id exists in the TRIP table and is in 'REQUESTED' status
--// STEP 2: Use a valid ride_type_id from the list below:
--//         (1) UberX, (2) UberXL, (3) UberBlack, (4) UberEco,
--//         (5) Uber Electric, (6) Comfort, (7) UberXXL

SET SERVEROUTPUT ON;

DECLARE
    v_driver_id NUMBER;
BEGIN
    pkg_trip_request.assign_driver_to_trip(
        p_trip_id       => 17,         -- Trip ID must exist and be in REQUESTED status
        p_ride_type_id  => 2,          -- Change to any valid ride_type_id from list above
        p_driver_id     => v_driver_id
    );

    IF v_driver_id IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Matched Driver ID: ' || v_driver_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No driver assigned.');
    END IF;
END;
/
