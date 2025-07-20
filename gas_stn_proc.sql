drop procedure pr_product;
delimiter $$ 
create procedure pr_product(p_pid int, p_pname varchar(50), p_ptype varchar(50), 
p_eff_dt date, p_exp_dt date, p_addby varchar(50), p_addwhen DATETIME, p_modby varchar(50), p_modwhen DATETIME)
begin
	if(p_pname is NULL and p_ptype is NULL and p_eff_dt is NULL and p_exp_dt is NULL and p_addby is NULL and p_addwhen is NULL and p_modby is NULL and p_modwhen is NULL) then
		delete from product where prod_id = p_pid;
	-- if (select phone_no from customer where phone_no REGEXP '^[A-Za-z]+$') is False then
	-- 	Select Concat("Phone number ", phone_no, " is invalid");
	-- end if;
	else
		if exists(select * from product where prod_id = p_pid) then
			update pr_product set prod_id = p_pid, prod_name = p_pname, prod_type = p_ptype, 
            eff_dt = p_eff_dt, exp_dt = p_exp_dt, addby = p_addby, addwhen = p_addwhen, modby = p_modby, modwhen = p_modwhen where prod_id = p_pid;
		else
			insert into product(prod_id,prod_name,prod_type,eff_dt,exp_dt,addby,addwhen,modby,modwhen) 
            values(p_pid,p_pname,p_ptype,p_eff_dt,p_exp_dt,p_addby,p_addwhen,p_modby,p_modwhen);
		end if;
	end if;
end$$
delimiter ;
delimiter $$
    

call pr_product(30,"Football","Sport Equipment","2025-06-16","2128-06-16", "G", "2025-06-18 12:22:22", "Madan", "2097-06-18 12:22:22");
call pr_product(30,NULL,NULL,NULL,NULL,NULL, NULL, NULL, NULL);

select * from product;
