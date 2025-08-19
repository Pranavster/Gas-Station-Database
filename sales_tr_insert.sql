drop trigger gas_stn.sales_tr;
delimiter $$
create trigger gas_stn.sales_tr
before insert on gas_stn.sales
for each row
begin
	#declare v_quantity decimal(10,2);
	declare v_rate decimal(10,2);
    declare v_value decimal(10,2);#take rate use quantity set the value
    select cast(rate as decimal(10,2)) into v_rate from gas_stn.product where prod_id = p_pid;
    select v_rate * cast(new.quantity as decimal(5,2)) into v_value;
    select v_value, v_rate;
    set new.prod_value = v_value;
end   
delimiter $$# trigger is written on sales table and you want to read from column in sales table