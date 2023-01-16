-- assignment on join
-- Problem # 1: Write a query to display the customer number, firstname, customer’s date of birth. 
-- Display in sorted order of date of birth year and within that sort by firstname.
select * from customer;

select CUSTID, 
	    FNAME,
	      DOB 
FROM CUSTOMER
order by year(DOB), FNAME;

# 2: Write a query to display the customer’s number, first name, and middle name. 
# The customer’s who don’t have a middle name, for them display the last name. Give the alias name as Cust_Name.

select * from customer;
select * from customer 
where TRIM(MNAME)='';

select CUSTID, FNAME, if(TRIM(MNAME)='',LTNAME, MNAME) as Cust_Name from customer;

# 3:Write a query to display account number, customer’s number, customer’s firstname,lastname,account opening date.

select * from account;

select a.ACNUMBER,a.CUSTID, c.FNAME, c.LTNAME, a.AOD from account a join customer c
on a.CUSTID=c.CUSTID;

# 4: Write a query to display the number of customer’s from Delhi. Give the count an alias name of Cust_Count.

select * from customer;

select count(*) as Cust_Count from customer
where lower(city)='delhi';

# 5: Write a query to display  the customer number, customer firstname, account number for the customer’s 
--   whose accounts were created after 15th of any month.

select a.CUSTID, c.FNAME, a.ACNUMBER,a.AOD from account a join customer c
on a.CUSTID=c.CUSTID
where dayofmonth(a.AOD)>15;

# 6: Write a query to display the female customers firstname, city and account number who are not into business, service or studies.
select * from customer;

select c.FNAME,c.city, a.ACNUMBER from account a join customer c
on a.CUSTID=c.CUSTID
where lower(c.gender)='f'
and lower(c.OCCUPATION) not in ('business', 'service', 'student');

# 7: Write a query to display city name and count of branches in that city. 
-- Give the count of branches an alias name of Count_Branch.

select * from branch;

select Bcity, count(*) Count_Branch from branch
group by BCITY order by Count_branch;

# 8: Write a query to display account id, customer’s firstname, customer’s lastname for the customer’s whose account is Active

select a.ACNUMBER,c.FNAME, c.LTNAME, a.ASTATUS from customer c
join account a
on c.CUSTID=a.CUSTID
where lower(a.ASTATUS) like '%active%';

# 9: Write a query to display the customer’s number, customer’s firstname, 
-- branch id and loan amount for people who have taken loans.

select * from customer join branch join loan;

select c.CUSTID, c.FNAME, b.BID, L.LOAN_AMOUNT from customer c 
join loan L
on c.CUSTID=L.CUSTID
join
branch b 
on b.BID=L.BID;

# 10: Write a query to display customer number, customer name, account number where the account status is terminated.

select c.CUSTID, concat_ws(' ', c.FNAME,c.LTNAME) AS FULL_LAST, A.ACNUMBER  
from customer c 
join account a
on c.CUSTID=a.CUSTID
where lower(a.ASTATUS) like '%terminated%';

select * from customer c left join account a 
on c.CUSTID=a.CUSTID
union 
select * from customer c right join account a 
on c.CUSTID=a.CUSTID;