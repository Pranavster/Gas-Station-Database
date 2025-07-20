alter table supply_order drop order_qty; # child table 
drop procedure p_sop;
delimiter $$
create procedure p_sop(p_orid int,p_pid int,p_order_qty int,p_delivery_qty int,p_delivery_date date)

begin
	declare v_rate decimal(5,2);
    declare v_order_value decimal(7,2);
    declare v_delivery_value decimal(7,2);
    declare dummy int;
    select rate into v_rate from product where prod_id = p_pid;
    select v_order_value = v_rate * p_order_qty;
    select v_delivery_value = v_rate * p_delivery_qty;
    
	if exists(select p_pid from product) is False then
		select concat("Product ",p_pid," does not exist");
	elseif exists(select p_orid from sales) is False then
		select concat("Order ",p_orid," does not exist");
	else
		if (p_order_qty is NULL and p_delivery_qty is NULL and p_delivery_date is NULL) then
			delete from supply_order_product where or_id = or_id and prod_id = p_pid;
		else
			set dummy = 1;
			if exists(select delivery_qty from supply_order_product where or_id = p_orid and prod_id = p_pid) is False then
				insert into supply_order_product(or_id,prod_id,rate,order_qty,delivery_qty,delivery_date,delivery_value,status_) 
				values(p_orid,p_pid,v_rate,p_order_qty,p_delivery_qty,p_delivery_date,v_delivery_value,"PENDING");
			elseif v_delivery_value != v_order_value then
				update supply_order_product set or_id = p_orid, prod_id = p_pid, rate = v_rate, order_qty = p_order_qty, 
				delivery_qty = p_delivery_qty, delivery_date = p_delivery_date, delivery_value = v_delivery_value, status_ = "PARTIAL_DELIVERY";
			else
				if v_delivery_value = v_order_value then
					update supply_order_product set or_id = p_orid, prod_id = p_pid, rate = v_rate, order_qty = p_order_qty, 
					delivery_qty = p_delivery_qty, delivery_date = p_delivery_date, delivery_value = v_delivery_value, status_ = "FULL_DELIVERY";
				end if;
			end if;
		end if;
	end if;
end $$
delimiter ;
update product set rate = 9.99 where prod_id = 30;
select * from sales;
call pr_product(2,"Baseball","Sport Equipment","2025-06-16","2128-06-16","Madan","2025-06-18 12:22:22","G","2097-06-18 12:22:22",5.33);
call pr_product(3,"Cricket bat","Sport Equipment","2025-06-16","2128-06-16","Krishnan","2025-06-18 12:22:22","Arup","2097-06-18 12:22:22",5.34);
call pr_product(4,"Pen","Study Tools","2025-06-16","2128-06-16","Sumanth","2025-06-18 12:22:22","Dixie","2097-06-18 12:22:22",5.35);
call pr_product(5,"Book","Study Tools","2025-06-16","2128-06-16","Sal","2025-06-18 12:22:22","Jim","2097-06-18 12:22:22",5.36);
call pr_product(6,"Rubber band","Sport Equipment","2025-06-16","2128-06-16","Edward","2025-06-18 12:22:22","Suresh","2097-06-18 12:22:22",5.37);
call pr_product(7,"Cup","Kitchen Equipment","2025-06-16","2128-06-16","Mario","2025-06-18 12:22:22","Mustafa","2097-06-18 12:22:22",5.38);
call pr_product(8,"Mug","Kitchen Equipment","2025-06-16","2128-06-16","Eskinder","2025-06-18 12:22:22","G","2097-06-18 12:22:22",5.39);
call pr_product(9,"Notebook","Sport Equipment","2025-06-16","2128-06-16","Naren","2025-06-18 12:22:22","Ranvika","2097-06-18 12:22:22",5.40);
call pr_product(10,"Fridge","Kitchen Equipment","2025-06-16","2128-06-16","Geeetha","2025-06-18 12:22:22","Adyanth","2097-06-18 12:22:22",5.41);
call pr_product(11,"Baseball","Sport Equipment","2025-06-16","2128-06-16","Madan","2025-06-18 12:22:22","G","2097-06-18 12:22:22",5.42);
call pr_product(12,"Cricket bat","Sport Equipment","2025-06-16","2128-06-16","Krishnan","2025-06-18 12:22:22","Arup","2097-06-18 12:22:22",5.43);
call pr_product(13,"Cricket bat","Sport Equipment","2025-06-16","2128-06-16","Krishnan","2025-06-18 12:22:22","Arup","2097-06-18 12:22:22",5.44);
call pr_product(14,"Pen","Study Tools","2025-06-16","2128-06-16","Sumanth","2025-06-18 12:22:22","Dixie","2097-06-18 12:22:22",5.45);
call pr_product(15,"Book","Study Tools","2025-06-16","2128-06-16","Sal","2025-06-18 12:22:22","Jim","2097-06-18 12:22:22",5.56);
call pr_product(16,"Rubber band","Sport Equipment","2025-06-16","2128-06-16","Edward","2025-06-18 12:22:22","Suresh","2097-06-18 12:22:22",52.34);
call pr_product(17,"Cup","Kitchen Equipment","2025-06-16","2128-06-16","Mario","2025-06-18 12:22:22","Mustafa","2097-06-18 12:22:22",54.38);
call pr_product(18,"Mug","Kitchen Equipment","2025-06-16","2128-06-16","Eskinder","2025-06-18 12:22:22","G","2097-06-18 12:22:22",52.12);
call pr_product(19,"Notebook","Sport Equipment","2025-06-16","2128-06-16","Naren","2025-06-18 12:22:22","Ranvika","2097-06-18 12:22:22",25.40);
call pr_product(20,"Fridge","Kitchen Equipment","2025-06-16","2128-06-16","Geeetha","2025-06-18 12:22:22","Adyanth","2097-06-18 12:22:22",53.41);
call p_sop(1,30,32,2,"2025-02-14");

call sales(10,"2015-01-01",1,10.22,"BB","2025-06-18 12:22:22","BBB","2025-06-19 12:22:22",10.33);