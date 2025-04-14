
--------------------------------
-- UBER DRIVER ROLE GRANTS
--------------------------------
-- Allow Uber_Driver to read trip records and update status-related fields
GRANT SELECT, UPDATE ON Trip TO Uber_Driver;

-- Allow Uber_Driver to view ride status history
GRANT SELECT, INSERT ON Trip_Status TO Uber_Driver;

-- Allow Uber_Driver to view and add driver status 
GRANT SELECT, INSERT ON Driver_Status TO Uber_Driver;

-- Allow Uber_Driver to view payment/earnings info
GRANT SELECT ON Payment TO Uber_Driver;

GRANT SELECT, INSERT, UPDATE ON Vehicle TO Uber_Driver;

------------------------------------
-- APP CUSTOMER ROLE GRANTS
-------------------------------------
-- Allow App_Customer to book a trip (insert)
GRANT INSERT, SELECT ON Trip TO App_Customer;

--Customer adds the payment details
GRANT INSERT, SELECT ON Payment TO App_Customer;

-- Allow App_Customer to manage their own customer data
GRANT INSERT, UPDATE, SELECT ON Customer TO App_Customer;

-- Allow App_Customer to cancel their ride
GRANT UPDATE (cancelled_at, cancelled_by, cancellation_reason, driver_rating, trip_rating) ON Trip TO App_Customer;

-- Allow App_Customer to view trip and trip status history
GRANT SELECT, INSERT ON Trip_Status TO App_Customer;

-- Allow App_Customer to view driver info
--GRANT SELECT ON Driver TO App_Customer;

-- Allow App_Customer to make and view payment
GRANT INSERT, SELECT ON Payment TO App_Customer;

---------------------------------------
-- CUSTOMER SUPPORT TEAM ROLE GRANTS
---------------------------------------
-- Allow Support_Team to read and update trip for dispute handling
GRANT SELECT ON Trip TO Support_Team;

-- Allow Support_Team to view trip status history
GRANT SELECT ON Trip_Status TO Support_Team;

-- Allow Support_Team to view customer info
GRANT SELECT ON Customer TO Support_Team;

GRANT SELECT ON Driver TO Support_Team;

---------------------------------------
-- FLEET MANAGEMENT TEAM ROLE GRANTS
---------------------------------------
-- Allow Fleet_Management to view and update driver records
GRANT SELECT ON Driver TO Fleet_Management;

GRANT SELECT, INSERT ON Ride_Type TO Fleet_Management;

GRANT UPDATE (Rating) ON Driver TO Fleet_Management;

GRANT SELECT, INSERT, UPDATE ON Surge_Pricing TO Fleet_Management;

GRANT SELECT, INSERT ON Trip_Status TO Fleet_Management;

-- Allow Fleet_Management to monitor driver locations/status
GRANT SELECT, INSERT ON Driver_Status TO Fleet_Management;

COMMIT;
