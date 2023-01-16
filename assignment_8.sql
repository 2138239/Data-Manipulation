create or replace TRIGGER TRANS_update3 before
    INSERT OR UPDATE ON ACCOUNT_DEMO
    FOR EACH ROW
DECLARE
    v_user VARCHAR(100);
    v_date VARCHAR2(100);
BEGIN

    SELECT user, TO_CHAR
(SYSDATE, 'DD-MM-YYYY HH24:MI:SS') into v_user,v_date
FROM DUAL;

    IF inserting THEN
      :new.ins_user := v_user;
      :new.ins_time := TO_timestamp (v_date, 'DD-MM-YYYY HH24:MI:SS');
    end if;
    
    if updating THEN
        :new.upd_user := v_user;
        :new.upd_time := TO_timestamp (v_date, 'DD-MM-YYYY HH24:MI:SS');
    END IF;
END;



insert into account_demo (ACNUMBER, 
CUSTID,       
BID,                     
OPENING_BALANCE,                                   
ATYPE,            
ASTATUS) values ('A00003', 'C00001', 'B00001', 1000, 'Saving', 'Active');

update account_demo
set OPENING_BALANCE=1000
where acnumber='A00003';


SELECT trans_update(1000,'Delhi',10);