--askhsh 3a
CREATE OR REPLACE TRIGGER CUSTOMER_IN_UPPERCASE
BEFORE INSERT OR UPDATE ON CUSTOMER
FOR EACH ROW
DECLARE
BEGIN 
:NEW.AT:=UPPER(:NEW.AT);
:NEW.FIRST_NAME :=UPPER(:NEW.FIRST_NAME);
:NEW.LAST_NAME :=UPPER(:NEW.LAST_NAME);
:NEW.COUNTRY :=UPPER(:NEW.COUNTRY);
:NEW.CITY :=UPPER(:NEW.CITY);
:NEW.STREET_NAME :=UPPER(:NEW.STREET_NAME);
END;

CREATE OR REPLACE TRIGGER CATEGORY_IN_UPPERCASE
BEFORE INSERT OR UPDATE ON CATEGORY
FOR EACH ROW
DECLARE
BEGIN 
:NEW.NAME:=UPPER(:NEW.NAME);
END;

CREATE OR REPLACE TRIGGER FACILITY_IN_UPPERCASE
BEFORE INSERT OR UPDATE ON FACILITY
FOR EACH ROW
DECLARE
BEGIN 
:NEW.NAME:=UPPER(:NEW.NAME);
END;

--askhsh 3b(checked)

create or replace NONEDITIONABLE TRIGGER BOOKING_DATES_VALIDATION
BEFORE INSERT OR UPDATE ON BOOKING
FOR EACH ROW
DECLARE
INVALID_DATES EXCEPTION;
BEGIN 
IF :NEW.BOOK_IN_DATE>:NEW.BOOK_OUT_DATE OR :NEW.BOOK_IN_DATE<CURRENT_TIMESTAMP OR :NEW.BOOK_OUT_DATE<CURRENT_TIMESTAMP THEN
RAISE INVALID_DATES;
END IF;
EXCEPTION
WHEN INVALID_DATES THEN
RAISE_APPLICATION_ERROR (-20001,'INVALID DATES...TRY AGAIN');
END;

--askhsh 3ci(checked)
CREATE OR REPLACE TRIGGER ROOMCOUNTTRIGGER
AFTER INSERT OR UPDATE ON ROOM
FOR EACH ROW
DECLARE
BEGIN
UPDATE CATEGORY SET ROOMCOUNT = ROOMCOUNT+1 WHERE NAME= :NEW.CATEGORY_NAME;
END;

CREATE OR REPLACE TRIGGER ROOMCOUNTTRIGGER2
AFTER DELETE ON ROOM
FOR EACH ROW
DECLARE
BEGIN
UPDATE CATEGORY SET ROOMCOUNT = ROOMCOUNT-1 WHERE NAME= :OLD.CATEGORY_NAME;
END;

--askhsh 3cii(checked)

CREATE OR REPLACE TRIGGER BOOKTIMESTRIGGER
AFTER INSERT OR UPDATE ON BOOKING
FOR EACH ROW
DECLARE
BEGIN
UPDATE ROOM SET BOOK_TIMES = BOOK_TIMES+1 WHERE ROOM_NUMBER= :NEW.ROOM_NUMBER;
END;

CREATE OR REPLACE TRIGGER BOOKTIMESTRIGGER2
AFTER DELETE ON BOOKING
FOR EACH ROW
DECLARE
BEGIN
UPDATE ROOM SET BOOK_TIMES = BOOK_TIMES-1 WHERE ROOM_NUMBER= :OLD.ROOM_NUMBER;
END;



