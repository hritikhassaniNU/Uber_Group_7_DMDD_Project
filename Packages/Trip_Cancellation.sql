create or replace PACKAGE trip_cancellation_pkg IS
    PROCEDURE cancel_trip(
        p_trip_id       IN Trip.trip_id%TYPE,
        p_cancelled_by  IN VARCHAR2,
        p_reason        IN VARCHAR2
    );
END trip_cancellation_pkg;

-- Package Body
CREATE OR REPLACE PACKAGE BODY trip_cancellation_pkg IS
    PROCEDURE cancel_trip(
        p_trip_id       IN Trip.trip_id%TYPE,
        p_cancelled_by  IN VARCHAR2,
        p_reason        IN VARCHAR2
    ) IS
        v_exists NUMBER;
        v_current_status VARCHAR2(50);
        v_cancelled_status_id Status_Master.status_id%TYPE;
    BEGIN
        -- 1. Check if the Trip exists
        SELECT COUNT(*) INTO v_exists
        FROM Trip
        WHERE trip_id = p_trip_id;

        IF v_exists = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Trip ID not found: ' || p_trip_id);
        END IF;

        -- 2. Check current status of the trip
        SELECT LOWER(sm.status)
        INTO v_current_status
        FROM Trip_Status ts
        JOIN Status_Master sm ON ts.status_id = sm.status_id
        WHERE ts.trip_id = p_trip_id
        ORDER BY ts.last_updated_at DESC, ts.trip_status_id DESC
        FETCH FIRST 1 ROWS ONLY;

        -- 3. Prevent cancellation if completed, in progress, or already cancelled
        IF v_current_status = 'completed' THEN
            RAISE_APPLICATION_ERROR(-20002, 'Trip ID ' || p_trip_id || ' is completed and cannot be cancelled.');
        ELSIF v_current_status = 'in progress' THEN
            RAISE_APPLICATION_ERROR(-20004, 'Trip ID ' || p_trip_id || ' is currently in progress and cannot be cancelled.');
        ELSIF v_current_status = 'cancelled' THEN
            RAISE_APPLICATION_ERROR(-20003, 'Trip ID ' || p_trip_id || ' is already cancelled.');
        END IF;

        -- 4. Update Trip table (nullify ratings/times/payment)
        UPDATE Trip
        SET cancelled_at        = SYSDATE,
            cancelled_by        = p_cancelled_by,
            cancellation_reason = p_reason,
            feedback            = NULL,
            start_time          = NULL,
            end_time            = NULL,
            trip_rating         = NULL,
            driver_rating       = NULL,
            customer_rating     = NULL,
            payment_id          = NULL,
            last_updated_at     = CURRENT_TIMESTAMP,
            updated_by          = USER
        WHERE trip_id = p_trip_id;

        -- 5. Get 'cancelled' status_id
        SELECT status_id INTO v_cancelled_status_id
        FROM Status_Master
        WHERE LOWER(status) = 'cancelled' AND status_type = 'Trip';

        -- 6. Insert new trip status instead of updating
        INSERT INTO Trip_Status (
            trip_id, status_id, created_at, created_by, last_updated_at
        ) VALUES (
            p_trip_id, v_cancelled_status_id, CURRENT_TIMESTAMP,
            'Trip_Cancellation_PKG', CURRENT_TIMESTAMP
        );

        DBMS_OUTPUT.PUT_LINE('Trip ID ' || p_trip_id || ' successfully cancelled.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error cancelling trip: ' || SQLERRM);
            ROLLBACK;
            RAISE;
    END cancel_trip;
END trip_cancellation_pkg;
/
