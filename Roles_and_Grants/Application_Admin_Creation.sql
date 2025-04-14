------------------------------------------------------
-- This file is run by database or system administrator
------------------------------------------------------
SET SERVEROUTPUT ON;

-- Block to kill any active session for APPLICATION_ADMIN user, if present
DECLARE
    v_sid NUMBER;
    v_serial NUMBER;
BEGIN
    SELECT SID, SERIAL# INTO v_sid, v_serial
    FROM V$SESSION
    WHERE USERNAME = 'APPLICATION_ADMIN' AND ROWNUM = 1;

    EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || v_sid || ',' || v_serial || ''' IMMEDIATE';
    DBMS_OUTPUT.PUT_LINE('Terminated existing session for APPLICATION_ADMIN.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No active session found for APPLICATION_ADMIN.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error terminating session: ' || SQLERRM);
END;
/

-- Block to drop APPLICATION_ADMIN user if it already exists
DECLARE
    v_user_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_user_count FROM ALL_USERS WHERE USERNAME = 'APPLICATION_ADMIN';

    IF v_user_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER APPLICATION_ADMIN CASCADE';
        DBMS_OUTPUT.PUT_LINE('Dropped existing user APPLICATION_ADMIN.');
    END IF;
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error dropping user APPLICATION_ADMIN: ' || SQLERRM);
END;
/

-- Create APPLICATION_ADMIN user with essential privileges
BEGIN
    EXECUTE IMMEDIATE 'CREATE USER APPLICATION_ADMIN IDENTIFIED BY "Password#123A"';

    -- Grant connect and session privileges
    EXECUTE IMMEDIATE 'GRANT CONNECT, CREATE SESSION TO APPLICATION_ADMIN WITH ADMIN OPTION';
    
    -- Grant the ability to drop users
    EXECUTE IMMEDIATE 'GRANT DROP USER TO APPLICATION_ADMIN WITH ADMIN OPTION';

    -- Grant the ability to create roles, users, tables, views, and procedures
    EXECUTE IMMEDIATE 'GRANT CREATE ROLE, CREATE USER, CREATE TABLE, CREATE VIEW, CREATE TRIGGER, CREATE PROCEDURE TO APPLICATION_ADMIN WITH ADMIN OPTION';

    -- Grant additional system privileges that might be needed
    EXECUTE IMMEDIATE 'GRANT CREATE ANY PROCEDURE, DROP ANY PROCEDURE TO APPLICATION_ADMIN WITH ADMIN OPTION';

    -- Grant privileges to create sequences
    EXECUTE IMMEDIATE 'GRANT CREATE SEQUENCE TO APPLICATION_ADMIN';

    -- Allocate unlimited quota on default tablespace (change DATA if needed)
    EXECUTE IMMEDIATE 'ALTER USER APPLICATION_ADMIN QUOTA UNLIMITED ON USERS';

    DBMS_OUTPUT.PUT_LINE('User APPLICATION_ADMIN created and granted permissions successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating or granting permissions to APPLICATION_ADMIN: ' || SQLERRM);
END;
/


