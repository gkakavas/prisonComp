DECLARE 
facilitycode VARCHAR2(10):='HLIAKO';
room_number NUMBER:=162;
room_category VARCHAR2(10):='TRIKLINO';
BEGIN
ASSIGNFACILITYTOROOM(facilitycode,room_number,room_category);
END;