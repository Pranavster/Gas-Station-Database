drop procedure p_discount_premium;
delimiter $$
create procedure p_discount_premium(p_prod_id int, p_currmonth varchar(7),p_dp_type char(1),p_dp_perc decimal(2),p_applicable char(1), p_addby varchar(50), 
p_addwhen datetime, p_modby varchar(50), p_modwhen datetime)
begin
	if (p_prod_id is NULL and p_dp_type is NULL) then
		delete from discout_premium where currmonth = p_currmonth and dp_perc = p_dp_perc and applicable = p_applicable 
        and addby = p_addby and addwhen = p_addwhen and modby = p_modby and modwhen = p_modwhen;
	else 
		if exists(select * from discount_premium where prod_id = p_prod_id and dp_type = p_dp_type) then
			update discount_premium set curr_month=p_currmonth and dp_perc = p_dp_perc and applicable = p_applicable and addby = p_addby and addwhen = p_addwhen and
            modby = p_modby and modwhen = p_modwhen;
		else
			insert into discount_premium(prod_id,curr_month, dp_type, dp_perc, applicable, addby, addwhen, modby, modwhen) 
            values (p_prod_id,p_currmonth,p_dp_type,p_dp_perc,p_applicable,p_addby, p_addwhen, p_modby, p_modwhen);
		end if;
	end if;
end$$
delimiter ;