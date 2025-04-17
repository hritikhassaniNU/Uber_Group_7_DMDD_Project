-- View displaying all payment details along with associated trip, driver, and customer information
CREATE OR REPLACE VIEW vw_payment_reports AS
SELECT 
    p.payment_id,
    t.trip_id,
    v.driver_id,
    t.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    rt.type AS ride_type,
    p.amount,
    p.payment_method,
    p.transcation_date
FROM 
    Payment p
JOIN 
    Trip t ON t.payment_id = p.payment_id
JOIN 
    Vehicle v ON t.vehicle_id = v.vehicle_id
JOIN 
    Driver d ON v.driver_id = d.driver_id
JOIN 
    Customer c ON t.customer_id = c.customer_id
JOIN 
    Ride_Type rt ON v.ride_type_id = rt.ride_type_id
ORDER BY 
    p.transcation_date DESC;

--test view  
--SELECT * FROM vw_payment_reports;