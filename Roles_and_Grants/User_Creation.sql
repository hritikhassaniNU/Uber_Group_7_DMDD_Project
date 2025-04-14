SET SERVEROUTPUT ON;

-- Drop existing users
BEGIN
    FOR user_rec IN (SELECT username FROM all_users WHERE username IN ('UBER_DRIVER', 'APP_CUSTOMER', 'SUPPORT_TEAM', 'FLEET_MANAGEMENT')) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER ' || user_rec.username || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('Dropped user: ' || user_rec.username);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Could not drop user ' || user_rec.username || ': ' || SQLERRM);
        END;
    END LOOP;
END;
/

-- Create Users and Grant Privileges
BEGIN
    -- Create and grant privileges to UBER_DRIVER
    BEGIN
        EXECUTE IMMEDIATE 'CREATE USER UBER_DRIVER IDENTIFIED BY "Password#123D"';
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO UBER_DRIVER';
        DBMS_OUTPUT.PUT_LINE('Created UBER_DRIVER and granted privileges.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating UBER_DRIVER: ' || SQLERRM);
    END;

    -- Create and grant privileges to APP_CUSTOMER
    BEGIN
        EXECUTE IMMEDIATE 'CREATE USER APP_CUSTOMER IDENTIFIED BY "Password#123C"';
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO APP_CUSTOMER';
        DBMS_OUTPUT.PUT_LINE('Created APP_CUSTOMER and granted privileges.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating APP_CUSTOMER: ' || SQLERRM);
    END;

    -- Create and grant privileges to SUPPORT_TEAM
    BEGIN
        EXECUTE IMMEDIATE 'CREATE USER SUPPORT_TEAM IDENTIFIED BY "Password#123S"';
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO SUPPORT_TEAM';
        DBMS_OUTPUT.PUT_LINE('Created SUPPORT_TEAM and granted privileges.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating SUPPORT_TEAM: ' || SQLERRM);
    END;

    -- Create and grant privileges to FLEET_MANAGEMENT
    BEGIN
        EXECUTE IMMEDIATE 'CREATE USER FLEET_MANAGEMENT IDENTIFIED BY "Password#123F"';
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO FLEET_MANAGEMENT';
        DBMS_OUTPUT.PUT_LINE('Created FLEET_MANAGEMENT and granted privileges.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating FLEET_MANAGEMENT: ' || SQLERRM);
    END;

    -- Final output confirmation
    DBMS_OUTPUT.PUT_LINE('All users created and privileges granted successfully.');
END;
/

COMMIT;