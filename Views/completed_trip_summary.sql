-- View that shows the relationship between drivers, vehicles, ride types, and payment info for completed trips
CREATE OR REPLACE VIEW vw_completed_trip_summary AS
SELECT 
    d.driver_id,
    d.first_name || ' ' || d.last_name AS driver_name,
    d.phone_number AS driver_phone,
    d.email AS driver_email,
    d.license_number,
    d.rating AS driver_rating,
    v.vehicle_id,
    v.make,
    v.model,
    v.year,
    v.license_plate_number,
    rt.type AS ride_type,
    rt.category AS ride_category,
    t.trip_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    t.start_time,
    t.end_time,
    t.pickup_location,
    t.dropoff_location,
    t.distance_miles,
    t.total_fare,
    p.amount AS payment_amount,
    NVL(t.trip_rating, 0) AS trip_rating,
    sm.status AS trip_status
FROM 
    Driver d
JOIN 
    Vehicle v ON d.driver_id = v.driver_id
JOIN 
    Ride_Type rt ON v.ride_type_id = rt.ride_type_id
LEFT JOIN 
    Trip t ON v.vehicle_id = t.vehicle_id
LEFT JOIN 
    Customer c ON t.customer_id = c.customer_id
LEFT JOIN 
    Payment p ON t.payment_id = p.payment_id
LEFT JOIN 
    (SELECT 
        ts1.trip_id, 
        ts1.status_id
     FROM 
        Trip_Status ts1
     INNER JOIN 
        (SELECT 
            trip_id, 
            MAX(created_at) AS max_created_at
         FROM 
            Trip_Status
         GROUP BY 
            trip_id) ts2
     ON 
        ts1.trip_id = ts2.trip_id 
        AND ts1.created_at = ts2.max_created_at) ts
ON 
    t.trip_id = ts.trip_id
LEFT JOIN 
    Status_Master sm ON ts.status_id = sm.status_id
WHERE 
    LOWER(sm.status) = 'completed'
ORDER BY 
    d.driver_id, v.vehicle_id, t.trip_id;

--Test View
--SELECT * FROM vw_completed_trip_summary;

