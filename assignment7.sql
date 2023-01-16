create or replace trigger target_br_i
before insert on target_table1
for each row
begin
  :new.Id := target_seq.nextval;
end;

SELECT * FROM ALL_OBJECTS
WHERE OBJECT_NAME LIKE '%TARGET_SEQ%';

SELECT TARGET_SEQ.NEXTVAL FROM DUAL;

select * from target_table1;

INSERT INTO target_table1 (TRANSACTIONID,
CUSTOMERID,
CUSTOMERDOB, 
CUSTGENDER,              
CUSTLOCATION,              
CUSTACCOUNTBALANCE,         
TRANSACTIONDATE,                   
TRANSACTIONTIME,         
TRANSACTIONAMOUNT)
(select TRANSACTIONID,
CUSTOMERID,
CUSTOMERDOB, 
CUSTGENDER,              
CUSTLOCATION,              
CUSTACCOUNTBALANCE,         
TRANSACTIONDATE,                   
TRANSACTIONTIME,         
TRANSACTIONAMOUNT from stage_table1); 

COMMIT;