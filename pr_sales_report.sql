drop procedure pr_sales_report;
delimiter $$
create procedure pr_sales_report(from_date date, to_date date)
begin
	select s.*, p.prod_name, p.prod_type from sales s join product p on s.prod_id = p.prod_id where (s.addwhen >= from_date and s.addwhen <= Date_add(to_date, interval 1 day) );
end$$
delimiter ;