create table stage_product_master(
product_id INT,
product_name NVARCHAR2(30),
product_weight INT,
product_price NUMBER(19));

create table DIM_product(
Product_id INT,
Product_name NVARCHAR2(30),
Product_weight INT,
Product_price NUMBER(19),
Active_flag int,
Start_date date,
End_date date);

insert into stage_product_master (PRODUCT_ID,PRODUCT_NAME, PRODUCT_WEIGHT,PRODUCT_PRICE)
values (101,'POCO X4 Pro',205,14499);

insert into stage_product_master (PRODUCT_ID,PRODUCT_NAME, PRODUCT_WEIGHT,PRODUCT_PRICE)
values (102,'POCO F4 5G',195,27999);

insert into stage_product_master (PRODUCT_ID,PRODUCT_NAME, PRODUCT_WEIGHT,PRODUCT_PRICE)
values (103,'realmi s2',210,16000);

insert into stage_product_master (PRODUCT_ID,PRODUCT_NAME, PRODUCT_WEIGHT,PRODUCT_PRICE)
values (104,'redmi 11T pro',190,13000);
commit;

MERGE INTO DIM_product trg
   USING (SELECT * from stage_product_master) SPM
   ON (trg.product_id = SPM.product_id)
   
   WHEN MATCHED THEN UPDATE SET
     trg.product_name=SPM.product_name,
     trg.product_weight=SPM.product_weight,
     trg.product_price=SPM.product_price,
     trg.Active_flag=1
     
   WHEN NOT MATCHED THEN INSERT (Product_id,
Product_name,
Product_weight,
Product_price,
Active_flag,
Start_date,
End_date)
VALUES (SPM.Product_id, SPM.Product_name, SPM.Product_weight, SPM.Product_price, 1, sysdate, '13-JAN-98');

MERGE INTO DIM_product trg
   USING (SELECT * from stage_product_master) SPM
   ON (trg.product_id !=SPM.product_id )    
WHEN MATCHED THEN 
UPDATE SET
     trg.Active_flag=0,
     trg.end_date=sysdate
     where to_char(trg.end_date, 'DD-MON-YY')='13-JAN-98';

set safe_sql_updates=0;     
     commit;
     
select * from stage_product_master;
select * from dim_product;

rollback;

delete from stage_product_master
where product_id=103;

