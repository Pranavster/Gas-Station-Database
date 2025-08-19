drop trigger gas_stn.dl_tr;
delimiter $$
create trigger gas_stn.dl_tr
before delete on gas_stn.dflt
for each row
begin
	if( old.addwhen > "2020-06-28" ) then
		signal SQLSTATE '45000' SET MESSAGE_TEXT = "Can't delete products that are just 5 years old";
	end if;
end$$
delimiter $$