drop trigger gas_stn.supply_order_status;

#.triggers where trigger_schema = "your_schema";
delimiter $$
create trigger gas_stn.supply_order_status
before update on gas_stn.supply_order
for each row
begin
	/*if(select curr_quantity from inventory i where i.curr_quantity > i.max_quantity  ) then
		set old.order_status = "Surplus";
	else if(select curr_quantity from inventory i where i.curr_quantity < i.min_quantity  ) then
		set old.order_status = "Deficit";
	else 
		set old.order_status = "Default";
	end if;*/
    set new.order_status = "Default";
end;
delimiter ;