create table weekly_inventory(prod_id int
, weekend_date date
, status_ text
, surplus int
, deficit int);
select asof_date from inventory order by asof_date;
create view "stat_view" as (select curr_quantity from inventory);
select * from status_update_view;
delimiter $$
create procedure p_quantity_status_update(p_prod_id int, p_asofdate date)
begin
	if (dayname(p_asofdate) != "Saturday") then
		select "run only on Saturday, today is " + dayname(p_asofdate);
	else
		create view status_update_view as 
        select curr_quantity, max_quantity, min_quantity 
        from inventory 
        where asof_date = (select asof_date from inventory order by asof_date limit 1); #read from the inventory for every product only for the latest asof_date
		declare @cursor_id int;
        declare cur_test cursor cur_quan for select curr_quantity from status_update_view;
        open cur_test fetch next from cur_test into @cursor_id;
        while @@fetch_status = 0
        begin
			if cur_quan < (select min_quantity from inventory) then
				update inventory set status_ = "deficient", deficit = min_quantity - cur_quan  where curr_quantity = cur_quan;
			else if cur_quan > (select max_quantity from inventory) then
				update inventory set status_ = "surplus",surplus = cur_quan - max_quantity where curr_quantity = cur_quan;
			else
				update inventory set status_ = "default", where curr_quantity = cur_quan;
        end;
    end if;
end$$
delimiter ;
    
	
        