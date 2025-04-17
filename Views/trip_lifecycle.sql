-- 1. Basic query on main lifecycle view
SELECT 
    trip_id, 
    customer_id, 
    driver_id, 
    trip_lifecycle_stage,
    requested_at,
    start_time,
    end_time,
    trip_duration_minutes,
    total_fare,
    is_paid,
    has_feedback,
    is_cancelled
FROM 
    vw_trip_lifecycle
ORDER BY 
    requested_at DESC;

-- 2. View trip status history for a specific trip
SELECT 
    trip_id,
    trip_status,
    status_timestamp,
    updated_by,
    status_sequence
FROM 
    vw_trip_status_history
WHERE 
    trip_id = 1 
ORDER BY 
    status_sequence;

