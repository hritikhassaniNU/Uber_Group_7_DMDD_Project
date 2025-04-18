-- Cancelled trips for the support team with information about who cancelled, cancellation reason, cancellation time, feedback, etc.
CREATE OR REPLACE VIEW VW_SUPPORT_CASES AS
SELECT 
    T.TRIP_ID,
    C.FIRST_NAME AS CUSTOMER_FIRST_NAME,
    C.LAST_NAME AS CUSTOMER_LAST_NAME,
    D.FIRST_NAME AS DRIVER_FIRST_NAME,
    D.LAST_NAME AS DRIVER_LAST_NAME,
    T.CANCELLED_AT,
    T.CANCELLED_BY,
    T.CANCELLATION_REASON,
    T.FEEDBACK,
    SM.STATUS AS TRIP_STATUS
FROM TRIP T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN VEHICLE V ON T.VEHICLE_ID = V.VEHICLE_ID
JOIN DRIVER D ON V.DRIVER_ID = D.DRIVER_ID
JOIN TRIP_STATUS TS ON T.TRIP_ID = TS.TRIP_ID
JOIN STATUS_MASTER SM ON TS.STATUS_ID = SM.STATUS_ID
WHERE T.CANCELLED_AT IS NOT NULL
  AND TS.LAST_UPDATED_AT = (
    SELECT MAX(TS_SUB.LAST_UPDATED_AT)
    FROM TRIP_STATUS TS_SUB
    WHERE TS_SUB.TRIP_ID = T.TRIP_ID
  );

--test view
--SELECT * FROM VW_SUPPORT_CASES;