SET SERVEROUTPUT ON;
BEGIN
    -- Grant access to Customer-related views for App_Customer
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_CUSTOMER_PROFILE TO App_Customer';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_CUSTOMER_PROFILE to App_Customer');

    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_CUSTOMER_TRIPS TO App_Customer';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_CUSTOMER_TRIPS to App_Customer');

    -- Grant access to Driver-related views for Uber_Driver
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVER_TRIPS TO Uber_Driver';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_DRIVER_TRIPS to Uber_Driver');

    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVER_WEEKLY_EARNINGS TO Uber_Driver';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_DRIVER_WEEKLY_EARNINGS to Uber_Driver');

    -- Grant access to Fleet Management-related views for Fleet_Management
    EXECUTE IMMEDIATE 'GRANT SELECT ON VW_COMPLETED_TRIP_SUMMARY TO FLEET_MANAGEMENT';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVER_TRIPS TO Fleet_Management';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_DRIVER_TRIPS and VW_COMPLETED_TRIP_SUMMARY to Fleet_Management');

    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVER_WEEKLY_EARNINGS TO Fleet_Management';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_DRIVER_WEEKLY_EARNINGS to Fleet_Management');

    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.LOW_RATED_TRIPS TO Fleet_Management';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on LOW_RATED_TRIPS to Fleet_Management');

    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVERS_WITHOUT_LICENSE TO Fleet_Management';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_DRIVERS_WITHOUT_LICENSE to Fleet_Management');

    -- Grant access to Support Team-related views for Support_Team
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_SUPPORT_CASES TO Support_Team';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_SUPPORT_CASES to Support_Team');

    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.LOW_RATED_TRIPS TO Support_Team';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on LOW_RATED_TRIPS to Support_Team');

    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVERS_WITHOUT_LICENSE TO Fleet_Management';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on VW_DRIVERS_WITHOUT_LICENSE to Fleet_Management');

    -- Grant access to all views for Application_Admin
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_CUSTOMER_PROFILE TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_CUSTOMER_TRIPS TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVER_TRIPS TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVER_WEEKLY_EARNINGS TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_DRIVERS_WITHOUT_LICENSE TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_SUPPORT_CASES TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_REQUESTED_TRIPS TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.LOW_RATED_TRIPS TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_PAYMENT_REPORTS TO Application_Admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Application_Admin.VW_COMPLETED_TRIP_SUMMARY TO Application_Admin';
    DBMS_OUTPUT.PUT_LINE('Granted SELECT on all views to Application_Admin');

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error during GRANT operations: ' || SQLERRM);
        ROLLBACK;
END;
/