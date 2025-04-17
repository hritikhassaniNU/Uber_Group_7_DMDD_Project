-- // Trip Creation Block
-- 
-- STEP 1: Make sure CUSTOMER_ID (e.g., 3) exists in the CUSTOMER table.
-- STEP 2: Choose realistic pickup and dropoff locations and corresponding ZIP codes.
-- STEP 3: RIDE_TYPE_ID must match one of the valid entries in the RIDE_TYPE table:
--         (1) UberX, (2) UberXL, (3) UberBlack, (4) UberEco,
--         (5) Uber Electric, (6) Comfort, (7) UberXXL
-- STEP 4: This procedure will:
--         - Validate inputs
--         - Calculate distance, base fare, surge multiplier, and total fare
--         - Insert a record into TRIP
--         - Insert a 'REQUESTED' status into TRIP_STATUS
--         - Attempt to auto-assign a driver if available

SET SERVEROUTPUT ON;

DECLARE
    v_trip_id NUMBER;
BEGIN
    pkg_trip_request.create_trip(
        p_customer_id       => 3,           -- Must exist in CUSTOMER table
        p_pickup_location   => 'NEU',       -- Start location (free text)
        p_dropoff_location  => 'MIT',       -- Destination (free text)
        p_pickup_zipcode    => 02116,       -- Arbitary but must match an available driver's location if we want auto-assignment
        p_dropoff_zipcode   => 02138,       -- Arbitrary
        p_ride_type_id      => 1,           -- See valid RIDE_TYPE_IDs above
        p_trip_id           => v_trip_id    -- Output: generated trip ID
    );
END;
/


