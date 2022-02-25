CREATE OR REPLACE PROCEDURE 
INSERT_INTO_MEDICINE(M_NAME IN VARCHAR2) IS
	CURR_COUNT NUMBER;
BEGIN
	SELECT COUNT(*) INTO CURR_COUNT FROM MEDICINE M WHERE M.NAME LIKE M_NAME;
	IF CURR_COUNT = 0 THEN
		INSERT INTO MEDICINE (NAME) VALUES (M_NAME);
	END IF;
END;
/

---------------------------

CREATE OR REPLACE PROCEDURE INSERT_INTO_SONG(GSM_TITLE IN VARCHAR2) IS
	CURR_COUNT NUMBER;
BEGIN
	SELECT COUNT(*) INTO CURR_COUNT FROM SONG GSM WHERE GSM.TITLE LIKE GSM_TITLE;
	IF CURR_COUNT = 0 THEN
		INSERT INTO SONG (TITLE) VALUES (GSM_TITLE);
	END IF;
END;
/

----------------------------

CREATE OR REPLACE PROCEDURE INSERT_INTO_MOVIE(GSM_TITLE IN VARCHAR2) IS
	CURR_COUNT NUMBER;
BEGIN
	SELECT COUNT(*) INTO CURR_COUNT FROM MOVIE GSM WHERE GSM.TITLE LIKE GSM_TITLE;
	IF CURR_COUNT = 0 THEN
		INSERT INTO MOVIE (TITLE) VALUES (GSM_TITLE);
	END IF;
END;
/

-----------------------------

CREATE OR REPLACE PROCEDURE INSERT_INTO_GAME(GSM_TITLE IN VARCHAR2) IS
	CURR_COUNT NUMBER;
BEGIN
	SELECT COUNT(*) INTO CURR_COUNT FROM GAME GSM WHERE GSM.TITLE LIKE GSM_TITLE;
	IF CURR_COUNT = 0 THEN
		INSERT INTO GAME (TITLE) VALUES (GSM_TITLE);
	END IF;
END;
/

-----------------------------------

CREATE OR REPLACE PROCEDURE INSERT_INTO_DISEASE(D_NAME IN VARCHAR2) IS
	CURR_COUNT NUMBER;
BEGIN
	SELECT COUNT(*) INTO CURR_COUNT FROM DISEASE D WHERE D.NAME LIKE D_NAME;
	IF CURR_COUNT = 0 THEN
		INSERT INTO DISEASE (NAME) VALUES (D_NAME);
	END IF;
END;
/

---------------------------------

CREATE OR REPLACE PROCEDURE PEOPLE_DELETE(P_ID IN NUMBER) IS
	C_ID NUMBER;
BEGIN
	SELECT C.ID INTO C_ID FROM PEOPLE P JOIN CONNECTION CN ON P.ID=CN.PEOPLE_ID
	JOIN CONTACT C ON CN.CONTACT_ID=C.ID WHERE P.ID=P_ID;
	DELETE FROM PEOPLE WHERE ID=P_ID;
	DELETE FROM CONTACT WHERE ID=C_ID;
	DBMS_OUTPUT.PUT_LINE('DONE');
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('ERROR');
END;
/


-------------------------------


-- CREATE OR REPLACE PROCEDURE PEOPLE_DELETE(P_ID IN NUMBER) IS
-- 	C_ID NUMBER;
	
-- 	P_NAME VARCHAR2(50);
-- 	P_GENDER VARCHAR2(20);
-- 	P_BIRTHDAY DATE;
-- 	P_phone_no VARCHAR2(15);
-- 	H_HEIGHT VARCHAR2(10);
-- 	H_WEIGHT VARCHAR2(10);
-- 	H_BLOOD_GROUP VARCHAR2(10);
-- 	H_VACCINE VARCHAR2(150);
-- 	H_DISABILITY VARCHAR2(150);
-- 	H_HEALTH_CONDITION VARCHAR2(200);
-- 	H_ALLERGY VARCHAR2(150);
-- 	D_DOCTOR_ID NUMBER;
	
-- 	H_COUNT NUMBER;
-- 	D_COUNT NUMBER;
-- BEGIN
-- 	SELECT C.ID INTO C_ID FROM PEOPLE P JOIN CONNECTION CN ON P.ID=CN.PEOPLE_ID
-- 	JOIN CONTACT C ON CN.CONTACT_ID=C.ID WHERE P.ID=P_ID;
	
-- 	SELECT NAME, GENDER, BIRTHDAY, phone_no
-- 	INTO P_NAME, P_GENDER, P_BIRTHDAY, P_phone_no
-- 	FROM PEOPLE WHERE ID=P_ID;
-- 	SELECT HEIGHT, WEIGHT, BLOOD_GROUP, VACCINE, DISABILITY, HEALTH_CONDITION, ALLERGY
-- 	INTO H_HEIGHT, H_WEIGHT, H_BLOOD_GROUP, H_VACCINE, H_DISABILITY, H_HEALTH_CONDITION, H_ALLERGY
-- 	FROM HEALTH_RECORD WHERE PEOPLE_ID=P_ID;
-- 	SELECT D.ID INTO D_DOCTOR_ID FROM PEOPLE P JOIN DIAGNOSED_BY DB ON P.ID=DB.PEOPLE_ID
-- 	JOIN DOCTOR D ON DB.DOCTOR_ID=D.ID WHERE P.ID=P_ID;
-- 	SELECT COUNT(*) INTO H_COUNT FROM HEALTH_RECORD WHERE PEOPLE_ID=P_ID;
-- 	SELECT COUNT(*) INTO D_COUNT FROM PEOPLE P JOIN DIAGNOSED_BY DB ON P.ID=DB.PEOPLE_ID
-- 	JOIN DOCTOR D ON DB.DOCTOR_ID=D.ID WHERE P.ID=P_ID;
	
-- 	DELETE FROM PEOPLE WHERE ID=P_ID;
-- 	DELETE FROM CONTACT WHERE ID=C_ID;
	
-- 	INSERT INTO PEOPLE_DELETED 
-- 	(ID, NAME, GENDER, BIRTHDAY, phone_no, HEIGHT, WEIGHT, BLOOD_GROUP, VACCINE, DISABILITY, HEALTH_CONDITION, ALLERGY, DOCTOR_ID)
-- 	VALUES
-- 	(P_ID, P_NAME, P_GENDER, P_BIRTHDAY, P_phone_no, H_HEIGHT, H_WEIGHT, H_BLOOD_GROUP, H_VACCINE, H_DISABILITY, H_HEALTH_CONDITION, H_ALLERGY, D_DOCTOR_ID);
	
-- 	DBMS_OUTPUT.PUT_LINE('DONE');
-- END;
-- /