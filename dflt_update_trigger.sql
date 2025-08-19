delimiter $$
create trigger gas_stn.dflt_tr
before update on gas_stn.dflt
for each row
begin
	set new.modwhen = Current_date();
end$$
delimiter $$