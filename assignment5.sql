-- assignment on joins, aggregation, case statements.  22/12/2022
-- Problem 11 # : Find cust full name, city name , branch name who have deposited amount in bank using Cheque mode.
select * from trandetails, customer,branch;
select * from account;
select * from trandetails;
select * from branch;

select distinct concat_ws(' ',c.FNAME, if(TRIM(c.MNAME)='','', c.MNAME),c.LTNAME) as Cust_full_name, c.CITY,
b.BNAME
from customer c join account a
on c.CUSTID=a.CUSTID 
join trandetails t
on a.ACNUMBER=t.ACNUMBER
join branch b
on b.BID=a.BID
where lower(t.TRANSACTION_TYPE)='deposit' and lower(t.MEDIUM_OF_TRANSACTION)='cheque'; 

-- Problem 12 # : Find total transcation amount by type for each customer, if no transcation by customer then assign 0

select * from customer;
select * from account;

select concat_ws(' ',c.FNAME,c.LTNAME) as CUST_NAME, 
if (sum(t.TRANSACTION_AMOUNT)<>0,sum(t.TRANSACTION_AMOUNT),0) as TOTAL_TRANSACTION_AMOUNT 
from customer c
left join account a
	on c.CUSTID=a.CUSTID
left join trandetails t
	on a.ACNUMBER=t.ACNUMBER
group by c.CUSTID;


-- 13.1 : Write SQL display customer’s full name, branch name , transaction_date, TRANSACTION_TYPE, current
--        transaction_amount, previous days transaction_amount, difference between current & previous transaction_amount
select * from trandetails;

select *, abs(curr_TRANSACTION_AMOUNT-prev_TRANSACTION_AMOUNT) as diff_curr_prev_TRANSACTION_AMOUNT from (
	select concat_ws(' ',c.Fname, c.LTNAME) AS CUST_NAME, 
			b.BNAME, 
			t1.DOT as transaction_date,
			t1.TRANSACTION_TYPE,
			t1.TRANSACTION_AMOUNT as curr_TRANSACTION_AMOUNT,
			lag(t1.TRANSACTION_AMOUNT) over(partition by t1.ACNUMBER order by t1.DOT ) as prev_TRANSACTION_AMOUNT
	from customer c
	JOIN account a
		on c.CUSTID=a.CUSTID
	JOIN branch b
		on a.BID=b.BID
	JOIN trandetails t1
		on t1.ACNUMBER=a.ACNUMBER) B;
    
    select * from trandetails;
    
    
-- 13.2 : Write SQL display customer’s full name, branch name , EOM transaction_date, Remaining balance at the end of month 

select concat_ws(' ',c.Fname, c.LTNAME) AS CUST_NAME,
b.BNAME,
t.dot
from customer c
JOIN account a
		on c.CUSTID=a.CUSTID
JOIN branch b
	on a.BID=b.BID
JOIN trandetails t
	on t.ACNUMBER=a.ACNUMBER
where (t.ACNUMBER,t.dot) in 
(select ACNUMBER, max(dot) from trandetails t
group by t.ACNUMBER);

select *, 
case
	when TRANSACTION_TYPE="Deposit" then (OPENING_BALANCE+
 from (
		select concat_ws(' ',c.Fname, c.LTNAME) AS CUST_NAME,
			b.BNAME,
			t.dot, a.OPENING_BALANCE, t.transaction_type
		from customer c
		JOIN account a
			on c.CUSTID=a.CUSTID
		JOIN branch b
			on a.BID=b.BID
		JOIN trandetails t
			on t.ACNUMBER=a.ACNUMBER) B;


-- 13.3 : Write SQL display customer’s full name, branch name , number of transcation made by customer, 
-- total value per transaction_type

select concat_ws(' ',c.Fname, c.LTNAME) AS CUST_NAME,
	b.BNAME, t.ACNUMBER,
	count(t.ACNUMBER) as no_of_trans,
	t.TRANSACTION_TYPE,
	sum(t.TRANSACTION_AMOUNT) as total_value_per_transaction_type
from customer c
JOIN account a
		on c.CUSTID=a.CUSTID
JOIN branch b
	on a.BID=b.BID
JOIN trandetails t
	on t.ACNUMBER=a.ACNUMBER
group by t.ACNUMBER, t.TRANSACTION_TYPE;    

-- Problem 14#: Find customer full name, account type , and balance
-- account type logic : If customer have balance in saving account then "Saving account" , if customer have loan amount then "loan account" , if customer have both balance then "saving loan account"
-- balance logic: If customer have balance in saving account then caculate total account balance , if customer have loan amount then total loan amount. if customer have both balance then difference of two balance

select concat_ws(' ',c.Fname, c.LTNAME) AS CUST_NAME,
case 
when a.OPENING_BALANCE<>0 and l.LOAN_AMOUNT=0 then 'Saving'
else 'saving loan account'
end as 'account type',
case
when  a.OPENING_BALANCE<>0 and (l.LOAN_AMOUNT=0 or l.LOAN_AMOUNT is null) then a.OPENING_BALANCE
when  a.OPENING_BALANCE<>0 and l.LOAN_AMOUNT<>0 then (a.OPENING_BALANCE-l.LOAN_AMOUNT)
end 
as 'final_account_balance'
from customer c
JOIN account a
		on c.CUSTID=a.CUSTID
JOIN trandetails t
	on t.ACNUMBER=a.ACNUMBER
left JOIN loan l
on l.CUSTID=a.CUSTID
group by a.CUSTID;