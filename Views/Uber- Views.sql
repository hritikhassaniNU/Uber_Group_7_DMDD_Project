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

-- Find trips which have less than 3 rating (Support team)/ (Fleet manager) to check why that trip is rated poorly

CREATE OR REPLACE VIEW LOW_RATED_TRIPS AS
SELECT 
    T.TRIP_ID,
    C.FIRST_NAME AS CUSTOMER_FIRST_NAME,
    C.LAST_NAME AS CUSTOMER_LAST_NAME,
    D.FIRST_NAME AS DRIVER_FIRST_NAME,
    D.LAST_NAME AS DRIVER_LAST_NAME,
    T.PICKUP_LOCATION,
    T.DROPOFF_LOCATION,
    T.DISTANCE_MILES,
    T.TOTAL_FARE,
    T.TRIP_RATING,
    T.START_TIME,
    T.END_TIME
FROM TRIP T
JOIN CUSTOMER C ON T.CUSTOMER_ID = C.CUSTOMER_ID
JOIN VEHICLE V ON T.RIDE_TYPE_ID = V.RIDE_TYPE_ID
JOIN DRIVER D ON V.DRIVER_ID = D.DRIVER_ID
WHERE T.TRIP_RATING < 3;

SELECT * FROM LOW_RATED_TRIPS;

-- Count the drivers weekly trips along with their earnings
CREATE OR REPLACE VIEW VW_DRIVER_WEEKLY_EARNINGS AS
SELECT 
    D.DRIVER_ID AS DRIVER_ID,
    D.FIRST_NAME AS DRIVER_FIRST_NAME,
    D.LAST_NAME AS DRIVER_LAST_NAME,
    TRUNC(T.START_TIME, 'IW') AS WEEK_START_DATE, -- Fixed DATE_TRUNC usage for Oracle
    COUNT(T.TRIP_ID) AS WEEKLY_TRIP_COUNT,
    SUM(T.TOTAL_FARE) AS WEEKLY_EARNINGS
FROM TRIP T
JOIN VEHICLE V ON V.VEHICLE_ID = T.RIDE_TYPE_ID
JOIN DRIVER D ON V.DRIVER_ID = D.DRIVER_ID
GROUP BY D.DRIVER_ID, D.FIRST_NAME, D.LAST_NAME, TRUNC(T.START_TIME, 'IW') 
ORDER BY TRUNC(T.START_TIME, 'IW') DESC, WEEKLY_EARNINGS DESC;

SELECT * FROM VW_DRIVER_WEEKLY_EARNINGS;


-- Find the drivers who have registered and not added the license number
CREATE OR REPLACE VIEW VW_DRIVERS_WITHOUT_LICENSE AS
SELECT 
    D.DRIVER_ID,
    D.FIRST_NAME AS DRIVER_FIRST_NAME,
    D.LAST_NAME AS DRIVER_LAST_NAME,
    D.EMAIL,
    D.PHONE_NUMBER,
    D.CREATED_AT AS REGISTRATION_DATE
FROM DRIVER D
WHERE D.LICENSE_NUMBER IS NULL
ORDER BY D.CREATED_AT DESC;

SELECT * FROM VW_DRIVERS_WITHOUT_LICENSE;

-- Grant access to Customer-related views for App_Customer
GRANT SELECT ON Application_Admin.VW_CUSTOMER_PROFILE TO App_Customer;
GRANT SELECT ON Application_Admin.VW_CUSTOMER_TRIPS TO App_Customer;

--GRANT SELECT ON APP_OWNER.VW_CUSTOMER_PROFILE TO App_Customer;
--GRANT SELECT ON APP_OWNER.VW_CUSTOMER_TRIPS TO App_Customer;


-- Grant access to Driver-related views for Uber_Driver
GRANT SELECT ON Application_Admin.VW_DRIVER_TRIPS TO Uber_Driver;
GRANT SELECT ON Application_Admin.VW_DRIVER_WEEKLY_EARNINGS TO Uber_Driver;

-- Grant access to Fleet Management-related views for Fleet_Management
GRANT SELECT ON Application_Admin.VW_DRIVER_TRIPS TO Fleet_Management;
GRANT SELECT ON Application_Admin.VW_DRIVER_WEEKLY_EARNINGS TO Fleet_Management;
GRANT SELECT ON Application_Admin.LOW_RATED_TRIPS TO Fleet_Management;
GRANT SELECT ON Application_Admin.VW_DRIVERS_WITHOUT_LICENSE TO Fleet_Management;

-- Grant access to Support Team-related views for Support_Team
GRANT SELECT ON Application_Admin.VW_SUPPORT_CASES TO Support_Team;
GRANT SELECT ON Application_Admin.LOW_RATED_TRIPS TO Support_Team;

-- Grant access to all views for Application_Admin
GRANT SELECT ON Application_Admin.VW_CUSTOMER_PROFILE TO Application_Admin;
GRANT SELECT ON Application_Admin.VW_CUSTOMER_TRIPS TO Application_Admin;
GRANT SELECT ON Application_Admin.VW_DRIVER_TRIPS TO Application_Admin;
GRANT SELECT ON Application_Admin.VW_DRIVER_WEEKLY_EARNINGS TO Application_Admin;
GRANT SELECT ON Application_Admin.VW_DRIVERS_WITHOUT_LICENSE TO Application_Admin;
GRANT SELECT ON Application_Admin.VW_SUPPORT_CASES TO Application_Admin;
GRANT SELECT ON Application_Admin.VW_REQUESTED_TRIPS TO Application_Admin;
GRANT SELECT ON Application_Admin.LOW_RATED_TRIPS TO Application_Admin;
