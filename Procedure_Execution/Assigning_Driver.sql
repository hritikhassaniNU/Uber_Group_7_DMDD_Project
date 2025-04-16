--// Assigning Driver to a trip testing
SET SERVEROUTPUT ON;

DECLARE
    v_driver_id NUMBER;
BEGIN
    pkg_trip_request.assign_driver_to_trip(
        p_trip_id       => 17,         
        p_ride_type_id  => 2,          
        p_driver_id     => v_driver_id
    );

    IF v_driver_id IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Matched Driver ID: ' || v_driver_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No driver assigned.');
    END IF;
END;
/

