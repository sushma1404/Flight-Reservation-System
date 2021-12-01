
 # Creating the database flights
 CREATE DATABASE flights;
 USE flights;
 
 # Creating table employee
 CREATE TABLE employee (
  E_ID INTEGER PRIMARY KEY,
  E_NAME TEXT NOT NULL, 	 
  GENDER TEXT NOT NULL,
  ADDRESS VARCHAR(255),
  PH_NO INTEGER,
  DOJ date,
  SALARY INTEGER
);

# Inserting values to the table employee
INSERT INTO employee VALUES (1, 'Ryan', 'M','california',123456789,'1982-04-12',9000);
INSERT INTO employee VALUES (2, 'Albert', 'M','texas',123456789,'1986-04-12',19000);
INSERT INTO employee VALUES (3, 'Kelly','F','NorthCarolina',123456789,'1990-04-15',15000);
INSERT INTO employee VALUES (4, 'Bev', 'F','Gorgia',123456789,'1982-05-12',9500);
INSERT INTO employee VALUES (5, 'Victor', 'M','NewYork',123456789,'1984-04-15',12000);

UPDATE employee SET SALARY = 20000 WHERE E_ID = 3;
# Fetch all the data from table employee
SELECT *
FROM employee;

# Creating table Passenger
create table PASSENGER
(
P_ID INTEGER PRIMARY KEY,
P_NAME VARCHAR(255) ,
SEAT_NO INTEGER,
GENDER VARCHAR(255),
PH_NUMBER VARCHAR(20),
RES_STATUS VARCHAR(255),
E_ID INTEGER,
TICKET_NO INTEGER,
FOREIGN KEY(TICKET_NO)REFERENCES ticket(TICKET_NO)
);

ALTER TABLE PASSENGER
ADD TICKET_NO INTEGER;

# Inserting values to the table Passenger
INSERT INTO passenger VALUES (101,'David',20,'M','9772657863','waiting',3,60001);
INSERT INTO passenger VALUES (102,'Kim Lee',21,'M',7353457863,'confirm',5,60002);
INSERT INTO passenger VALUES (103,'SOURAV',22,'M',9972656763,'waiting',1,60003);
INSERT INTO passenger VALUES (104,'Bairan',25,'M',6322657763,'confirm',4,60004);
INSERT INTO passenger VALUES (105,'Angie',30,'F',6372657583,'waiting',3,60005);

SELECT *
FROM PASSENGER;

# Creating table AIRPORT
create table AIRPORT
(AIRPORT_ID INTEGER PRIMARY KEY,
AIRPORT_NAME VARCHAR(255)
);
# Inserting values to the table Passenger
INSERT INTO AIRPORT VALUES (571,'Norman Y. Mineta San Jose Internationa Airport ');
INSERT INTO AIRPORT VALUES (572,'San Francisco Internationa Airport');
INSERT INTO AIRPORT VALUES (573,'Dallas/Fort Worth Internationa Airport');
INSERT INTO AIRPORT VALUES (574,'Charlotte Douglas International Airport');
INSERT INTO AIRPORT VALUES (575,'John F. Kennedy International Airport');

SELECT *
FROM AIRPORT;

# Creating table flight
create table flight
(FLIGHT_ID INTEGER PRIMARY KEY,
FLIGHT_NAME VARCHAR(255),
AIRPORT_ID INTEGER ,
FOREIGN KEY(AIRPORT_ID)REFERENCES AIRPORT(AIRPORT_ID)
);
# Inserting values to the table Passenger
INSERT INTO flight VALUES (1001,'Delta Air Lines',571);
INSERT INTO flight VALUES (1002,'American Airlines',571);
INSERT INTO flight VALUES (1003,'Frontier Airlines',574);
INSERT INTO flight VALUES (1004,'Southwest Airlines',575);
INSERT INTO flight VALUES (1005,'JetBlue',574);

SELECT *
FROM flight;

# Creating table Fare
create table FARE(
RECEIPT_NO INTEGER PRIMARY KEY,
FLIGHT_ID VARCHAR(255),
FARE INTEGER,
TICKET_NO INTEGER,
CLASS_NAME VARCHAR(255),
FOREIGN KEY(CLASS_NAME)REFERENCES CLASS(CLASS_NAME)
);
# Inserting values to the table Fare
INSERT INTO FARE VALUES (5551,1004,800,60004,'Business');
INSERT INTO FARE VALUES (5552,1003,400,60003,'Economy');
INSERT INTO FARE VALUES (5553,1002,1050,60001,'First Class');
INSERT INTO FARE VALUES (5554,1005,700,60002,'Business');

# Creating table ticket
create table ticket(
TICKET_NO INTEGER PRIMARY KEY,
CLASS_NAME VARCHAR(255),
Source VARCHAR(255),
DESTINATION VARCHAR(255),
FARE INTEGER,
FLIGHT_ID INTEGER,
FOREIGN KEY(FLIGHT_ID)REFERENCES FLIGHT(FLIGHT_ID)
);
# Inserting values to the table ticket
INSERT INTO ticket VALUES (60001,'First Class','CALIFORNIA','NEW YORK',1050,1002);
INSERT INTO ticket VALUES (60002,'Economy','NORTH CAROLINA','DALLAS',450,1005);
INSERT INTO ticket VALUES (60003,'Economy','SAN JOSE','NEWYORK',400,1003);
INSERT INTO ticket VALUES (60004,'Buisiness','CALIFORNIA','NORTH CAROLINA',800,1004);
INSERT INTO ticket VALUES (60005,'Economy','NEW YORK','SAN FRANSISCO',200,1001);

# Creating table Class
create table CLASS(
CLASS_NAME VARCHAR(255)  PRIMARY KEY,
JOURNEY_DATE date ,
NO_OF_SEATS INTEGER,
FLIGHT_ID INTEGER,
FOREIGN KEY(FLIGHT_ID)REFERENCES FLIGHT(FLIGHT_ID) 
);
# Inserting values to the table Class
INSERT INTO CLASS VALUES ('Economy','2021-05-15',211,1001);
INSERT INTO CLASS VALUES ('First Class','2021-05-18',101,1002);
INSERT INTO CLASS VALUES ('Business','2021-05-20',331,1001);
 
# Creating table Time
create table TIME(
REF_NO INTEGER,
DEP_TIME time,
ARR_TIME time,
FLIGHT_ID INTEGER ,
AIRPORT_ID INTEGER
);
# Inserting values to the table Time
INSERT INTO TIME VALUES (11121,'11:00','10:00',1001,571);
INSERT INTO TIME VALUES (11122,'01:00','12:00',1002,573);
INSERT INTO TIME VALUES (11123,'09:00','15:00',1003,574);
INSERT INTO TIME VALUES (11124,'12:00','10:00',1004,572);
INSERT INTO TIME VALUES (11125,'23:00','06:00',1005,575);

# Creating table Route
create table ROUTE(
ROUTE VARCHAR(255) PRIMARY KEY,
ARR_TIME time,
DEP_TIME time,
#STOP_NO INTEGER,
TRIP varchar(255),
TICKET_NO INTEGER,
FOREIGN KEY(TICKET_NO)REFERENCES ticket(TICKET_NO)
);
# Inserting values to the table Route
INSERT INTO ROUTE VALUES (21,'11:00','10:00','Round Trip',60001);
INSERT INTO ROUTE VALUES (23,'01:00','06:00','One Way',60002);
INSERT INTO ROUTE VALUES (25,'13:00','10:00','Multi City',60003);
INSERT INTO ROUTE VALUES (22,'15:00','14:00','Round Trip',60004);
INSERT INTO ROUTE VALUES (24,'10:00','20:00','One Way',60005);

                        # Querries to Fetech Data #######

#1) Fetch the Female employees salaries working for flight booking

SELECT E_NAME, SALARY
FROM employee
WHERE GENDER = 'F' AND SALARY > (SELECT MAX(SALARY)
                       FROM employee
                       WHERE GENDER = 'M');

#2)FETECH PASSENGER GENDER AND RESERVATION STATUES FOR EMP ID 3

SELECT P_NAME as Passenger_Name, GENDER, RES_STATUS, E_ID
FROM PASSENGER
WHERE E_ID = 3;

#3) Fetch all the flights flying from California after 11:00 am

SELECT FARE.FLIGHT_ID, Source, DESTINATION,FLIGHT_NAME,DEP_TIME
FROM FARE,ticket, flight,TIME
WHERE SOURCE = 'CALIFORNIA' AND DEP_TIME > '11:00';

#4) Fetch passenger and their flight and ticket details.

SELECT PASSENGER.P_NAME,ticket.TICKET_NO,ticket.Source, ticket.DESTINATION,ticket.FARE,ticket.CLASS_NAME,ticket.FLIGHT_ID 
FROM ticket
INNER JOIN
PASSENGER ON TICKET.TICKET_NO = PASSENGER.TICKET_NO;

#5) Fetch all the passengers travelling in Economy class and their flight and ticket details.

SELECT PASSENGER.P_NAME,ticket.TICKET_NO,ticket.Source, ticket.DESTINATION,ticket.FARE,ticket.CLASS_NAME,ticket.FLIGHT_ID,ROUTE.TRIP
FROM ticket
INNER JOIN
PASSENGER ON TICKET.TICKET_NO = PASSENGER.TICKET_NO
INNER JOIN 
ROUTE ON TICKET.TICKET_NO = Route.TICKET_NO
WHERE CLASS_NAME = 'ECONOMY';

#6) FETCH all the flight details travelling from San Jose airport
SELECT flight_Id,flight_name,AIRPORT_NAME
FROM flight
LEFT JOIN AIRPORT
ON flight.AIRPORT_ID = AIRPORT.AIRPORT_ID
WHERE AIRPORT_NAME = 'Norman Y. Mineta San Jose Internationa Airport ';

#7)Fetch all the flight details travelling on 2021-05-15 from San Francisco Internationa Airport
SELECT flight.Flight_Id,flight.Flight_name,class.JOURNEY_DATE,AIRPORT.AIRPORT_NAME
FROM flight,class,AIRPORT
WHERE JOURNEY_DATE = '2021-05-15' AND AIRPORT_NAME = 'San Francisco Internationa Airport';





