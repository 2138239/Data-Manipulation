SET foreign_key_checks = 0;

ALTER TABLE trandetails DISABLE constraint trandetails_acnumber_fk;
INSERT INTO loan SELECT * FROM loan;

create table customer_backup select * from customer;
show tables;
select * from customer_backup;
commit;

create table customer (select * from customer);

--  2)  surrogate key 

alter table bank_target_table
add column ID serial primary key;

select * from bank_target_table;   

truncate table bank_target_table; 

select * from bank_stage_table
where CustomerDOB like '%/##';

alter table bank_stage_table
modify CustomerDOB date;

select*from bank_stage_table;

-- 3)
 