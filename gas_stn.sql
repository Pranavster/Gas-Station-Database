create table product(prod_id int
, prod_name varchar(50)
, prod_type varchar(50)
, eff_dt date
, exp_dt date
, addby varchar(50)
, addwhen datetime
, modby varchar(50)
, modwhen datetime);


create table prod_tran(prod_id int
, prod_date date
, quantity int
, prod_value decimal(10,2)
, addby varchar(50)
, addwhen datetime
, modby varchar(50)
, modwhen datetime);

