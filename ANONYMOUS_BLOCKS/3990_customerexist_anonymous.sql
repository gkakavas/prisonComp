DECLARE 
c number; 
BEGIN
c:=CUSTOMEREXIST('JW38');
DBMS_OUTPUT.PUT_LINE(c);
END;