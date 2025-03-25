--Customer
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

--SELECT * FROM SURGE_PRICING;
--Customer Profile view

DROP VIEW VW_CUSTOMER_PROFILE;
DROP VIEW VW_CUSTOMER_TRIPS;
DROP VIEW VW_DRIVER_TRIPS;
DROP VIEW VW_SUPPORT_CASES;
DROP VIEW VW_REQUESTED_TRIPS;
DROP VIEW LOW_RATED_TRIPS;
DROP VIEW VW_DRIVER_WEEKLY_EARNINGS;
DROP VIEW VW_DRIVERS_WITHOUT_LICENSE;

CREATE OR REPLACE VIEW VW_CUSTOMER_PROFILE AS 
    SELECT FIRST_NAME, 
    LAST_NAME, 
    PHONE_NUMBER, 
    EMAIL, 
    ADDRESS_LINE_1, 
    ADDRESS_LINE_2, 
    ZIPCODE FROM CUSTOMER;

SELECT * FROM VW_CUSTOMER_PROFILE;

--  Trips for a particular customer


CREATE OR REPLACE VIEW VW_CUSTOMER_TRIPS AS
SELECT 
    C.FIRST_NAME AS CUSTOMER_FIRST_NAME, 
    C.LAST_NAME AS CUSTOMER_LAST_NAME,
    S.STATUS AS TRIP_STATUS,
    T.START_TIME,
    T.END_TIME,
    T.PICKUP_LOCATION,
    T.DROPOFF_LOCATION,
    T.DISTANCE_MILES,
    T.TOTAL_FARE AS FARE,
    T.TRIP_RATING,
    RT.TYPE AS RIDE_TYPE
FROM TRIP T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN RIDE_TYPE RT ON T.RIDE_TYPE_ID = RT.RIDE_TYPE_ID
JOIN TRIP_STATUS TS ON TS.TRIP_ID = T.TRIP_ID
JOIN STATUS_MASTER S ON TS.STATUS_ID = S.STATUS_ID
WHERE TS.LAST_UPDATED_AT = (
    SELECT MAX(TS_SUB.LAST_UPDATED_AT)
    FROM TRIP_STATUS TS_SUB
    WHERE TS_SUB.TRIP_ID = T.TRIP_ID
);
 
--AND C.CUSTOMER_ID = 1; 

SELECT * FROM VW_CUSTOMER_TRIPS;

--Trips for a particular driver


--SELECT * FROM TRIP;
CREATE OR REPLACE VIEW VW_DRIVER_TRIPS AS
SELECT
  T.TRIP_ID,
  C.FIRST_NAME || ' ' || C.LAST_NAME AS CUSTOMER,
  D.FIRST_NAME AS DRIVER_FIRST_NAME,
  D.LAST_NAME AS DRIVER_LAST_NAME,
  T.START_TIME,
  T.END_TIME,
  T.PICKUP_LOCATION,
  T.DROPOFF_LOCATION,
  T.TOTAL_FARE AS EARNINGS,
  SM.STATUS AS TRIP_STATUS
FROM TRIP T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN RIDE_TYPE RT ON T.RIDE_TYPE_ID = RT.RIDE_TYPE_ID
JOIN VEHICLE V ON RT.RIDE_TYPE_ID = V.RIDE_TYPE_ID
JOIN DRIVER D ON V.DRIVER_ID = D.DRIVER_ID
JOIN TRIP_STATUS TS ON T.TRIP_ID = TS.TRIP_ID
JOIN Status_Master SM ON TS.STATUS_ID = SM.STATUS_ID
WHERE TS.LAST_UPDATED_AT = (
    SELECT MAX(TS_SUB.LAST_UPDATED_AT)
    FROM TRIP_STATUS TS_SUB
    WHERE TS_SUB.TRIP_ID = T.TRIP_ID
)
ORDER BY 2,3;
--AND D.DRIVER_ID = 1;  //Add a specific driver id to get the trip history for that driver

SELECT * FROM VW_DRIVER_TRIPS;

-- View Cancelled Trips for Support Team to analyse

--SELECT * FROM TRIP; 


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
JOIN VEHICLE V ON V.RIDE_TYPE_ID = T.RIDE_TYPE_ID
JOIN DRIVER D ON V.DRIVER_ID = D.DRIVER_ID
JOIN TRIP_STATUS TS ON T.TRIP_ID = TS.TRIP_ID
JOIN Status_Master SM ON TS.STATUS_ID = SM.STATUS_ID
WHERE T.CANCELLED_AT IS NOT NULL
  AND TS.LAST_UPDATED_AT = (
    SELECT MAX(TS_SUB.LAST_UPDATED_AT)
    FROM TRIP_STATUS TS_SUB
    WHERE TS_SUB.TRIP_ID = T.TRIP_ID
  );

SELECT * FROM VW_SUPPORT_CASES;

-- View requested trips

CREATE OR REPLACE VIEW VW_REQUESTED_TRIPS AS
SELECT 
    T.TRIP_ID,
    C.FIRST_NAME AS CUSTOMER_FIRST_NAME,
    C.LAST_NAME AS CUSTOMER_LAST_NAME,
    T.PICKUP_LOCATION AS PICKUP_ADDRESS,
    T.PICKUP_ZIPCODE,
    T.DROPOFF_LOCATION AS DROPOFF_ADDRESS,
    T.DROPOFF_ZIPCODE,
    RT.TYPE AS RIDE_TYPE
FROM TRIP T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN RIDE_TYPE RT ON T.RIDE_TYPE_ID = RT.RIDE_TYPE_ID
JOIN TRIP_STATUS TS ON TS.TRIP_ID = T.TRIP_ID
JOIN STATUS_MASTER S ON TS.STATUS_ID = S.STATUS_ID
WHERE S.STATUS = 'Requested'
  AND TS.LAST_UPDATED_AT = (
      SELECT MAX(TS_SUB.LAST_UPDATED_AT)
      FROM TRIP_STATUS TS_SUB
      WHERE TS_SUB.TRIP_ID = T.TRIP_ID
  );


SELECT * FROM VW_REQUESTED_TRIPS;
-- View Trip requested for Fleet Manager
