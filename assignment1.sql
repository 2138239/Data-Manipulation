CREATE TABLE customer6(
CUSTID VARCHAR(6),
FNAME VARCHAR(30),
mname VARCHAR(30),
ltname VARCHAR(30),
CITY VARCHAR(15),
MOBILENO VARCHAR(10),
occupation VARCHAR(10),
DOB DATE,
-- PRIMARY KEY (CUSTID));
 
 select * from trandetails6;
 
 
 
desc customer6;

CREATE TABLE branch6(
BID VARCHAR(6),
bNAME VARCHAR(30),
bcity VARCHAR(30),
 PRIMARY KEY (BID));

CREATE TABLE account6(
ACNUMBER VARCHAR(30),
CUSTID VARCHAR(30),
BID VARCHAR(30),
OPENING_BALANCE INT,
AOD date,
ATYPE VARCHAR(10),
ASTATUS VARCHAR(10),
PRIMARY KEY (ACNUMBER),
FOREIGN KEY (CUSTID) references customer6(CUSTID),
FOREIGN KEY (BID) references branch6(BID));

CREATE TABLE TRANDETAILS6(
TNUMBER VARCHAR(6),
ACNUMBER VARCHAR(6),
DOT DATE,
medium_of_transaction VARCHAR(20),
transaction_type VARCHAR(20),
transaction_amount INT,
 PRIMARY KEY (tnumber),
FOREIGN KEY (ACNUMBER)
REFERENCES account6 (ACNUMBER));

CREATE TABLE loan6
(CUSTID varchar(30),
BID varchar(20),
loan_amount INT,
foreign key(custid) references customer6(custID));

commit;
ALTER TABLE table_name DISABLE CONSTRAINT constraint_name;

--Q4)

create table customer_dummy as (select * from customer6);