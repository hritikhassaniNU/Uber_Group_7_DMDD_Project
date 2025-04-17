-- Status_Master Table Creation
SET SERVEROUTPUT ON;

BEGIN
    -- Drop existing table if it exists
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Status_Master CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Status_Master table dropped.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Status_Master table does not exist or cannot be dropped.');
    END;
    
    -- Create Status_Master table
    EXECUTE IMMEDIATE '
    CREATE TABLE Status_Master (
        status_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        status VARCHAR2(15) DEFAULT ''Offline''
               CHECK (status IN (''Requested'', ''completed'', ''In Progress'', ''cancelled'', ''Available'', ''Offline'',
                   ''On Trip'', ''Suspended'')),
        status_type VARCHAR2(15) NOT NULL
    )';
    
    DBMS_OUTPUT.PUT_LINE('Status_Master table created successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating Status_Master table: ' || SQLERRM);
        ROLLBACK;
END;
/