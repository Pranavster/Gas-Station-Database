delimiter $$
create procedure p_quantity_status_update(p_asofdate date)#no need for prod_id
begin
	declare done int default 0;
	declare v_cur_quan int;
	declare v_min_quan int;
	declare v_max_quan int;
    declare v_pid int;
    declare invCursor cursor for select curr_quantity, min_quantity, max_quantity, prod_id from inventory;
	declare continue handler for not found set done = 1; # keep handler open, that says done = 1 
    open invCursor;
    if (dayname(p_asofdate) != "Saturday") then
		select "run only on Saturday, today is " + dayname(p_asofdate);
	else
		-- else -- variables are not typically declared in else conditions       
		read_loop: LOOP
			fetch invCursor into v_cur_quan, v_min_quan, v_max_quan, v_pid;
			if done then
				leave read_loop;
			end if;
            if exists(select prod_id from weekly_inventory where prod_id = v_pid and weekend_date = p_asofdate) is False then
				-- select "Product is not in weekend inventory";
				insert into weekly_inventory(prod_id, weekend_date, status_, surplus, deficit) values(v_pid,p_asofdate,"default",0,0);
			end if;
            
			if (v_cur_quan > v_max_quan) then
				update weekly_inventory set status_ = "surplus", surplus = v_cur_quan - v_max_quan, deficit = 0 where prod_id = v_pid and weekend_date = p_asofdate; 
			elseif (v_cur_quan < v_min_quan) then
				update weekly_inventory set status_ = "deficit", deficit = v_min_quan - v_cur_quan, surplus = 0 where prod_id = v_pid and weekend_date = p_asofdate; 
			else
				update weekly_inventory set status_ = "default" where prod_id = v_pid and weekend_date = p_asofdate;
			end if;
		END LOOP;
    end if;
	close invCursor;
end$$
delimiter ;
#source is inventory table and target is weekly_inventory tblsales_order

