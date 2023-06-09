--askhsh 1a(checked)
CREATE OR REPLACE PROCEDURE NEWBOOKING (CUS_ID IN NUMBER,ROOM_NUM IN NUMBER,ROOM_CAT IN VARCHAR2,IN_DATE IN TIMESTAMP,OUT_DATE IN TIMESTAMP) IS

AT_ VARCHAR2(20 BYTE);
BILL_ NUMBER;
FAC_PRICE_ NUMBER;

CURSOR A_T IS
SELECT AT FROM customer WHERE CUST_NO = CUS_ID;

CURSOR BILL IS
SELECT ROOMPRICE FROM CATEGORY WHERE NAME=ROOM_CAT;

CURSOR FAC_PRICE IS
SELECT SUM(DAILY_PRICE) FROM facilities FULL OUTER JOIN FACILITY ON facilities.FACILITY_NAME = FACILITY.NAME WHERE ROOM_NUMBER=ROOM_NUM;

BEGIN 
    OPEN A_T;
    OPEN BILL;
    OPEN FAC_PRICE;
    
    FETCH A_T INTO AT_;
    FETCH BILL INTO BILL_;
    FETCH FAC_PRICE INTO FAC_PRICE_;
    INSERT INTO BOOKING VALUES(default,IN_DATE,cus_id,AT_,ROOM_NUM,ROOM_CAT,BILL_+FAC_PRICE_,OUT_DATE);
    CLOSE A_T;
    CLOSE BILL;
    CLOSE FAC_PRICE;
END;

--askhsh 1b(checked)
CREATE OR REPLACE PROCEDURE ASSIGNFACILITYTOROOM (FACILITYCODE IN VARCHAR2,ROOM_NUM IN NUMBER,ROOM_CAT IN VARCHAR2) IS

CURSOR ROOMNUM IS
SELECT COUNT(ROOM_NUMBER) FROM FACILITIES WHERE ROOM_NUMBER = ROOM_NUM;
ROOMNUM_ NUMBER;
ROOM_FACILITIES_OVERFLOW EXCEPTION;

BEGIN
    OPEN ROOMNUM;
    FETCH ROOMNUM INTO ROOMNUM_;
    IF ROOMNUM_<3 THEN
    INSERT INTO FACILITIES VALUES(FACILITYCODE,ROOM_CAT,ROOM_NUM);
    ELSE RAISE ROOM_FACILITIES_OVERFLOW;
    END IF;
    CLOSE ROOMNUM;
EXCEPTION
WHEN ROOM_FACILITIES_OVERFLOW THEN
DBMS_OUTPUT.PUT_LINE ('EXCEPTION:THIS ROOM HAS MAX NUMBER OF AVAILABLE FACILITIES');
END;

--askhsh 1c(checked)
CREATE OR REPLACE PROCEDURE DELETEROOM (ROOM_NUM IN NUMBER, ROOM_CAT IN VARCHAR2) AS
BEGIN 
    DELETE FROM ROOM WHERE ROOM_NUMBER = ROOM_NUM;
    DELETE FROM BOOKING WHERE ROOM_NUMBER = ROOM_NUM AND CATEGORY_NAME = ROOM_CAT;
    DELETE FROM FACILITIES WHERE ROOM_NUMBER = ROOM_NUM AND CATEGORY_NAME = ROOM_CAT;
END;

