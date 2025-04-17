CREATE OR REPLACE FUNCTION get_surge_multiplier (
    p_trip_time IN TIMESTAMP
) RETURN NUMBER IS
    v_multiplier NUMBER := 1.0;  -- Default multiplier
BEGIN
    SELECT multiplier
    INTO v_multiplier
    FROM SURGE_PRICING
    WHERE p_trip_time BETWEEN start_time AND end_time
    AND ROWNUM = 1;

    RETURN v_multiplier;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 1.0; -- No surge pricing applies
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error fetching surge multiplier: ' || SQLERRM);
        RETURN 1.0;
END get_surge_multiplier;
/
