-- PURPOSE:
-- These blocks demonstrate how to cancel a trip using the `trip_cancellation_pkg.cancel_trip` procedure.
--
-- RULES ENFORCED BY THE PROCEDURE:
-- 1. The Trip ID must exist.
-- 2. A trip cannot be cancelled if:
--    - It is already marked as 'completed'
--    - It is already marked as 'cancelled'
--    - It is currently 'in progress'
-- 3. Upon valid cancellation:
--    - Feedback, rating, and timing fields in TRIP will be nullified.
--    - The payment_id will be cleared.
--    - A new TRIP_STATUS record will be inserted with status = 'cancelled'
--    - `updated_by` will reflect the current Oracle user.

SET SERVEROUTPUT ON;


-- Test Block 1: Cancel Trip ID 9 by Customer
BEGIN
    -- Attempt to cancel trip with ID 9
    trip_cancellation_pkg.cancel_trip(
        p_trip_id      => 9,                         -- ID of trip to be cancelled (must exist)
        p_cancelled_by => 'Customer',                -- Who is cancelling the trip
        p_reason       => 'Found a better price'     -- Reason for cancellation
    );

    -- If successful, print confirmation message
    DBMS_OUTPUT.PUT_LINE('Trip cancellation procedure executed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        -- Display the exact error if cancellation fails
        DBMS_OUTPUT.PUT_LINE('Test failed: ' || SQLERRM);
END;
/


-- Test Block 2: Attempt to cancel Trip ID 4 by Driver

BEGIN
    -- Attempting cancellation again on same trip should fail if already cancelled
    trip_cancellation_pkg.cancel_trip(
        p_trip_id      => 4,                        -- Trip ID already marked cancelled
        p_cancelled_by => 'Driver',                  -- Cancellation attempt by a different user
        p_reason       => 'Not Available'            -- Reason for this cancellation attempt
    );

    -- Should not reach here if logic is enforced correctly
    DBMS_OUTPUT.PUT_LINE('Trip cancellation procedure executed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        -- This block should trigger if trip is already cancelled or not valid for cancellation
        DBMS_OUTPUT.PUT_LINE('Test failed: ' || SQLERRM);
END;
/
