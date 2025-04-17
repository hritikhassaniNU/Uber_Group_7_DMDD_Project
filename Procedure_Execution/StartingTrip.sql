-- Start Trip – Test Block
--
-- STEP 1: Ensure the trip with ID = 13 exists in the TRIP table.
-- STEP 2: The trip should currently have a latest status as 'REQUESTED'
--         NOT 'IN PROGRESS', 'COMPLETED', or 'CANCELLED'
-- STEP 3: The trip must have a vehicle_id assigned (i.e., a driver is already linked)

SET SERVEROUTPUT ON;

BEGIN
  PKG_TRIP_IN_PROGRESS.start_trip(
    p_trip_id => 13  -- Replace with a valid Trip ID in REQUESTED state
  );
END;
/
