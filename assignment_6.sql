-- 29/12/2022
/* Update all accounts and add RS 500 to the opening balance only when the customer has opening date is more than 10 years
and for the customers in city east julie* ALSO update the added amount in the transaction table as deposited amount*/

UPDATE account a 
SET a.OPENING_BALANCE=a.OPENING_BALANCE+500
WHERE DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),a.AOD)), '%Y')>10
    AND A.ASTATUS='Active'
    AND A.CUSTID IN (SELECT CUSTID FROM CUSTOMER WHERE CITY='East Julie');

select *from account;
commit;


-- 29/12/2022
/*Parameterise the bonus amount, the city and also the account age in year */


DELIMITER $$
CREATE FUNCTION update_trans
(
 AMOUNT INTEGER,
 CITY varchar(30),
 ACCOUNT_AGE int
)
RETURNS boolean
DETERMINISTIC
BEGIN
    DECLARE L_AMOUNT INTEGER;
    DECLARE L_CITY VARCHAR(30);
    DECLARE L_ACCOUNT_AGE INT;
    SET L_AMOUNT=AMOUNT;
    SET L_CITY=CITY;
    SET L_ACCOUNT_AGE=ACCOUNT_AGE;
    
	UPDATE account a
	INNER JOIN customer c 
		ON a.custid = c.custid
	SET a.OPENING_BALANCE = a.OPENING_BALANCE+L_AMOUNT
		where DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),a.AOD)), '%Y')>(L_ACCOUNT_AGE) and
			  A.ASTATUS='Active' and c.CITY=L_CITY;
RETURN TRUE; 
END$$
DELIMITER ;

SELECT update_trans(1000,'Delhi',10);
rollback;