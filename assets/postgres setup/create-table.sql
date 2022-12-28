CREATE TABLE USERS (
	ID NUMERIC,
	USERNAME VARCHAR(50) NOT NULL,
	HASHED_PASSWORD VARCHAR(256) NOT NULL,
	ROLE VARCHAR(10)
);

CREATE SEQUENCE People_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE People (
	id NUMERIC DEFAULT NEXTVAL ('People_seq'),
	name VARCHAR(50) NOT NULL,
	gender VARCHAR(20) NOT NULL,
	birthday DATE,
	phone_no VARCHAR(15),

	CONSTRAINT PEOPLE_PK primary key(id) 
);

CREATE SEQUENCE staff_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE staff (
	id NUMERIC DEFAULT NEXTVAL ('staff_seq'),
	name VARCHAR(50) not NULL,
	birthdate DATE,
	salary numeric(8,2),

	CONSTRAINT STAFF_PK primary key(id) 
);
	 

CREATE SEQUENCE doctor_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE doctor (
	id NUMERIC DEFAULT NEXTVAL ('doctor_seq'),
	name VARCHAR(50) not NULL,
	qualification VARCHAR(150) not NULL,
	hospital_name VARCHAR(50) not NULL,
	phone_no VARCHAR(15),
	email_address VARCHAR(30),
	fee numeric(8,2),

	CONSTRAINT DOCTOR_PK primary key(id) 
);
	 

CREATE SEQUENCE contact_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE contact (
	id NUMERIC DEFAULT NEXTVAL ('contact_seq'),
	name VARCHAR(50) NOT NULL,
	phone_no VARCHAR(15),
	address VARCHAR(100),
	
	CONSTRAINT CONTACT_PK primary key(id) 
);


CREATE SEQUENCE game_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE game(
	id NUMERIC DEFAULT NEXTVAL ('game_seq'),
	title VARCHAR(20) not NULL,

	CONSTRAINT GAME_PK primary key(id)
);


CREATE SEQUENCE movie_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE movie(
	id NUMERIC DEFAULT NEXTVAL ('movie_seq'),
	title VARCHAR(20) not NULL,

	CONSTRAINT MOVIE_PK primary key(id)
);


CREATE SEQUENCE song_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE song(
	id NUMERIC DEFAULT NEXTVAL ('song_seq'),
	title VARCHAR(20) not NULL,

	CONSTRAINT SONG_PK primary key(id)
);


CREATE SEQUENCE medicine_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE medicine (
	id NUMERIC DEFAULT NEXTVAL ('medicine_seq'),
  name VARCHAR(20) NOT NULL,
	cost NUMERIC(38,0),

	CONSTRAINT MEDICINE_PK primary key(id) 
);
	

CREATE SEQUENCE disease_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE disease (
	id NUMERIC DEFAULT NEXTVAL ('disease_seq'),
	name VARCHAR(30) not NULL,

	CONSTRAINT DESEASE_PK primary key(id) 
);



CREATE SEQUENCE books_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE books (
	id NUMERIC DEFAULT NEXTVAL ('books_seq'),
	name VARCHAR(30) not NULL,
	genre VARCHAR(30),
	language VARCHAR(30),

	CONSTRAINT BOOKS_PK primary key(id) 
);


CREATE SEQUENCE food_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE food (
	id NUMERIC DEFAULT NEXTVAL ('food_seq'),
	name VARCHAR(30) not NULL,
	food_type VARCHAR(30) not NULL,
	cost numeric(8,2),

	CONSTRAINT FOOD_PK primary key(id) 
);


CREATE TABLE room(
	id NUMERIC(38,0) NOT NULL,
	capacity VARCHAR(30),

	CONSTRAINT ROOM_PK primary key(id)
);



CREATE TABLE connection (
	people_id NUMERIC NOT NULL,
	contact_id NUMERIC NOT NULL,
    	relationship VARCHAR(50),

	CONSTRAINT CONNECTION_PK primary key(people_id,contact_id),
	CONSTRAINT CONNECTION_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT CONNECTION_CONTACT_FK foreign key (contact_id) references CONTACT(ID) ON DELETE CASCADE
);


CREATE TABLE takes_medicine (
	people_id NUMERIC NOT NULL,
	medicine_id NUMERIC NOT NULL,
  	time VARCHAR(30) not NULL,

	CONSTRAINT TAKES_MEDICINE_PK primary key(people_id,medicine_id,time),
	CONSTRAINT TAKES_MEDICINE_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT TAKES_MEDICINE_MEDICINE_FK foreign key (medicine_id) references MEDICINE(ID)
);



CREATE SEQUENCE prescription_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE prescription(
  id INT DEFAULT NEXTVAL ('prescription_seq'),
	prescribing_date TIMESTAMP(0),
	people_id NUMERIC NOT NULL,
	doctor_id NUMERIC NOT NULL,
	medicine_id NUMERIC NOT NULL,

	CONSTRAINT PRESCRIPTION_PK primary key(ID, prescribing_date, people_id,medicine_id),
	CONSTRAINT PRESCRIPTION_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT PRESCRIPTION_MEDICINE_FK foreign key (medicine_id) references MEDICINE(ID)
);


CREATE SEQUENCE appointment_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE appointment(
  id INT DEFAULT NEXTVAL ('appointment_seq'),
	appointed_date TIMESTAMP(0),
	people_id NUMERIC NOT NULL,
	doctor_id NUMERIC NOT NULL,
  REASON VARCHAR(256),
  accepted CHAR(1),

	CONSTRAINT appointment_PK primary key(ID)
);
	 

CREATE TABLE cures (
	disease_id NUMERIC NOT NULL,
	medicine_id NUMERIC NOT NULL,

	CONSTRAINT CURES_PK primary key(disease_id,medicine_id),
	CONSTRAINT CURES_DISEASE_FK foreign key (disease_id) references DISEASE(ID),
	CONSTRAINT CURES_MEDICINE_FK foreign key (medicine_id) references MEDICINE(ID)
);
	 

CREATE TABLE suffer_from (
	people_id NUMERIC NOT NULL,
	disease_id NUMERIC NOT NULL,

	CONSTRAINT SUFFER_FROM_PK primary key(people_id,disease_id),
	CONSTRAINT SUFFER_FROM_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT SUFFER_FROM_DISEASE_FK foreign key (disease_id) references DISEASE(ID)
);
	 



CREATE TABLE diagnosed_by(
	people_id NUMERIC NOT NULL,
	doctor_id NUMERIC NOT NULL,

	CONSTRAINT DIAGNOSED_BY_PK primary key(people_id,doctor_id),
	CONSTRAINT DIAGNOSED_BY_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT DIAGNOSED_BY_DOCTOR_FK foreign key (doctor_id) references DOCTOR(ID) On DELETE CASCADE
);


CREATE SEQUENCE health_record_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE health_record(
	id NUMERIC DEFAULT NEXTVAL ('health_record_seq'),
	people_id NUMERIC NOT NULL,
	height VARCHAR(10),
	weight VARCHAR(10),
	blood_group VARCHAR(10) not null ,
	vaccine VARCHAR(150),
	disability VARCHAR(150),
	health_condition VARCHAR(200),
	allergy VARCHAR(150),

	CONSTRAINT HEALTH_RECORD_PK primary key(id),
	CONSTRAINT HEALTH_RECORD_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE
);


CREATE TABLE book_issue(
	book_id NUMERIC NOT NULL,
	people_id NUMERIC NOT NULL,
	issue_date DATE,
	return_date DATE,
	cost NUMERIC,
	
	CONSTRAINT BOOK_ISSUE_PK primary key(book_id,people_id),
	CONSTRAINT BOOK_ISSUE_BOOKS_FK foreign key (book_id) references BOOKS(ID),
	CONSTRAINT BOOK_ISSUE_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE
);


CREATE SEQUENCE membership_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE membership(
  ID NUMERIC DEFAULT NEXTVAL ('membership_seq'),
	membership_type VARCHAR(20),
	yearly_charge numeric(8,2),

	CONSTRAINT MEMBERSHIP_PK primary key(ID)
);


CREATE TABLE SUBSCRIPTION(
    people_id NUMERIC NOT NULL,
    MEMBERSHIP_ID NUMERIC NOT NULL,
    starting_date DATE,

    CONSTRAINT SUBSCRIPTION_PK primary key(membership_ID, people_id),
    CONSTRAINT SUBSCRIPTION_PEOPLE_FK foreign key(people_id) references PEOPLE(ID) ON DELETE CASCADE,
    CONSTRAINT SUBSCRIPTION_MEMBERSHIP_FK foreign key(MEMBERSHIP_ID) references MEMBERSHIP(ID)
);


CREATE TABLE account(
	bank_account_NO VARCHAR(50),
  bank_name VARCHAR(50),
	people_id NUMERIC NOT NULL,
	balance NUMERIC,

	CONSTRAINT ACCOUNT_PK primary key(bank_account_NO, people_id),
	CONSTRAINT ACCOUNT_PEOPLE_FK foreign key (people_id ) references PEOPLE(ID) ON DELETE CASCADE
);


CREATE SEQUENCE TRANSACTIONS_seq START WITH 500 INCREMENT BY 1;

CREATE TABLE TRANSACTIONS(
  ID NUMERIC DEFAULT NEXTVAL ('TRANSACTIONS_seq'),
  bank_account_NO VARCHAR(50) NOT NULL,
  people_id NUMERIC NOT NULL,
  TRX_TYPE VARCHAR(50),
  DETAILS VARCHAR(1000),
  TRX_DATE DATE,
  AMOUNT NUMERIC,
  IN_OUT VARCHAR(10),

  CONSTRAINT TRANSACTIONS_PK primary KEY(ID),
  CONSTRAINT TRANSACTIONS_ACCOUNT_FK FOREIGN KEY (bank_account_NO, PEOPLE_ID) REFERENCES ACCOUNT(bank_account_NO, PEOPLE_ID) ON DELETE CASCADE
);


CREATE TABLE DONATION(
  NAME VARCHAR(50),
  PHONE_NO VARCHAR(15),
  SOURCE VARCHAR(50),
  SUGGESTIONS VARCHAR(1000),
  AMOUNT NUMERIC,
  TRX_ID VARCHAR(50),
  DONATING_DATE DATE
);


CREATE TABLE staff_schedule(
	day VARCHAR(20),
	staff_id NUMERIC NOT NULL,
	reporting_time VARCHAR(20),
	leaving_time VARCHAR(20),
	room_id NUMERIC NOT NULL,

	CONSTRAINT STAFF_SCHEDULE_PK primary key(day,staff_id,room_id),
	CONSTRAINT STAFF_SCHEDULE_STAFF_FK foreign key (staff_id) references STAFF(ID) ON DELETE CASCADE,
	CONSTRAINT STAFF_SCHEDULE_ROOM_FK foreign key (room_id) references ROOM(ID) ON DELETE CASCADE
);
	 


CREATE TABLE emergency_room(
	room_id NUMERIC NOT NULL,

	CONSTRAINT EMERGENCY_ROOM_PK primary key(room_id),
	CONSTRAINT EMERGENCY_ROOM_ROOM_FK foreign key(room_id) references ROOM(ID) ON DELETE CASCADE
);



CREATE TABLE COMMON_ROOM(
	room_id NUMERIC NOT NULL,

	CONSTRAINT COMMON_ROOM_PK primary key(room_id),
	CONSTRAINT COMMON_ROOM_ROOM_FK foreign key(room_id) references ROOM(ID) ON DELETE CASCADE
);



CREATE TABLE LIBRARY_ROOM(
	room_id NUMERIC NOT NULL,

	CONSTRAINT LIBRARY_ROOM_PK primary key(room_id),
	CONSTRAINT LIBRARY_ROOM_ROOM_FK foreign key(room_id) references ROOM(ID) ON DELETE CASCADE
);



CREATE TABLE BED_ROOM(
	room_id NUMERIC NOT NULL,

	CONSTRAINT BED_ROOM_PK primary key(room_id),
	CONSTRAINT BED_ROOM_ROOM_FK foreign key(room_id) references ROOM(ID) ON DELETE CASCADE
);



CREATE TABLE DINING_ROOM(
	room_id NUMERIC NOT NULL,

	CONSTRAINT DINING_ROOM_PK primary key(room_id),
	CONSTRAINT DINING_ROOM_ROOM_FK foreign key(room_id) references ROOM(ID) ON DELETE CASCADE
);


CREATE TABLE menu(
	room_id NUMERIC NOT NULL,
	food_id NUMERIC NOT NULL,

	CONSTRAINT MENU_PK primary key(room_id,food_id),
	CONSTRAINT MENU_DINING_ROOM_FK foreign key (room_id) references DINING_ROOM(room_id),
	CONSTRAINT MENU_FOOD_FK foreign key (food_id) references FOOD(ID) ON DELETE CASCADE
);


CREATE TABLE room_allotment(
	room_id NUMERIC NOT NULL,
	people_id NUMERIC NOT NULL,

	CONSTRAINT ROOM_ALLOTMENT_PK primary key(room_id,people_id),
	CONSTRAINT ROOM_ALLOTMENT_BED_ROOM_FK foreign key (room_id) references BED_ROOM(room_id),
	CONSTRAINT ROOM_ALLOTMENT_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE
);


CREATE TABLE contains_books(
	room_id NUMERIC NOT NULL,
	book_id NUMERIC NOT NULL,

	CONSTRAINT CONTAINS_BOOKS_PK primary key(room_id,book_id),
	CONSTRAINT CONTAINS_BOOKS_LIBRARY_ROOM_FK foreign key (room_id) references LIBRARY_ROOM(room_id),
	CONSTRAINT CONTAINS_BOOKS_BOOKS_FK foreign key (book_id) references BOOKS(ID)
);


CREATE TABLE emergency_doctors(
	room_id NUMERIC NOT NULL,
	doctor_id NUMERIC NOT NULL,
	people_id NUMERIC NOT NULL,

	CONSTRAINT EMERGENCY_DOCTORS_PK primary key(room_id,doctor_id, people_id),
	CONSTRAINT EMERGENCY_DOCTORS_EMERGENCY_ROOM_FK foreign key (room_id) references EMERGENCY_ROOM(room_id),
	CONSTRAINT EMERGENCY_DOCTORS_DOCTOR_FK foreign key (doctor_id) references DOCTOR(ID) On DELETE CASCADE,
	CONSTRAINT EMERGENCY_DOCTORS_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE
);


CREATE TABLE game_facilities(
	room_id NUMERIC NOT NULL,
	game_id NUMERIC NOT NULL,

	CONSTRAINT GAME_FACILITIES_PK primary key(room_id,game_id),
	CONSTRAINT GAME_FACILITIES_COMMON_ROOM_FK foreign key (room_id) references COMMON_ROOM(room_id),
	CONSTRAINT GAME_FACILITIES_GAME_FK foreign key (game_id) references GAME(ID)
);


CREATE TABLE movie_facilities(
	room_id NUMERIC NOT NULL,
	movie_id NUMERIC NOT NULL,

	CONSTRAINT MOVIE_FACILITIES_PK primary key(room_id,movie_id),
	CONSTRAINT MOVIE_FACILITIES_COMMON_ROOM_FK foreign key (room_id) references COMMON_ROOM(room_id),
	CONSTRAINT MOVIE_FACILITIES_MOVIE_FK foreign key (movie_id) references MOVIE
);



CREATE TABLE song_facilities(
	room_id NUMERIC NOT NULL,
	song_id NUMERIC NOT NULL,

	CONSTRAINT SONG_FACILITIES_PK primary key(room_id,song_id),
	CONSTRAINT SONG_FACILITIES_COMMON_ROOM_FK foreign key (room_id) references COMMON_ROOM(room_id),
	CONSTRAINT SONG_FACILITIES_SONG_FK foreign key (song_id) references SONG(ID)
);



CREATE TABLE game_favorites(
	people_id NUMERIC NOT NULL,
	game_id NUMERIC NOT NULL,

	CONSTRAINT GAME_FAVORITES_PK primary key(people_id,game_id),
	CONSTRAINT GAME_FAVORITES_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT GAME_FAVORITES_GAME_FK foreign key (game_id) references GAME(ID)
);


CREATE TABLE movie_favorites(
	people_id NUMERIC NOT NULL,
	movie_id NUMERIC NOT NULL,

	CONSTRAINT MOVIE_FAVORITES_PK primary key(people_id,movie_id),
	CONSTRAINT MOVIE_FAVORITES_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT MOVIE_FAVORITES_MOVIE_FK foreign key (movie_id) references MOVIE(ID)
);


CREATE TABLE song_favorites(
	people_id NUMERIC NOT NULL,
	song_id NUMERIC NOT NULL,

	CONSTRAINT SONG_FAVORITES_PK primary key(people_id,song_id),
	CONSTRAINT SONG_FAVORITES_PEOPLE_FK foreign key (people_id) references PEOPLE(ID) ON DELETE CASCADE,
	CONSTRAINT SONG_FAVORITES_SONG_FK foreign key (song_id) references SONG(ID)
);

CREATE TABLE DELETED_PEOPLE (
	id NUMERIC,
	name VARCHAR(50),
	gender VARCHAR(20),
	birthday DATE,
	phone_no VARCHAR(15),
	DELETED_ON DATE
);


CREATE TABLE DELETED_STAFF (
	id NUMERIC,
	name VARCHAR(50),
	birthdate DATE,
	salary numeric(8,2),
	DELETED_ON DATE
);


CREATE TABLE DELETED_DOCTOR (
	id NUMERIC,
	name VARCHAR(50),
	qualification VARCHAR(150),
	hospital_name VARCHAR(50),
	phone_no VARCHAR(15),
	email_address VARCHAR(30),
	fee numeric(8,2),
	DELETED_ON DATE
);