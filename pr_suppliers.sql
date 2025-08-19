drop procedure pr_suppliers;
delimiter $$

create procedure pr_suppliers(p_supid int, p_supname varchar(50), p_supaddr varchar(50), p_supemail varchar(50), p_supphone bigint, p_effdate date, p_expdate date)
begin
	if(p_supname is NULL and p_supaddr is NULL and p_supemail is NULL and p_supphone is NULL and p_effdate is NULL and p_expdate is NULL) then
		delete from supplier where su_id = p_supid;
	else
		# replace cs_id in order table with su_id;
        if (select p_supaddr from suppliers where p_supaddr in customers and cs_id is not p_supid)
			update customer set cs_id = p_supid;
        # replace cs_id in prc_order with su_id # message
        
        # prc_order check 4 su_id + prod_id info
        
		if exists(select * from suppliers where su_id = p_supid) then
			update suppliers set su_name = p_supname, su_addr = p_supaddr, su_email = p_supemail, su_phone = p_supphone, eff_date = p_effdate, exp_date = p_expdate;
		else
			insert into suppliers values(p_supid,p_supname,p_supaddr,p_supemail,p_supphone,p_effdate,p_expdate);
		end if;
	end if;
end$$
delimiter ;