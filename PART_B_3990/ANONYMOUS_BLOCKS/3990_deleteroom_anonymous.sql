DECLARE 
room_number NUMBER:=162;
room_category VARCHAR2(10):='TRIKLINO';
BEGIN
DELETEROOM(room_number,room_category);
END;