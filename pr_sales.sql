select * from sales;
drop procedure pr_sales;
delimiter $$
create procedure pr_sales(p_pid int, p_date date, p_quantity int, p_prod_value decimal(10,2), p_user varchar(50), p_rate decimal(10,2))
begin
	if (p_date is NULL and p_quantity is NULL and p_prod_value is NULL and p_user is NULL and p_rate is NULL) then
		delete from sales where prod_id = p_pid;
	else
		if (p_quantity > 0 and p_prod_value < 0) then
			select "If quantity is positive value can't be negative";
		elseif ((p_quantity < 0 and p_prod_value > 0) ) then
			select "If quantity is negative value can't be positive";
		elseif (p_prod_value = 0) then
			select "Value can not be 0";  
		else
			if exists(select * from sales where prod_id = p_pid) then
				update sales set prod_date = p_date, quantity = p_quantity, prod_value = p_prod_value, addby = p_user, rate = p_rate where prod_id = p_pid;
			else
				insert into sales(prod_id, prod_date, quantity, prod_value, addby, rate) values(p_pid,p_date,p_quantity,p_prod_value,p_user,p_rate);
			end if;
		end if;
	end if;
end$$
delimiter ;
call pr_sales(9,NULL,NULL,NULL,NULL,NULL);

call pr_sales(9,"2025-06-17",23,20.32,"Pranav",10.32);
select * from sales;

