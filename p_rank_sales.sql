select * from sales;
drop procedure p_rank_sales;
delimiter $$
create procedure p_rank_sales(from_date varchar(7),to_date varchar(7))
begin
	declare year_from_str varchar(4);
    declare month_from_str varchar(2);
    declare year_to_str varchar(4);
    declare month_to_str varchar(2);
    
    set year_from_str = substring(from_date,1,4);
    set month_from_str = substring(from_date,6,2);
    
    set year_to_str = substring(to_date,1,4);
    set month_to_str = substring(to_date,6,2);
    
    select year(prod_date), month(prod_date), sum(total_prod_cost), rank() over(order by sum(total_prod_cost) desc) 
    sales_amt from sales where(substring(cast(prod_date as char),1,4) like year_str and 
    substring(cast(prod_date as char),6,2) = month_str)
    group by year(prod_date), month(prod_date) order by sales_amt;
	-- select year(prod_date), month(prod_date), sum(total_prod_cost)
    -- , rank() over(order by total_prod_cost desc) sales_amt from sales 
    -- where substring(cast(prod_date as varchar(10) ),1,4) = year_str and 
    -- substring(cast(prod_date as varchar(10)),6,2) = month_str
    -- group by year(prod_date), month(prod_date) order by sales_amt;
end $$
delimiter ;