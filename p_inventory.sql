

call p_inventory(43,89, "2024-03-16");
select * from inventory;

select * from product;

alter table inventory modify column entered_date datetime;
alter table inventory drop column inventory_id;

update inventory set max_quantity = 100, min_quantity = 0 where prod_id = 43;

call pr_prodtran(20,"2025-06-16",43, "Madan","2097-06-18 12:22:22");
drop table inventory;

insert into inventory(prod_id, curr_quantity, max_quantity, min_quantity, entered_date, asof_date) values(23,37,55,12,sysdate(),"2024-03-16 11:11:11"),(24,38,55,12,sysdate(),"2024-03-17 11:11:11"),(26,38,55,12,sysdate(),"2024-03-18 11:11:11"),(27,39,55,12,sysdate(),"2024-03-18 11:11:11"),(24,78,55,12,sysdate(),"2024-03-21 11:11:11"),(28,88,55,12,sysdate(),"2024-03-19 11:11:11"),(27,39,55,12,sysdate(),"2026-09-18 11:11:11"),(29,88,55,12,sysdate(),"2024-04-19 12:12:12"),(29,39,55,12,sysdate(),"2026-11-18 11:01:10"),(20,39,55,12,sysdate(),"2026-11-18 06:01:10");
select * from inventory;
update inventory set max_quantity = 55, min_quantity = 12 where 1=1; 