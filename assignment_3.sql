-- 1) create view temp_user as select * from users;
-- create view SMALL_ACCOUNTS  as 
-- select * from bank_target_table order by CustAccountBalance
-- where 
create view SMALL_ACCOUNTS as
select * from (select *, row_number() over (order by CustAccountBalance) as account_row_num from bank_target_table) B
where account_row_num<=(((select count(*) from bank_target_table)/100)*30);

create view MEDIUM_ACCOUNTS  as
select * from (select *, row_number() over (order by CustAccountBalance) as account_row_num from bank_target_table) B
where account_row_num between round((((select count(*) from bank_target_table)/100)*30)+1) and round((((select count(*) from bank_target_table)/100)*70));

create view LARGE_ACCOUNTS   as
select * from (select *, row_number() over (order by CustAccountBalance) as account_row_num from bank_target_table) B
where account_row_num >round((((select count(*) from bank_target_table)/100)*70));