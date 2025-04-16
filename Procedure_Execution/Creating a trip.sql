-- // Trip Creation Block

SET SERVEROUTPUT ON;

DECLARE
    v_trip_id NUMBER;
BEGIN
    pkg_trip_request.create_trip(
        p_customer_id       => 3,          
        p_pickup_location   => 'NEU',
        p_dropoff_location  => 'MIT',
        p_pickup_zipcode    => 02116,
        p_dropoff_zipcode   => 02138,
        p_ride_type_id      => 1,            
        p_trip_id           => v_trip_id
    );
END;
/



