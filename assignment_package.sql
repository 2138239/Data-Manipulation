create or replace package Bank_data
as 
procedure Trans_update1(
AMOUNT INTEGER,
CITY IN varchar2,
ACCOUNT_AGE IN INT
);

function Trans_update(
AMOUNT INTEGER,
CITY IN varchar2,
ACCOUNT_AGE IN INT
)return boolean;

end;
/

create or replace package body
BANK_DATA
AS 

procedure Trans_update1(
AMOUNT INTEGER,
CITY IN varchar2,
ACCOUNT_AGE IN INT
)
as 
  L_AMOUNT INTEGER;
  L_CITY VARCHAR2(30);
  L_ACCOUNT_AGE INT;
  row_count INT;

  invalid_bonus EXCEPTION;
  invalid_account_age EXCEPTION; 

  BEGIN
     L_AMOUNT := AMOUNT;
     L_CITY := CITY;
     L_ACCOUNT_AGE := ACCOUNT_AGE;
     row_count:=0;

    if (L_AMOUNT <0 or L_AMOUNT>1000)
         then raise invalid_bonus;
    end if;     

    if (L_ACCOUNT_AGE<0)
        then raise invalid_account_age;
    end if;

   if (L_CITY is null or L_city='')
    then 
    UPDATE ACCOUNT A
        SET A.OPENING_BALANCE=A.OPENING_BALANCE+L_AMOUNT
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,A.AOD))>(L_ACCOUNT_AGE*12)
        AND A.ASTATUS='Active';

    else 
    UPDATE ACCOUNT A
        SET A.OPENING_BALANCE=A.OPENING_BALANCE+L_AMOUNT
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,A.AOD))>(L_ACCOUNT_AGE*12)
        AND A.ASTATUS='Active'
        AND A.CUSTID IN (SELECT CUSTID FROM CUSTOMER WHERE CITY=L_CITY);
    end if;
row_count:=sql%RowCount;
DBMS_OUTPUT.PUT_LINE('No of row Updated '|| row_count);

EXCEPTION
   WHEN invalid_bonus then 
        DBMS_OUTPUT.PUT_LINE('Bonus amount is invalid');

   WHEN invalid_account_age  THEN 
      dbms_output.put_line('Age_amount is invalid'); 

   WHEN others THEN 
      dbms_output.put_line('Error!');   

END;

function Trans_update(
AMOUNT INTEGER,
CITY IN varchar2,
ACCOUNT_AGE IN INT
)return boolean
is 
  L_AMOUNT INTEGER;
  L_CITY VARCHAR2(30);
  L_ACCOUNT_AGE INT;

  BEGIN
     L_AMOUNT := AMOUNT;
     L_CITY := CITY;
     L_ACCOUNT_AGE := ACCOUNT_AGE;


  if (L_CITY is null)
    then 
    UPDATE ACCOUNT A
        SET A.OPENING_BALANCE=A.OPENING_BALANCE+L_AMOUNT
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,A.AOD))>(L_ACCOUNT_AGE*12)
        AND A.ASTATUS='Active';
    end if;

    if (L_city is not null)    
    then UPDATE ACCOUNT A
    SET A.OPENING_BALANCE=A.OPENING_BALANCE+L_AMOUNT
    WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,A.AOD))>(L_ACCOUNT_AGE*12)
    AND A.ASTATUS='Active'
    AND A.CUSTID IN (SELECT CUSTID FROM CUSTOMER WHERE CITY=L_CITY);
    end if;    
--UPDATE ACCOUNT A
--    SET A.OPENING_BALANCE=A.OPENING_BALANCE+L_AMOUNT
--    WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,A.AOD))>(L_ACCOUNT_AGE*12)
--    AND A.ASTATUS='Active'
--    AND A.CUSTID IN (SELECT CUSTID FROM CUSTOMER WHERE CITY=L_CITY);
    return True;    
  END;
END;  
/

select * from account;

execute bank_data.trans_update1(1000,'Nagpur',8);

rollback;

