create table weekly_inventory(prod_id int
, weekend_date date
, status_ text
, surplus int
, deficit int);

select * from inventory where prod_id = 23 order by prod_id, asof_date;

create view recent_dates as (select * from (
select *,rank() over (partition by prod_id order by asof_date desc) as asof_date_rank from inventory) as a
where asof_date_rank = 1 order by prod_id, asof_date); #inline view for ea
# inner set becomes source for outer set

update inventory set asof_date = "2024-03-17", curr_quantity = 50 where prod_id = 23 and asof_date = "2024-03-16 11:11:11";

select prod_id,min_quantity,max_quantity, max(asof_date) from inventory group by prod_id;# group by prod_id order by asof_date limit 1;

