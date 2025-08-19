drop trigger gas_stn.products;

delimiter $$
create trigger gas_stn.prevent_invalid_expdate
before delete on product
for each row
begin
	if old.exp_dt < old.eff_dt then
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = "Product can't be retired before it is created";
	end if;
end$$
delimiter ;