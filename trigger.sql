# trigger is a program object linked to a table which means that if you try to manipulate the table like insert/update/delete the trigger is automatically invoked;
desc product;#trigger effective date when product is added into the table and addwhen is active
delimiter $$
Create trigger gas_stn.update_addwhen 
before insert on product
for each row
begin 
	set new.addwhen = sysdate();
end;$$
delimiter ;
select * from product;#triggers are rarely used on procedures

call pr_product(22,"Microphone","Musical Instrument","2025-06-16","1928-06-16","Ethan",NULL,"Josh","2097-06-18 12:22:22",34.12);
#trigger should delete invalid add_when values
use test;
select name,type_desc from gas_stn.triggers;

select * from supplier;
select * from supply_order;


delete from gas_stn.product where exp_dt = "1928-06-16";

select * from gas_stn.product where exp_dt = "1928-06-16";

drop trigger gas_stn.prevent_invalid_expdate;
SHOW TRIGGERS from gas_stn;



select * from inventory;
select * from supply_order;
update supply_order set order_date = "2025-02-15" where or_id = 9999;

select * from supply_order_product;
insert into supply_order(su_id, or_id, order_date, shipping_date, order_status, order_amount) values(2,2,'2025-03-14','2025-03-15',null,1000);
insert into supply_order_product(or_id, prod_id, rate, order_qty, order_value, delivery_qty, delivery_date, delivery_value, status_) values(1,1,23.33,23,536.59,20,'2025-03-14',99,"Surplus"),(2,2,23.33,33,769.89,20,'2025-03-14',99,"Surplus");-- ,(3,3,10,33,330.00,20,'2025-03-14',99,"Surplus");