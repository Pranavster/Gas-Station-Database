create table neo_prod(prod_id int
, prod_name varchar(50)
, prod_type varchar(50)
, eff_dt date
, exp_dt date
, addby varchar(50)
, addwhen datetime
, modby varchar(50)
, modwhen datetime
, rate decimal(5,2));
Alter table neo_prod add constraint prod_id primary key (prod_id);
alter table product add constraint prod_id primary key (prod_id);
alter table sales add constraint prod_id primary key (prod_id);
alter table supplier add constraint su_id primary key (su_id);
alter table weekly_inventory add constraint prod_id primary key (prod_id);
