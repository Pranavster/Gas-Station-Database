/*
supplier: supplier info
--------
su_id
su_name
su_addr
su_email
su_phone
eff_date
exp_date


replace the cs_id in order table with su_id
replace the cs_id in the prc_order with su_id and the appropriate message
in the prc_order,  it should check for the valid su_id info and also the valid prod_id info
	can't order product that does not exist 
*/
alter table sales_order rename column cs_id to su_id;
drop procedure prc_orders;
delimiter $$
CREATE PROCEDURE prc_orders(p_suid int, p_orid int, p_orderdate date, p_shipdate date, p_ordstat date)
begin
	if p_orid is NULL then #prodict is required
		select "Order id can not be null";
	else
		if (p_suid is NULL and p_orderdate is NULL and p_shipdate is NULL and p_ordstat is NULL) then
			delete from prc_order where or_id = p_orid ;
		elseif not exists(select * from supplier where su_id = p_suid) then
			select concat("Supplier ", p_suid," does not exist");
		else
			if exists(select * from sales_order where or_id = p_orid and su_id = p_suid) then
				update sales_order set su_id = p_suid, order_date = p_orderdate, shipping_date = p_shipdate, order_status = p_ordstat where or_id = p_orid;
			else 
				insert into sales_order(su_id, or_id, order_date, shipping_date, order_status) values(p_suid, p_orid, p_orderdate, p_shipdate, p_ordstat);
			end if;
		end if;
	end if;
end$$
delimiter ;

call prc_orders(1, 1, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(2, 2, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(3, 3, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(4, 4, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(5, 5, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(6, 6, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(7, 7, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(8, 8, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(9, 9, "2025-02-14", "2025-03-14", "2025-04-14");
call prc_orders(10, 10, "2025-02-14", "2025-03-14", "2025-04-14");
