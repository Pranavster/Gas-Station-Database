delimiter $$
create procedure p_supplier(p_suid int, p_suname varchar(50), p_suaddr varchar(50), p_suemail varchar(50), p_suphone bigint, p_effdate date, p_expdate date)

begin
	if (p_suname is NULL and p_suaddr is NULL and p_suemail is NULL and p_suphone is NULL and p_effdate is NULL and p_expdate is NULL) then
		delete from supplier where su_id = p_suid;
	else
		if exists(select cs_id from sales_order where order_date = p_effdate) then
			update sales_order set cs_id = p_suid;
		elseif exists(select * from supplier where su_id = p_suid) then
			update supplier set su_name = p_suname, su_addr = p_suaddr, su_email = p_suemail, su_phone = p_suphone, eff_date = p_effdate, exp_date = p_expdate;
		else
			insert into supplier values(p_suid,p_suname,p_suaddr,p_suemail,p_suphone,p_effdate,p_expdate);
		end if;
	end if;
end$$
delimiter ;

select * from sales_order;