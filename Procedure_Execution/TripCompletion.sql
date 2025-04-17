SET SERVEROUTPUT ON;

BEGIN
  PKG_TRIP_COMPLETION.complete_trip(
    p_trip_id => 2 
  );
END;
/