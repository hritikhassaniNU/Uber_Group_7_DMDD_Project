------------------------------------------------------
--This file is run by database or system administrator
------------------------------------------------------

-- Giving grants to Admin
GRANT CREATE USER, ALTER USER, DROP USER TO admin;

-- The below lines would throw an error for the first time as the users wouldn't exist at the time of execution
DROP USER Application_Admin CASCADE;
DROP USER Uber_Driver CASCADE;         
DROP USER App_Customer CASCADE;      
DROP USER Support_Team CASCADE;         
DROP USER Fleet_Management CASCADE;       

CREATE USER Application_Admin IDENTIFIED BY Password#123A;

CREATE USER Uber_Driver IDENTIFIED BY Password#123D;

CREATE USER App_Customer IDENTIFIED BY Password#123C;

CREATE USER Support_Team IDENTIFIED BY Password#123S;

CREATE USER Fleet_Management IDENTIFIED BY Password#123F;

-- Assigning the grants to the Application Admin
GRANT 
    CREATE SESSION,
    CREATE TABLE,
    ALTER ANY TABLE,
    DROP ANY TABLE,
    CREATE VIEW,
    SELECT ANY TABLE,
    INSERT ANY TABLE,
    UPDATE ANY TABLE,
    DELETE ANY TABLE,
    UNLIMITED TABLESPACE,
    RESOURCE
TO Application_Admin;

GRANT CREATE SESSION TO App_Customer,Uber_Driver,Support_Team,Fleet_Management;

COMMIT;
