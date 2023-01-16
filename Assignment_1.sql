-- create database bank;

CREATE TABLE customer(
CUSTID VARCHAR(6),
FNAME VARCHAR(30),
MNAME VARCHAR(30),
LTNAME VARCHAR(30),
CITY VARCHAR (30),
MOBILENO numeric(10),
OCCUPATION VARCHAR(30),
DOB DATE,
CONSTRAINT customer_CUSTID_pk PRIMARY KEY (CUSTID));
DESC CUSTOMER;
alter table customer
modify DOB varchar(15);

INSERT INTO customer SELECT * FROM customer;

create table branch(
BID varchar(6),
BNAME varchar(30),
BCITY varchar(30),
CONSTRAINT Branch_BID_pk PRIMARY KEY (BID)
);

CREATE TABLE account(
ACNUMBER VARCHAR(6),
CUSTID VARCHAR(6),
BID VARCHAR(6),
OPENING_BALANCE INT(20),
AOD DATE,
ATYPE VARCHAR(10),
ASTATUS VARCHAR(10),
PRIMARY KEY (ACNUMBER),
FOREIGN KEY (CUSTID) references customer(CUSTID),
FOREIGN KEY (BID) references branch(BID));
desc account;
alter table account
modify AOD varchar(15);

CREATE TABLE trandetails(
TNUMBER VARCHAR(6),
ACNUMBER VARCHAR(6),
DOT DATE,
MEDIUM_OF_TRANSACTION VARCHAR(20),
TRANSACTION_TYPE VARCHAR(20),
TRANSACTION_AMOUNT INT(7),
CONSTRAINT trandetails_TNUMBER_pk PRIMARY KEY (TNUMBER),
CONSTRAINT trandetails_acnumber_fk FOREIGN KEY (ACNUMBER)
REFERENCES account (ACNUMBER));

alter table trandetails
modify DOT date;
truncate table trandetails; 

desc trandetails;

CREATE TABLE loan(
CUSTID varchar(6),
BID varchar(6),
LOAN_AMOUNT bigint(20),
foreign key(CUSTID) references customer(CUSTID),
foreign key(BID) references branch(BID));