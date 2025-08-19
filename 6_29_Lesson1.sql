select * from sales; # everytime quantity entered 
select * from product;
call gas_stn.pr_sales(1,"2025-02-28",23,"Pranav");

delimiter $$
declare v_rate decimal(10,2);
select v_rate = rate from product where prod_id = 1;
select v_rate;
# select cast(23 as decimal(5,2)) abc;

# select 5.33 * 23;
select v_rate;
delimiter $$
desc product;
select count(*) from product;