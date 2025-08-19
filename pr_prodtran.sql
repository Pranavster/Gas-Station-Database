drop procedure pr_prodtran;
delimiter $$
create procedure pr_prodtran(p_pid int, p_date date, p_quantity int, p_prod_value decimal(10,2), p_user varchar(50) )
begin
	if (p_date is NULL and p_quantity is NULL and p_prod_value is NULL and p_user is NULL) then
		delete from prod_tran where prod_id = p_pid;
	else
		if (p_quantity > 0 and p_prod_value < 0) then
			select "If quantity is positive value can't be negative";
		elseif ((p_quantity < 0 and p_prod_value > 0) ) then
			select "If quantity is negative value can't be positive";
		elseif (p_prod_value = 0) then
			select "Value can not be 0";  
		else
			if exists(select * from prod_tran where prod_id = p_pid) then
				update prod_tran set prod_date = p_date, quantity = p_quantity, prod_value = p_prod_value, addby =  p_user where prod_id = p_pid;
			else
				insert into prod_tran(prod_id, prod_date, quantity, prod_value, addby) values(p_pid,p_date,p_quantity,p_prod_value,p_user);
			end if;
		end if;
	end if;
end$$
delimiter ;
call pr_prodtran(9,"2025-06-17",23,20.32,"Pranav");
select * from prod_tran;