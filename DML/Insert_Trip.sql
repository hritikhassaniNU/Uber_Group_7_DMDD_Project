-- Trip Sample Data Insertion
SET SERVEROUTPUT ON;

BEGIN
    -- Clear existing data
    DELETE FROM Trip;
    DBMS_OUTPUT.PUT_LINE('Existing Trip data cleared.');
    
    -- Insert Trip data
    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (1, 1, TO_DATE('2025-03-23 07:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-23 08:00:00','YYYY-MM-DD HH24:MI:SS'),
            '123 Main St, Boston, MA', 2101, '456 Elm St, Boston, MA', 2102,
            5.50, 7.50, 1, 25.62, 1, 4.0, 'Smooth and pleasant ride', 4.3, 4.6,
            NULL, NULL, NULL);

    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (2, 2, TO_DATE('2025-03-24 07:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-24 08:00:00','YYYY-MM-DD HH24:MI:SS'),
            '200 Beacon St, Boston, MA', 2102, '300 Boylston St, Boston, MA', 2103,
            6.25, 8.00, 2, 40.81, 2, 5.0, 'Driver canceled due to illness', 2.9, 5.0,
            TO_DATE('2025-03-24 07:30:00','YYYY-MM-DD HH24:MI:SS'), 'Driver', 'Driver was ill');

    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (3, 3, TO_DATE('2025-03-25 08:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-25 09:00:00','YYYY-MM-DD HH24:MI:SS'),
            '101 Summer St, Boston, MA', 2103, '202 Atlantic Ave, Boston, MA', 2104,
            4.75, 7.25, 3, 11.24, 3, 4.0, 'Comfortable and efficient ride', 4.1, 4.4,
            NULL, NULL, NULL);
    
    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (4, 4, TO_DATE('2025-03-26 09:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-26 10:00:00','YYYY-MM-DD HH24:MI:SS'),
            '50 Winter St, Boston, MA', 2104, '75 Atlantic Ave, Boston, MA', 2105,
            8.00, 9.50, 4, 12.64, 4, 4.0, 'Customer canceled', 4.0, 4.0,
            TO_DATE('2025-03-24 09:30:00','YYYY-MM-DD HH24:MI:SS'), 'Customer', 'Customer changed mind');
    
    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (5, 5, TO_DATE('2025-03-27 10:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-27 11:00:00','YYYY-MM-DD HH24:MI:SS'),
            '120 Commonwealth Ave, Boston, MA', 2105, '85 Clarendon St, Boston, MA', 2106,
            7.30, 8.90, 5, 21.89, 5, 3.0, 'Average ride, need for improvement', 2.5, 3.1,
            NULL, NULL, NULL);
    
    -- Add remaining trips
    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (6, 6, TO_DATE('2025-03-28 11:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-28 12:00:00','YYYY-MM-DD HH24:MI:SS'),
            '300 Washington St, Boston, MA', 2106, '400 Atlantic Ave, Boston, MA', 2107,
            8.10, 9.80, 6, 39.05, 6, 5.0, 'Professional service with a comfortable ride', 5.0, 5.0,
            NULL, NULL, NULL);
    
    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (7, 7, TO_DATE('2025-03-29 12:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-29 13:00:00','YYYY-MM-DD HH24:MI:SS'),
            '60 Beacon St, Boston, MA', 2107, '75 Newbury St, Boston, MA', 2108,
            5.90, 8.20, 7, 11.53, 7, 4.0, 'Arrival delay caused cancellation', 4.0, 4.0,
            TO_DATE('2025-03-24 12:30:00','YYYY-MM-DD HH24:MI:SS'), 'Customer', 'Cancelled due to delay');
    
    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (8, 8, TO_DATE('2025-03-29 13:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-29 14:00:00','YYYY-MM-DD HH24:MI:SS'),
            '80 Tremont St, Boston, MA', 2108, '90 Boylston St, Boston, MA', 2109,
            4.25, 7.00, 8, 11.08, 8, 3.0, 'Ride was on time but vehicle could be cleaner', 3.9, 4.0,
            NULL, NULL, NULL);
    
    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (9, 9, TO_DATE('2025-03-30 14:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-30 15:00:00','YYYY-MM-DD HH24:MI:SS'),
            '250 Columbus Ave, Boston, MA', 2109, '300 Huntington Ave, Boston, MA', 2110,
            3.50, 6.75, 9, 34.78, 9, 4.0, 'Quick trip with friendly driver', 4.0, 4.0,
            NULL, NULL, NULL);

    INSERT INTO Trip (customer_id, vehicle_id, start_time, end_time, pickup_location, pickup_zipcode,
                      dropoff_location, dropoff_zipcode, distance_miles, base_fare, pricing_id,
                      total_fare, payment_id, trip_rating, feedback, driver_rating, customer_rating,
                      cancelled_at, cancelled_by, cancellation_reason)
    VALUES (10, 10, TO_DATE('2025-03-30 15:00:00','YYYY-MM-DD HH24:MI:SS'),
            TO_DATE('2025-03-30 16:00:00','YYYY-MM-DD HH24:MI:SS'),
            '500 Massachusetts Ave, Boston, MA', 2110, '600 Cambridge St, Boston, MA', 2101,
            6.00, 8.50, 10, 42.80, 10, 5.0, 'Customer canceled for cheaper alternative', 5.0, 3.7,
            TO_DATE('2025-03-24 15:30:00','YYYY-MM-DD HH24:MI:SS'), 'Customer', 'Cheaper ride found');
    
    DBMS_OUTPUT.PUT_LINE('Trip data inserted: ' || SQL%ROWCOUNT || ' rows');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting Trip data: ' || SQLERRM);
        ROLLBACK;
END;
/