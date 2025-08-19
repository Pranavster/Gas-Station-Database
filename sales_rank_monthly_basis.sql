CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `sales_rank_monthly_basis`(from_year_month varchar(7),to_year_month varchar(7))
begin
	declare v_date_from datetime;
    declare v_date_to datetime;
	
    set v_date_from = str_to_date(concat(from_year_month,"-01"), "%Y-%m-%d");
    set v_date_to =  str_to_date(concat(to_year_month,"-01"), "%Y-%m-%d");
    set v_date_to =  date_add(v_date_to,interval 1 month);
    select v_date_from, v_date_to;

    select year_month_,Total_sales_per_month, rank() Over ( order by Total_sales_per_month desc) as sales_rank
	from (
	select date_format(addwhen, "%Y-%m") as year_month_, sum(total_prod_cost) Total_sales_per_month from sales 
    where addwhen >= v_date_from and addwhen < v_date_to
		group by date_format(addwhen, "%Y-%m") having Total_sales_per_month > 400
	) a  ;

end

year_month_ Total_sales_per_month sales_rank
2025-08		481.00					1
2025-01		444.33					2