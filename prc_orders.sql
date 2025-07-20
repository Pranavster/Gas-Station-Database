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
			if exists(select * from supply_order where or_id = p_orid and su_id = p_suid) then
				update supply_order set su_id = p_suid, order_date = p_orderdate, shipping_date = p_shipdate, order_status = p_ordstat where or_id = p_orid;
			else 
				insert into supply_order(su_id, or_id, order_date, shipping_date, order_status) values(p_suid, p_orid, p_orderdate, p_shipdate, p_ordstat);
			end if;
		end if;
	end if;
end$$
delimiter ;

alter table customer add column card_num numeric(16,0);
alter table customer rename column credit_card to card_num;

alter table customer add column card_type char(1);

alter table product add column rate decimal(5,2);
#if you want multiple cards you would need a new table for storing cards

#1)most frequent bought products
#2)least frequently bought products
#3)

#sales should only accept prod_id, quantity, addby(user) insert->addby/addwhen update->modby/modwhen
#product rate<-product table 

# value = rate * quantity
call pr_sales(1,"2002-02-23",23,"Umer");