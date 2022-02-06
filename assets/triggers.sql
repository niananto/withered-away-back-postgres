CREATE OR REPLACE TRIGGER AUTO_DIAGNOSED_BY
AFTER INSERT ON SUBSCRIPTION
FOR EACH ROW
DECLARE
	E_PEOPLE_ID NUMBER;
	E_MEMBERSHIP_ID NUMBER;
	E_COUNT_PATIENTS NUMBER;
	E_DOC_COUNT NUMBER;
	E_PEOPLE_COUNT NUMBER;
	E_DOC_PEOPLE_RATIO NUMBER;
BEGIN
	E_PEOPLE_ID := :NEW.PEOPLE_ID;
	E_MEMBERSHIP_ID := :NEW.MEMBERSHIP_ID;
	SELECT COUNT(*) INTO E_DOC_COUNT FROM DOCTOR;
	SELECT COUNT(*) INTO E_PEOPLE_COUNT FROM PEOPLE;
	E_DOC_PEOPLE_RATIO := E_PEOPLE_COUNT / E_DOC_COUNT;
	DBMS_OUTPUT.PUT_LINE(E_DOC_PEOPLE_RATIO);
	IF E_MEMBERSHIP_ID = 1 OR E_MEMBERSHIP_ID = 2 THEN
		FOR D IN (SELECT * FROM DOCTOR ORDER BY FEE DESC)
		LOOP
			SELECT COUNT(*) INTO E_COUNT_PATIENTS FROM DIAGNOSED_BY DB WHERE DB.DOCTOR_ID=D.ID;
			IF E_COUNT_PATIENTS <= E_DOC_PEOPLE_RATIO THEN
				INSERT INTO DIAGNOSED_BY (PEOPLE_ID, DOCTOR_ID) VALUES (E_PEOPLE_ID, D.ID);
				EXIT;
			END IF; 
		END LOOP;
	ELSE
		FOR D IN (SELECT * FROM DOCTOR ORDER BY FEE ASC)
		LOOP
			SELECT COUNT(*) INTO E_COUNT_PATIENTS FROM DIAGNOSED_BY DB WHERE DB.DOCTOR_ID=D.ID;
			IF E_COUNT_PATIENTS <= E_DOC_PEOPLE_RATIO THEN
				INSERT INTO DIAGNOSED_BY (PEOPLE_ID, DOCTOR_ID) VALUES (E_PEOPLE_ID, D.ID);
				EXIT;
			END IF; 
		END LOOP;
	END IF;
END;
/

---------------------------------------------------------

CREATE OR REPLACE TRIGGER AUTO_ROOM_ALLOTMENT
AFTER INSERT ON PEOPLE
FOR EACH ROW
DECLARE
	CURR_PEOPLE_ID NUMBER;
	CURR_CAPACITY NUMBER;
	CURR_COUNT NUMBER;
BEGIN
	CURR_PEOPLE_ID := :NEW.ID;
	FOR BR IN (SELECT * FROM BED_ROOM)
	LOOP
		SELECT CAPACITY INTO CURR_CAPACITY FROM ROOM R WHERE R.ID=BR.ROOM_ID;
		SELECT COUNT(*) INTO CURR_COUNT FROM BED_ROOM WHERE ROOM_ID=BR.ROOM_ID;
		IF CURR_COUNT < CURR_CAPACITY THEN
			INSERT INTO ROOM_ALLOTMENT
			(ROOM_ID, PEOPLE_ID)
			VALUES
			(BR.ROOM_ID, CURR_PEOPLE_ID);
			EXIT;
		END IF;
	END LOOP;
END;
/